//
//  YACommonDefine.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/2.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#ifndef YACommonDefine_h
#define YACommonDefine_h

#define weakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
// 屏幕宽/高
#define ALinScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ALinScreenHeight [UIScreen mainScreen].bounds.size.height

// 颜色相关
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define AlineThemColor Color(216, 41, 116)

#endif /* YACommonDefine_h */
