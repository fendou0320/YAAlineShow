//
//  YAHomePageController.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/3.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YAHomePageController.h"
#import "YAHotestShowController.h"
#import "YANewestShowController.h"
#import "YAAttentionShowController.h"
#import "YAWebViewController.h"
#import "YASeletedView.h"

@interface YAHomePageController()<UIScrollViewDelegate>

@property(nonatomic, strong)YASeletedView *seletedView;
@property(nonatomic, strong)UIScrollView  *scrollView;

@end

@implementation YAHomePageController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setNaviagation];
    //设置self.view 为scrollView
    [self setViewToScrollView];
}
-(void)setNaviagation
{
    [self createNavaigationView];
    [self setNavigationLeftAndRightView];
}
-(void)setNavigationLeftAndRightView
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStyleDone target:self action:@selector(rankCrown)];
}
- (void)rankCrown
{
    YAWebViewController *webController = [[YAWebViewController alloc] initWithUrlStr:RankingH5];
    webController.navigationItem.title = @"排行";
    [self.navigationController pushViewController:webController animated:YES];
    
}
-(void)createNavaigationView
{
    YASeletedView *seletedView = [[YASeletedView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    [seletedView setX:45];
    [seletedView setWidth:ALinScreenWidth - 45*2];
    weakSelf(weakself)
    seletedView.homeSeletedBlock = ^(HomePageType pageType){
        
        [weakself.scrollView setContentOffset:CGPointMake(ALinScreenWidth *pageType, 0) animated:YES];
    };
    _seletedView  = seletedView;
    [self.navigationController.navigationBar addSubview:_seletedView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //加1/2屏幕宽度
    CGFloat changePage = scrollView.contentOffset.x / ALinScreenWidth;
    self.seletedView.homePageType  = (int)(changePage + 0.5);
    
}
-(void)setViewToScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.delegate   = self;
    scrollView.contentSize = CGSizeMake(ALinScreenWidth * 3, 0);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces       = NO;
    self.scrollView          = scrollView;
    self.view                = self.scrollView;
    //添加子视图
    [self createChildsController];
}
-(void)createChildsController
{
    CGFloat height = ALinScreenHeight - 49;
    
    //最热
    YAHotestShowController *hotController = [[YAHotestShowController alloc] init];
    hotController.view.frame = self.view.bounds;
    hotController.view.height = height;
    [self addChildViewController:hotController];
    [self.view addSubview:hotController.view];
    
    //最新
    YANewestShowController *newController = [[YANewestShowController alloc] init];
    newController.view.frame = self.view.bounds;
    newController.view.x = ALinScreenWidth;
    newController.view.height = height;
    [self addChildViewController:newController];
    [self.view addSubview:newController.view];
    
    //关注
    YAAttentionShowController *attentionController = [[YAAttentionShowController alloc] init];
    attentionController.view.frame = self.view.bounds;
    attentionController.view.x = ALinScreenWidth * 2;
    attentionController.view.height = height;
    [self addChildViewController:attentionController];
    [self.view addSubview:attentionController.view];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.view isDescendantOfView:_seletedView]) {
        [self.navigationController.navigationBar addSubview:_seletedView];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated

{
    [super viewWillDisappear:animated];
        [_seletedView removeFromSuperview];
}
@end
