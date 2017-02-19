//
//  YAUIFactoryTool.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/2.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YAUIFactoryTool : NSObject
/**
 *  @brief  创建按钮
 *
 *  @param  normalString     normal状态下的按钮文字
 *
 *  @param  selectedString   selected状态下的按钮文字
 *
 *  @param  normalColor      normal状态的字体颜色
 *
 *  @param  selectedColor    selected状态的字体颜色
 *
 *  @param  targert          按钮点击事件的添加对象
 *
 *  @param  selectorName     按钮点击事件SEL
 *
 *  @return
 */
+(UIButton *)setButtonTitle:(NSString *)normalString selectedTitle:(NSString *)selectedString normalTitleColor:(UIColor *)normalColor selectedTitleColor:(UIColor *)selectedColor targert:(id)targert selector:(SEL)selectorName;
/**
 *  @brief  创建按钮
 *  
 *  @param  titleFont        按钮的字体大小
 *
 *  @param  normalString     normal状态下的按钮文字
 *
 *  @param  selectedString   selected状态下的按钮文字
 *
 *  @param  normalColor      normal状态的字体颜色
 *
 *  @param  selectedColor    selected状态的字体颜色
 *
 *  @param  targert          按钮点击事件的添加对象
 *
 *  @param  selectorName     按钮点击事件SEL
 *
 *  @return
 */
+(UIButton *)setButtonFont:(CGFloat)titleFont Title:(NSString *)normalString selectedTitle:(NSString *)selectedString normalTitleColor:(UIColor *)normalColor selectedTitleColor:(UIColor *)selectedColor targert:(id)targert selector:(SEL)selectorName;
/**
 * @brief 创建图片按钮
 *
 * @param buttonImage    按钮显示的图片
 *
 * @param targert          按钮点击事件的添加对象
 *
 * @param selectorName     按钮点击事件SEL
 *
 */
+(UIButton *)setButtonImage:(UIImage *)buttonImage targert:(id)targert selector:(SEL)selectorName;
+(UILabel *)setLabel:(NSString *)labelTitle textColor:(UIColor *)textColor backgroundColor:(UIColor *)backColor titleFont:(CGFloat)titleFont textAlignment:(NSInteger)alignmet;
+(UILabel *)setLabel:(NSString *)labelTitle titleFont:(CGFloat)titleFont textAlignment:(NSInteger)alignmet;

@end
