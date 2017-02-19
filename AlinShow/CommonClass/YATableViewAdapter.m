//
//  YATableViewAdapter.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/10.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YATableViewAdapter.h"

@implementation YATableViewAdapter
+(instancetype)init
{
    return [[[self class] alloc] initWithDataSouce:@[]];
}
-(instancetype)initWithDataSouce:(NSArray *)soucearray
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray arrayWithArray:soucearray];
    }
    return self;
}
-(void)reloadData:(NSArray *)dataArray
{
    self.dataSource = [dataArray mutableCopy];
    [self.tableView reloadData];
}
-(void)apendData:(NSArray *)apendArray
{
    [self.dataSource addObjectsFromArray:apendArray];
    [self.tableView reloadData];
}
-(void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    [self afterTableView];
}
-(void)afterTableView
{
    
}
-(void)cellSelectedMethod:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.didSelectedCell) {
        self.didSelectedCell([tableView cellForRowAtIndexPath:indexPath],indexPath);
    }
//    [self cellSelectedMethod:indexPath];
}
-(UITableViewCell *)creatTableViewCell:(Class)cellClass tableView:(UITableView *)targetTableView
{
    UITableViewCell *cell = [targetTableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    if (!cell) {
        cell = [[cellClass alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(cellClass)];
    }
    return cell;
}
-(UITableViewHeaderFooterView *)creatTableViewHeader:(Class)class tableView:(UITableView *)targetTableView
{
    UITableViewHeaderFooterView *headerFooterView = [targetTableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(class)];
    if (!headerFooterView) {
        
    }
    return headerFooterView;
}
@end
