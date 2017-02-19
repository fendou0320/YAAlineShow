//
//  YAAlinShowPlayView.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/18.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAHotCellModel.h"
@interface YAAlinShowPlayView : UICollectionViewCell

@property(nonatomic, strong)UIImageView *defaultImageView;
@property(nonatomic, strong)YAHotCellModel *cellModel;
@property(nonatomic, strong)UIViewController *presenVC;

@end
