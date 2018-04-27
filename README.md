# DMDelayedInvocation
Handy tool to manage method invocation to be called only one time per cycle.

## How To Use
``` objc
self.delayedInvocation = [[DMDelayedInvocation alloc] initWithTarget:self delay:0.0f messageQueue:dispatch_get_main_queue()];

- (void)foo
{
    [self.delayedInvocation layoutMyUI];
    [self foo1];
}

- (void)foo1
{
    [self.delayedInvocation layoutMyUI];
}

- (void)layoutMyUI
{
    //as both -foo and -foo1 were called in the same run loop cycle, -layoutMyUI will be called only once
}
```
