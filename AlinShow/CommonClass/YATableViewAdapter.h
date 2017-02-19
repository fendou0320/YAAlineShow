//
//  YATableViewAdapter.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/10.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YATableViewAdapter : NSObject<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataSource;
@property(nonatomic, copy)void(^didSelectedCell)(id cell, NSIndexPath* indexpath);

-(void)reloadData:(NSArray *)dataArray;
-(void)apendData:(NSArray *)apendArray;
-(void)setTableView:(UITableView *)tableView;
-(void)cellSelectedMethod:(NSIndexPath *)indexPath;
-(UITableViewCell *)creatTableViewCell:(Class)cellClass tableView:(UITableView *)targetTableView;
-(UITableViewHeaderFooterView *)creatTableViewHeader:(Class)class tableView:(UITableView *)targetTableView;

@end
