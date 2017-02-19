//
//  YAHotestShowController.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/10.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YAHotestShowController.h"
#import "YAHotTableViewAdapter.h"
#import "UITableView+YAAdapter.h"
#import "YABannerView.h"
#import "YAAlinShowPlayViewController.h"

static CGFloat TableViewHeaderHeight = 100.0;
@interface YAHotestShowController()

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)YABannerView *bannerVIew;
@property(nonatomic, strong)YAHotTableViewAdapter *hotTableViewAdapter;
@property(nonatomic, assign)NSUInteger currentPage;

@end
@implementation YAHotestShowController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setPropertySetts];
    [self createView];
    [self resetSize];
    [self requestBannerSource];
    [self requestPlayStreamSource];
}
- (void)setPropertySetts
{
    weakSelf(weakself);
    self.currentPage = 1;
    self.tableView.mj_header = [YARefreshGitHeader headerWithRefreshingBlock:^{
        weakself.currentPage = 1;
        [weakself requestBannerSource];
        [weakself requestPlayStreamSource];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [weakself requestPlayStreamSource];
    }];
    self.tableView.mj_footer.hidden = YES;
  

}
- (void)createView
{
    [self.view addSubview:[self tableView]];
    [self showGifLoding:nil inView:nil];
}
-(void)resetSize
{
 
}
//请求轮播图
-(void)requestBannerSource
{
   [[YANetWorkConnect shareNetWorkConnect] getHotHomePageBannerData:^(NSArray *hotBannerModelArray, NSString *responsCode) {
       
       if ([responsCode integerValue] == YANETWORKSUCCESS) {
           if (hotBannerModelArray.count > 0) {
               [self.bannerVIew setBannerSource:hotBannerModelArray];
           }
           
       }else{
           [YACommonOperation showTowstString:[NSString stringWithFormat:@"请求轮播图失败:%@",responsCode]];
       }
       
   } failData:^(NSError *error) {

   }];
}
//请求直播主播信息
-(void)requestPlayStreamSource
{
    
    weakSelf(weakself);
    [[YANetWorkConnect shareNetWorkConnect] getHotHomePageCurrentPage:self.currentPage CellData:^(NSArray *hotCellModelArray, NSString *responsCode) {
        if ([responsCode integerValue] == YANETWORKSUCCESS) {
            [self handelAdapterData:hotCellModelArray];
        }else{
            [YACommonOperation showTowstString:[NSString stringWithFormat:@"请求直播流失败:%@",responsCode]];
            weakself.currentPage == 1?weakself.currentPage --:(weakself.currentPage = 1);
        }
        [self hideGufLoding];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    } failData:^(NSError *error) {
        [self hideGufLoding];
         weakself.currentPage == 1?weakself.currentPage --:(weakself.currentPage = 1);
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}
-(YABannerView *)bannerVIew
{
    if (!_bannerVIew) {
        YABannerView *bannerView = [[YABannerView alloc] initWithFrame:CGRectMake(0, 0, ALinScreenWidth, TableViewHeaderHeight)];
        bannerView.YABannerViewBlock = ^(YAHotBannerModel *hotBannerModel){
            [YAWebViewController showWebViewController:self webViewTitle:hotBannerModel.title webViewUrl:hotBannerModel.link];
        };
        _bannerVIew  = bannerView;
    }
    return _bannerVIew;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _hotTableViewAdapter   = [[YAHotTableViewAdapter alloc] init];
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ALinScreenWidth, ALinScreenHeight - 64) style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView setTableViewAdapter:_hotTableViewAdapter];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ALinScreenWidth, 0.1)];
        _tableView = tableView;
        _tableView.tableHeaderView = [self bannerVIew];
 
    }
    return _tableView;
}
-(void)handelAdapterData:(NSArray *)array
{
    weakSelf(weakself)
    _hotTableViewAdapter.didSelectedCell = ^(YAHotTableViewCell *cell,NSIndexPath *indexPath){
        YAAlinShowPlayViewController *alinShowPlayViewController = [[YAAlinShowPlayViewController alloc] init];
        alinShowPlayViewController.showPlayArray = weakself.hotTableViewAdapter.dataSource;
        alinShowPlayViewController.currentPage = weakself.currentPage;
        alinShowPlayViewController.currentIndexPath = indexPath.row;
        [weakself presentViewController:alinShowPlayViewController animated:YES completion:^{
        
        }];
    };
    if (array.count == 0) {
        self.tableView.mj_footer.hidden = YES;
    }else{
        self.tableView.mj_footer.hidden = NO;
    }
    [self.tableView setTableViewAdapter:_hotTableViewAdapter];
    if (self.currentPage == 1) {
         [_hotTableViewAdapter reloadData:array];
    }else{
        [_hotTableViewAdapter apendData:array];
    }
   
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
