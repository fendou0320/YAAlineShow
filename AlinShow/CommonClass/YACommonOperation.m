//
//  YACommonOperation.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/4.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YACommonOperation.h"

@implementation YACommonOperation

+(void)setAppRootViewController:(BOOL)isLogIn
{
      AppDelegate * appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate setRootViewControllerWithWindow:isLogIn];
    
}
/*  颜色转换为image */
+ (UIImage *)createImageWithColor:(UIColor *)color imageRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
+(void)showTowstString:(NSString *)towstString
{
      [[UIApplication sharedApplication].keyWindow makeToast:towstString duration:2.0 position:CSToastPositionCenter];
}
+(void)showTowsString:(NSString *)towsString durationgTime:(CGFloat)durationtime
{
    [[UIApplication sharedApplication].keyWindow makeToast:towsString duration:durationtime position:CSToastPositionCenter];
}
@end
