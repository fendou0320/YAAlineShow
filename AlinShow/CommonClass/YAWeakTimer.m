//
//  YAWeakTimer.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/22.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YAWeakTimer.h"

@interface YAWeakTimerTarget : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer* timer;

@end

@implementation YAWeakTimerTarget

- (void) weaktimerAction:(NSTimer *)timer {
    if(self.target) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:nil];
#pragma clang diagnostic pop
    } else {
        [self.timer invalidate];
    }
}

@end

@implementation YAWeakTimer

+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)objectTar selector:(SEL)objectSelector userInfo:(id)userInfo repeats:(BOOL)repeats
{
    if (!userInfo) {
        
        userInfo = [NSDictionary dictionaryWithObject:@"YATimer" forKey:@"userInfo"];
    }
    YAWeakTimerTarget *weakTimer = [[YAWeakTimerTarget alloc] init];
    weakTimer.target       = objectTar;
    weakTimer.selector     = objectSelector;
    weakTimer.timer        = [NSTimer timerWithTimeInterval:interval target:objectTar selector:@selector(weaktimerAction:) userInfo:userInfo repeats:repeats];
    return weakTimer.timer;
}


@end
