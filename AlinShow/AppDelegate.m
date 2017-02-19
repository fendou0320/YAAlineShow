//
//  AppDelegate.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/7/28.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property(nonatomic, assign)YANETWORKSTATUS currentWorkStauts;
@property(nonatomic, strong)Reachability   *reachability;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window                  = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor  = [UIColor whiteColor];
    [self setRootViewControllerWithWindow:NO];
    [self notificationNetWorkChanged];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)setRootViewControllerWithWindow:(BOOL)isLogIn
{
    if (isLogIn) {
        
        YATabBarController *tabBarController      =  [[YATabBarController alloc] init];
        self.window.rootViewController            =  tabBarController;
        
    }else{
       //判断有无
        YALogInViewController *logInViewController = [[YALogInViewController alloc] init];
        self.window.rootViewController             = logInViewController;
    }
}
-(void)notificationNetWorkChanged
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChangeStauts) name:kReachabilityChangedNotification object:nil];
    _reachability = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    [_reachability startNotifier];

}
-(void)networkChangeStauts
{
   
      YANETWORKSTATUS currentWorks =[YANetWorkHandleTool getNetWorkStatus];
    if (_currentWorkStauts == currentWorks) {
        return;
    }
      NSString       *stautsTip;
    _currentWorkStauts    = currentWorks;
    switch (_currentWorkStauts) {
        case YANETWORKNONE:
            stautsTip = @"当前无网络, 请检查您的网络状态";
            break;
        case YANETWORK2G:
            stautsTip = @"切换到了2G网络";
            break;
        case YANETWORK3G:
            stautsTip = @"切换到了3G网络";
            break;
        case YANETWORK4G:
           stautsTip = @"切换到了4G网络";
            break;
        case YANETWORKWIFI:
            stautsTip = @"";
            break;
        default:
            break;
    }

        if (stautsTip.length > 0) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:stautsTip delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
        }
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
