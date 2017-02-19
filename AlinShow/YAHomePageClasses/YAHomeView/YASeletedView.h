//
//  YASeletedView.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/10.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, HomePageType)
{
    HOTTESTSHOW     = 0,//热门
    NEWESTSHOW      = 1,//最新
    ATTENTIONSHOW   = 2,//关注
    
};
@interface YASeletedView : UIView

@property(nonatomic, copy)void(^homeSeletedBlock)(HomePageType pageType);
@property(nonatomic, assign)HomePageType  homePageType;

@end
