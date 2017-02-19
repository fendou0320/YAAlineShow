//
//  YABannerView.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/18.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YABannerView.h"
#import "YABannerCollectionViewCell.h"
#import "YAWeakTimer.h"
@interface YABannerView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *bannerCollectionView;
@property(nonatomic, strong)UIPageControl *bannerpageControl;
@property(nonatomic, strong)NSTimer *bannerTimer;
@property(nonatomic, assign)NSUInteger totalRows;
@property(nonatomic, assign)NSUInteger defaultRow;

@end
@implementation YABannerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
        [self resetSize];
    }
    return self;
}
-(void)creatView
{
    
    [self addSubview:[self bannerCollectionView]];
    [self addSubview:[self bannerpageControl]];
    
    
}
-(void)resetSize
{
    [_bannerpageControl setCenterX:self.width/2];
    [_bannerpageControl setHeight:10.0];
    [_bannerpageControl setBottom:self.height - 10];

}
-(UICollectionView *)bannerCollectionView
{
    if (!_bannerCollectionView) {
        UICollectionViewFlowLayout *bannerLayout = [[UICollectionViewFlowLayout alloc] init];
        bannerLayout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        bannerLayout.itemSize                    = CGSizeMake(ALinScreenWidth, self.height);
        bannerLayout.minimumLineSpacing          = 0.0;
        bannerLayout.minimumInteritemSpacing     = 0.0;
        UICollectionView *bannercollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:bannerLayout];
        bannercollectionView.delegate           = self;
        bannercollectionView.dataSource         = self;
        bannercollectionView.backgroundView     = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeHolder_ad_414x100.png"]];
        bannercollectionView.pagingEnabled      = YES;
        bannercollectionView.showsHorizontalScrollIndicator = NO;
        bannercollectionView.alwaysBounceHorizontal = YES;
        [bannercollectionView registerClass:[YABannerCollectionViewCell class] forCellWithReuseIdentifier:@"YABannerCollectionViewCell"];
        _bannerCollectionView = bannercollectionView;
    }
    return _bannerCollectionView;
}
- (UIPageControl *)bannerpageControl
{
    if (!_bannerpageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.hidesForSinglePage = YES;
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _bannerpageControl = pageControl;
    }
    return _bannerpageControl;
}
- (void)beginTimer
{
    if (_bannerSource.count == 0 || _bannerTimer) {
        return;
    }
    _bannerTimer =  [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextScrollPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_bannerTimer forMode:NSRunLoopCommonModes];
//    _bannerTimer = [YAWeakTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(nextScrollPage) userInfo:nil repeats:YES];

}
- (void)stopTimer
{
    [_bannerTimer invalidate];
    _bannerTimer = nil;
}

- (void)nextScrollPage
{
    //靠近中间位置滚动
    NSIndexPath *visibileIndexPath = [[self.bannerCollectionView indexPathsForVisibleItems] firstObject];
    NSInteger    visibileItem = visibileIndexPath.item;
    if (!visibileItem) {
        return;
    }
    if (visibileItem % _bannerSource.count == 0 ) {
        [_bannerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_defaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        _bannerpageControl.currentPage = 0;
        visibileItem = _defaultRow;
    }
    if (visibileItem == (_totalRows - 1)) {
        [_bannerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_defaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        _bannerpageControl.currentPage = 0;
        visibileItem = _defaultRow;
        return;
    }
        NSInteger nextItem = visibileItem + 1;
        [_bannerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    NSLog(@"%ld",(long)nextItem);
   

}
#pragma mark - UICollectionView
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalRows;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YABannerCollectionViewCell * bannerCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YABannerCollectionViewCell" forIndexPath:indexPath];
   // NSLog(@"%d",indexPath.item);
    NSInteger currentIndex = indexPath.item % _bannerSource.count;
    YAHotBannerModel *model = [self.bannerSource objectAtIndex:currentIndex];
    model.imageUrl?[bannerCollectionCell setImageUrl:model.imageUrl]:[bannerCollectionCell setImageUrl:@""];
    return bannerCollectionCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger selectedItem = indexPath.item % _bannerSource.count;
    if (_YABannerViewBlock) {
        _YABannerViewBlock(self.bannerSource[selectedItem]);
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //处理手动滑动如果滑到最后一个cell的情况
    NSIndexPath *visibileIndexPath = [[self.bannerCollectionView indexPathsForVisibleItems] firstObject];
    NSInteger    visibileItem = visibileIndexPath.item;
    if (!visibileItem) {
        return;
    }
    if (visibileItem == (_totalRows - 1)) {
        [_bannerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_defaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        _bannerpageControl.currentPage = 0;
        visibileItem = _defaultRow;
        return;
    }

}
#pragma mark - UIScrollView
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self beginTimer];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_bannerSource.count > 1) {
        _bannerpageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) % _bannerSource.count;
    }
}
-(void)setBannerSource:(NSArray *)bannerSource
{
    if (bannerSource.count == 0) {
        _bannerCollectionView.scrollEnabled = NO;
        return;
    }else{
        _totalRows = bannerSource.count * 10;
        _defaultRow = _totalRows/2;
        _bannerSource = bannerSource;
        _bannerpageControl.numberOfPages = bannerSource.count;
        _bannerpageControl.currentPage   = 0;
        [_bannerCollectionView reloadData];
        [self.bannerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_defaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self beginTimer];
        if (bannerSource.count == 1) {
             _bannerCollectionView.scrollEnabled = NO;
        }else{
            _bannerCollectionView.scrollEnabled = YES;
        }
    }
   
}


@end
