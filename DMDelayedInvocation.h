//
//
//  DMDelayedInvocation.h
//  DMDelayedInvocation
//
//  Created by Andrew Gubanov on 03/02/15.
//  Copyright 2015 Andrew Gubanov. All rights reserved.
//
//

@import Foundation;

@interface DMDelayedInvocation : NSProxy
- (instancetype)initWithTarget:(id)aTarget delay:(NSTimeInterval)aDelay messageQueue:(dispatch_queue_t)aQueue;
- (void)invalidate;
@end
