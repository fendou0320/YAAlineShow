//
//  YAAlinShowPlayViewController.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/18.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YAAlinShowPlayViewController.h"
#import "YAAlinShowPlayView.h"

static NSString *cellIdentifier = @"YAAlinShowPlayCollectionViewCell";
@interface YAAlinShowPlayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView  *showPlayCollectionView;
//@property(nonatomic, assign)BOOL isScrollTo;
@property(nonatomic, assign)BOOL isNeedRefresh;


@end

@implementation YAAlinShowPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self afterView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    if (_showPlayCollectionView) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndexPath inSection:0];
        [_showPlayCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }
}
- (void)afterView
{
    _isNeedRefresh = YES;
    [self.view addSubview:[self showPlayCollectionView]];
}
-(void)resetSize
{
    
}
-(UICollectionView *)showPlayCollectionView
{
    if (!_showPlayCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(ALinScreenWidth, ALinScreenHeight);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.minimumInteritemSpacing = 0.0;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        weakSelf(weakself);
        collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.currentPage++;
            [weakself requestPlayStreamSourceshow];
        }];

        [collectionView registerClass:[YAAlinShowPlayView class] forCellWithReuseIdentifier:cellIdentifier];
        _showPlayCollectionView = collectionView;
    }
    return _showPlayCollectionView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _showPlayArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YAAlinShowPlayView *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (collectionViewCell) {
        collectionViewCell.presenVC = self;
        collectionViewCell.cellModel = self.showPlayArray[indexPath.item];
        self.currentIndexPath = indexPath.item;
    }
    return collectionViewCell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)setCurrentIndexPath:(NSInteger)currentIndexPath
{
    _currentIndexPath = currentIndexPath;

}
//请求直播流数据
-(void)requestPlayStreamSourceshow
{
    self.currentPage ++;
    weakSelf(weakself);
    [[YANetWorkConnect shareNetWorkConnect] getHotHomePageCurrentPage:self.currentPage CellData:^(NSArray *hotCellModelArray, NSString *responsCode) {
        [weakself.showPlayCollectionView.mj_footer endRefreshing];
        if ([responsCode integerValue] == YANETWORKSUCCESS) {
            [weakself handleData:hotCellModelArray];
        }else{
            
            weakself.currentPage == 1?weakself.currentPage --:(weakself.currentPage = 1);
        }
        
    } failData:^(NSError *error) {
        [weakself.showPlayCollectionView.mj_footer endRefreshing];
        weakself.currentPage == 1?weakself.currentPage --:(weakself.currentPage = 1);
    }];
}
-(void)handleData:(NSArray *)hotCellModelArray
{
    if (hotCellModelArray.count > 0) {
        [self.showPlayArray addObjectsFromArray:hotCellModelArray];
        [self.showPlayCollectionView reloadData];
        if (_showPlayCollectionView) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndexPath + 1 inSection:0];
            [_showPlayCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        }
    }else{
        _isNeedRefresh = NO;
        self.currentPage == 1?self.currentPage --:(self.currentPage = 1);
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

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
