//
//  YAAlinShowPlayViewController.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/18.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YABaseViewController.h"

@interface YAAlinShowPlayViewController : YABaseViewController

@property(nonatomic, strong)NSMutableArray  *showPlayArray;
@property(nonatomic, assign)NSInteger currentIndexPath;
@property(nonatomic, assign)NSInteger  currentPage;
@property(nonatomic, copy)void(^ScanAlinShow)(NSArray *resultArray);

@end
