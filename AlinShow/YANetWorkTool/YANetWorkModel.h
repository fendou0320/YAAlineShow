//
//  YANetWorkModel.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/15.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YANetWorkModel : NSObject

@property(nonatomic, copy)NSString *code;
@property(nonatomic, strong)NSArray *data;
@property(nonatomic, copy)NSString *msg;

@end

@interface YANetWorkDisctionaryModel :NSObject

@property(nonatomic, copy)NSString *code;
@property(nonatomic, strong)NSDictionary *data;
@property(nonatomic, copy)NSString *msg;

@end
