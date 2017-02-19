//
//  YAThirdchannelsLogInView.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/1.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,ThirdLogInType)
{
    LOGINSINA     =  0,
    LOGINWECHAT   =  1,
    LOGINQQ       =  2,
};
@interface YAThirdchannelsLogInView : UIView

@property(nonatomic, copy)void(^ LogInBlock)(ThirdLogInType logInType);

@end
