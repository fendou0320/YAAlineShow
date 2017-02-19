//
//  YATabBarController.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/3.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YATabBarController.h"
#import "YAHomePageController.h"
#import "YAProfileController.h"
#import "YAShowPageController.h"
#import "YAWalletController.h"
#import "YAUserSettingController.h"
#import "YANavigationController.h"

@implementation YATabBarController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutsettings];
}
-(void)layoutsettings
{
    
    [self settingChildsController:[[YAHomePageController alloc] init] tabBarImage:@"tabBar_home"];
     [self settingChildsController:[[YAProfileController alloc] init] tabBarImage:@"tabBar_profile"];
    [self settingChildsController:[[YAShowPageController alloc] init] tabBarImage:@"tabBar_live"];
    [self settingChildsController:[[YAWalletController alloc] init] tabBarImage:@"tabBar_wallent"];
    [self settingChildsController:[[YAUserSettingController alloc] init]tabBarImage:@"tabBar_me"];
    
    
}
-(void)settingChildsController:(UIViewController *)childController tabBarImage:(NSString *)tabImageName
{
    YANavigationController *navigationController       = [[YANavigationController alloc] initWithRootViewController:childController];
    [navigationController settingThemeColor];
    [navigationController settingThemeTitleFont:14.0 titleColor:[UIColor whiteColor]];
    childController.tabBarItem.image            = [[UIImage imageNamed:tabImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage    = [[UIImage imageNamed:[tabImageName stringByAppendingString:@"_sel"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.imageInsets      = UIEdgeInsetsMake(6, 0, -6, 0);
    [self addChildViewController:navigationController];
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}
@end
