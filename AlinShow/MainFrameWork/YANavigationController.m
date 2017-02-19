//
//  YANavigationBar.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/3.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YANavigationController.h"

@implementation YANavigationController

///设置主题色
-(void)settingThemeColor
{
    UINavigationBar *navigationBar = self.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
}

///设置文字和大小
-(void)settingThemeTitleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor{
    

    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:[UIFont systemFontOfSize:titleFont]};
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        //隐藏导航栏
        viewController.hidesBottomBarWhenPushed = YES;
        // 自定义返回按钮
        UIButton *commonBackButton = [[UIButton alloc] init];
        [commonBackButton setImage:[UIImage imageNamed:@"back_9x16"] forState:UIControlStateNormal];
        [commonBackButton addTarget:self action:@selector(commonBackAction) forControlEvents:UIControlEventTouchUpInside];
        [commonBackButton sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:commonBackButton];
        
        // 如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)commonBackAction
{
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        [self popViewControllerAnimated:YES];
}
@end
