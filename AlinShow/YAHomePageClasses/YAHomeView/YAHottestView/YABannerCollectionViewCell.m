//
//  YABannerCollectionViewCell.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/2.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YABannerCollectionViewCell.h"

@interface YABannerCollectionViewCell()

@property (nonatomic, strong) UIImageView *bannerImageView;

@end
@implementation YABannerCollectionViewCell
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
    [self.contentView addSubview:[self bannerImageView]];
}
-(void)resetSize
{
    _bannerImageView.frame = CGRectMake(0, 0, self.width, self.height);
}
- (UIImageView *)bannerImageView
{
    if (!_bannerImageView) {
        _bannerImageView = [[UIImageView alloc]init];
        _bannerImageView.contentMode = UIViewContentModeScaleToFill;
        _bannerImageView.clipsToBounds = YES;
    }
    return _bannerImageView;
}
-(void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [_bannerImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeHolder_ad_414x100.png"]];
}
@end
