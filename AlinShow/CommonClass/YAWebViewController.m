//
//  YAWebViewController.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/15.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YAWebViewController.h"

@interface YAWebViewController ()<UIWebViewDelegate>

/** webView */
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation YAWebViewController
- (UIWebView *)webView
{
    if (!_webView) {
        UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webview.delegate   = self;
        [self.view addSubview:webview];
        _webView = webview;
    }
    return _webView;
}

- (instancetype)initWithUrlStr:(NSString *)url
{
    if (self = [self init]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_imageUrl]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _webView.delegate = nil;
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    _webView = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}
+(void)showWebViewController:(UIViewController *)controller webViewTitle:(NSString *)webViewTitle webViewUrl:(NSString *)webViewurl
{
    YAWebViewController *webViewController = [[YAWebViewController alloc] init];
    webViewController.imageUrl  = webViewurl;
    webViewController.title = webViewTitle;
    [controller.navigationController pushViewController:webViewController animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
