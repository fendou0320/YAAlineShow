//
//  YAHotTableViewAdapter.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/13.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YAHotTableViewAdapter.h"

@implementation YAHotTableViewAdapter
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YAHotTableViewCell *viewCell = [self.tableView dequeueReusableCellWithIdentifier:@"YAHotTableViewCell"];
    if (!viewCell) {
        viewCell = [[YAHotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YAHotTableViewCell"];
    }
    [viewCell setHotCellModel:self.dataSource[indexPath.row]];
    return viewCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YAHotTableViewCell hotTableViewCellHeight];
}
@end
