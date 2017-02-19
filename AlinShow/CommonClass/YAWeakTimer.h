//
//  YAWeakTimer.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/22.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAWeakTimer : NSObject

+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)objectTar selector:(SEL)objectSelector userInfo:(id)userInfo repeats:(BOOL)repeats;

@end

