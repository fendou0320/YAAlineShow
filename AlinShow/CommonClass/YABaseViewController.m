//
//  YABaseViewController.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/3.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YABaseViewController.h"

@implementation YABaseViewController
-(void)viewDidLoad
{
    [super viewDidLoad];

}
//自定义返回事件
-(void)changeCommonBackAction
{
    YANavigationController *currentNavigationController = (YANavigationController *)self.navigationController;
    [currentNavigationController commonBackAction];

}
@end
