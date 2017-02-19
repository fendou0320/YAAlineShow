//
//  YANetWorkHandleTool.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/5.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"
#import "YANetWorkModel.h"

typedef NS_ENUM(NSInteger, YANETWORKSTATUS){
    
    YANETWORKNONE = 0, //没有网络
    YANETWORKWIFI,
    YANETWORKWWAN,
    YANETWORK2G,
    YANETWORK3G,
    YANETWORK4G,
    YANETWOKENOTHANDLE,//未知网络
};
@interface YANetWorkHandleTool : AFHTTPSessionManager

+(instancetype)shareNetWorkTool;
+(YANETWORKSTATUS)getNetWorkStatus;
-(void)getURL:(NSString *)string SuccessBlock:(void(^)(YANetWorkModel *netWorkModel))successBlock FailBlock:(void(^)(NSError *error))failBlock;
-(void)getUrl:(NSString *)string SuccessBlock:(void(^)(YANetWorkDisctionaryModel *netWorkModel))successBlock FailBlock:(void(^)(NSError *error))failBlock;



@end
