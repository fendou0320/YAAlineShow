//
//  YAAlineShowBottomToolView.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/10/13.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YAAlineShowBottomToolViewType){
    ALiveToolTypePublicTalk,
    ALiveToolTypePrivateTalk,
    ALiveToolTypeGift,
    ALiveToolTypeRank,
    ALiveToolTypeShare,
    ALiveToolTypeClose
};
@interface YAAlineShowBottomToolView : UIView

@property(nonatomic, copy)void(^AliveToolButtonType)(YAAlineShowBottomToolViewType toolViewType);

@end
