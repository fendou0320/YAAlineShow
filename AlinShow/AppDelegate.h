//
//  AppDelegate.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/7/28.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YALogInViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)setRootViewControllerWithWindow:(BOOL)isLogIn;

@end

