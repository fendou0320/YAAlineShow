//
//  YANewestShowController.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/10.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YANewestShowController.h"
#import "YANewstCollectionViewCell.h"
static NSString *newCellIdentifier = @"YANewstCollectionViewCell";

@interface YANewestShowController()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSMutableArray *newestDataSource;
@property(nonatomic, assign)NSInteger currentPage;

@end

@implementation YANewestShowController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setPorities];
    [self afterView];
}
-(void)setPorities
{
    _newestDataSource = [NSMutableArray array];
    [self.view addSubview:[self collectionView]];
    
}
-(void)afterView
{
    weakSelf(weakself);
    _collectionView.mj_header = [YARefreshGitHeader headerWithRefreshingBlock:^{
        weakself.currentPage = 1;
        
    }];
}

-(void)requestNewstLive
{
//    [[YANetWorkConnect shareNetWorkConnect] ]
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _newestDataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YANewstCollectionViewCell *newstCell = [collectionView dequeueReusableCellWithReuseIdentifier:newCellIdentifier forIndexPath:indexPath];
    return newstCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(ALinScreenWidth/3.0, ALinScreenWidth/3.0);
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.minimumLineSpacing = 0.0;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ALinScreenWidth, ALinScreenHeight - 64) collectionViewLayout:flowLayout];
        collectionView.delegate  = self;
        collectionView.dataSource = self;
        collectionView.showsVerticalScrollIndicator = NO;
        [collectionView registerClass:[YANewstCollectionViewCell class] forCellWithReuseIdentifier:newCellIdentifier];
        _collectionView = collectionView;
    }
    return _collectionView;
}
@end
