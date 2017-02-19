//
//  UITableView+YAAdapter.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/13.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "UITableView+YAAdapter.h"

@implementation UITableView (YAAdapter)
-(void)setTableViewAdapter:(YATableViewAdapter *)adapter
{
    [self setDelegate:adapter];
    [self setDataSource:adapter];
    [adapter setTableView:self];
    [self reloadData];
}
@end
