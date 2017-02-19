//
//  YABannerView.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/18.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAHotBannerModel.h"

@interface YABannerView : UIView

@property(nonatomic, strong)NSArray *bannerSource;
@property(nonatomic, copy)void(^YABannerViewBlock)(YAHotBannerModel *hotBannerModel);

@end
