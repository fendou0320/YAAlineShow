//
//  YAHotTableViewCell.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/13.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAHotCellModel.h"
@interface YAHotTableViewCell : UITableViewCell

@property(nonatomic, strong)YAHotCellModel *hotCellModel;
+(CGFloat)hotTableViewCellHeight;

@end
