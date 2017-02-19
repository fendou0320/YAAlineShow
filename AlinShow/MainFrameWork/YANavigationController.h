//
//  YANavigationBar.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/3.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YANavigationController : UINavigationController

///设置主题颜色
-(void)settingThemeColor;
///设置文字颜色和大小
-(void)settingThemeTitleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor;
///通用返回按钮事件
- (void)commonBackAction;

@end
