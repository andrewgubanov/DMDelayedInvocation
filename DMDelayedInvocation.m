//
//
//  DMDelayedInvocation.m
//  DMDelayedInvocation
//
//  Created by Andrew Gubanov on 03/02/15.
//  Copyright 2015 Andrew Gubanov. All rights reserved.
//
//

#import "DMDelayedInvocation.h"

@interface DMDelayedInvocation ()
@property (atomic, strong) NSMutableArray *delayedInvocations;
@property (atomic, weak) id target;
@property (atomic, assign) NSTimeInterval delay;
@property (atomic, weak) dispatch_queue_t queue;
@end

@implementation DMDelayedInvocation

- (instancetype)initWithTarget:(id)aTarget delay:(NSTimeInterval)aDelay messageQueue:(dispatch_queue_t)aQueue
{
    self.target = aTarget;
    self.delay = aDelay;
    self.queue = aQueue;
    self.delayedInvocations = [NSMutableArray array];
    return self;
}

- (void)invalidate
{
    @synchronized (self.delayedInvocations) {
        [self.delayedInvocations removeAllObjects];
    }
    self.target = nil;
    self.delay = 0.0f;
    self.queue = nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    BOOL isRegistered = NO;
    @synchronized (self.delayedInvocations) {
        for (NSInvocation *invocation in self.delayedInvocations) {
            if (invocation.selector == anInvocation.selector) {
                isRegistered = YES;
                break;
            }
        }
        
        if (!isRegistered) {
            [self.delayedInvocations addObject:anInvocation];
        }
    }
    if (!isRegistered) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delay * NSEC_PER_SEC)), self.queue, ^{
            NSInvocation *invocation = nil;
            @synchronized (self.delayedInvocations) {
                if (self.delayedInvocations.count > 0) {
                    invocation = self.delayedInvocations[0];
                    [self.delayedInvocations removeObjectAtIndex:0];
                }
            }
            [invocation setTarget:self.target];
            [invocation invoke];
        });
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *result = nil;
    if (self.target != nil) {
        result = [self.target methodSignatureForSelector:aSelector];
    } else {
        result = [super methodSignatureForSelector:aSelector];
    }
    return result;
}
@end
