//
//  YAWebViewController.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/15.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YABaseViewController.h"

@interface YAWebViewController : YABaseViewController

- (instancetype)initWithUrlStr:(NSString *)url;
@property(nonatomic, copy)NSString *imageUrl;

+(void)showWebViewController:(UIViewController *)controller webViewTitle:(NSString *)webViewTitle webViewUrl:(NSString *)webViewurl;

@end
