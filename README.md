# DMDelayedInvocation
Handy tool to manage method invocation to be called only one time per cycle.

## How To Use
``` objc
self.delayedInvocation = [[DMDelayedInvocation alloc] initWithTarget:self delay:0.0f messageQueue:dispatch_get_main_queue()];

- (void)foo
{
    [self.delayedInvocation layoutMyUI];
}

- (void)foo1
{
    [self.delayedInvocation layoutMyUI];
}

- (void)layoutMyUI
{
    //even if both -foo and -foo1 were called, -layoutMyUI will be called only once
}
```
