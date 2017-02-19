//
//  YACommonOperation.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/4.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YACommonOperation : NSObject

/*
 * @brief 控制登录操作
 *
 * @param isLogIn 是否是登录（YES 根控制器为首页，No根控制器为登录页）
 *
 * @return
*/
+(void)setAppRootViewController:(BOOL)isLogIn;
/*
 * @brief 颜色转换成图片
 *
 * @param color 图片的颜色  rect 图片的尺寸
 *
 * @return 返回一张UIImage
 */
+ (UIImage *)createImageWithColor:(UIColor *)color imageRect:(CGRect)rect;
/*
 * @brief towst提示不带时间
 *
 * @param
 *
 * @return
 */
+(void)showTowstString:(NSString *)towstString;
/*
 * @brief towst提示带时间
 *
 * @param  durationtime 提示时间长短
 *
 * @return
 */
+(void)showTowsString:(NSString *)towsString durationgTime:(CGFloat)durationtime;
@end
