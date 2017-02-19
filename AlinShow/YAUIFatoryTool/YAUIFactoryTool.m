//
//  YAUIFactoryTool.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/2.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YAUIFactoryTool.h"

@implementation YAUIFactoryTool

///有点击事件，按钮颜色状态
+(UIButton *)setButtonTitle:(NSString *)normalString selectedTitle:(NSString *)selectedString normalTitleColor:(UIColor *)normalColor selectedTitleColor:(UIColor *)selectedColor targert:(id)targert selector:(SEL)selectorName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor     =      [UIColor clearColor];
    [button setTitle:normalString        forState:UIControlStateNormal];
    [button setTitle:selectedString      forState:UIControlStateSelected];
    [button setTitleColor:normalColor    forState:UIControlStateNormal];
    [button setTitleColor:selectedColor  forState:UIControlStateSelected];
    [button addTarget:targert action:selectorName forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIButton *)setButtonFont:(CGFloat)titleFont Title:(NSString *)normalString selectedTitle:(NSString *)selectedString normalTitleColor:(UIColor *)normalColor selectedTitleColor:(UIColor *)selectedColor targert:(id)targert selector:(SEL)selectorName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor     =      [UIColor clearColor];
    button.titleLabel.font     =      [UIFont systemFontOfSize:titleFont];
    [button setTitle:normalString        forState:UIControlStateNormal];
    [button setTitle:selectedString      forState:UIControlStateSelected];
    [button setTitleColor:normalColor    forState:UIControlStateNormal];
    [button setTitleColor:selectedColor  forState:UIControlStateSelected];
    [button addTarget:targert action:selectorName forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIButton *)setButtonImage:(UIImage *)buttonImage targert:(id)targert selector:(SEL)selectorName
{
    UIButton  *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage         forState:UIControlStateNormal];
    [button setImage:buttonImage         forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:targert action:selectorName forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UILabel *)setLabel:(NSString *)labelTitle textColor:(UIColor *)textColor backgroundColor:(UIColor *)backColor titleFont:(CGFloat)titleFont textAlignment:(NSInteger)alignmet;
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = backColor;
    label.textAlignment   = alignmet;
    label.textColor       =textColor;
    label.font = [UIFont systemFontOfSize:titleFont];
    label.text = labelTitle;
    return label;
}

+(UILabel *)setLabel:(NSString *)labelTitle titleFont:(CGFloat)titleFont textAlignment:(NSInteger)alignmet
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment   = alignmet;
    label.textColor       = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:titleFont];
    label.text = labelTitle;
    return label;

}
@end
