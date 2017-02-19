//
//  YANetWorkHandleTool.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/5.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YANetWorkHandleTool.h"

@interface YANetWorkHandleTool()

@end
@implementation YANetWorkHandleTool
static YANetWorkHandleTool  *_manager;
+ (instancetype)shareNetWorkTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [YANetWorkHandleTool manager];
        // 设置超时时间
        _manager.requestSerializer.timeoutInterval = 5.f;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _manager;
}

-(void)getURL:(NSString *)string SuccessBlock:(void(^)(YANetWorkModel *netWorkModel))successBlock FailBlock:(void(^)(NSError *error))failBlock
{
    [self GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseObjectDictionary = (NSDictionary *)responseObject;
        YANetWorkModel *networkModel = [YANetWorkModel mj_objectWithKeyValues:responseObjectDictionary];
        if ([networkModel.code isEqualToString:@"100"]) {
           successBlock(networkModel);
        }else{
            [YACommonOperation showTowstString:networkModel.msg];
            successBlock(networkModel);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
        [YACommonOperation showTowstString:@"服务器连接失败"];
        
    }];
}
-(void)getUrl:(NSString *)string SuccessBlock:(void(^)(YANetWorkDisctionaryModel *netWorkModel))successBlock FailBlock:(void(^)(NSError *error))failBlock
{
    [self GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseObjectDictionary = (NSDictionary *)responseObject;
        YANetWorkDisctionaryModel *networkModel = [YANetWorkDisctionaryModel mj_objectWithKeyValues:responseObjectDictionary];
        if ([networkModel.code isEqualToString:@"100"]) {
            successBlock(networkModel);
        }else{
            
            [YACommonOperation showTowstString:networkModel.msg];
            successBlock(networkModel);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
        [YACommonOperation showTowstString:@"服务器连接失败"];
        
    }];

}
+(YANETWORKSTATUS)getNetWorkStatus
{
    
     NSArray *subViews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    YANETWORKSTATUS workStatus = YANETWORKNONE;
    // 保存网络状态
    for (id child in subViews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏码
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    workStatus = YANETWORKNONE;
                    //无网模式
                    break;
                case 1:
                    workStatus = YANETWORK2G;
                    break;
                case 2:
                    workStatus = YANETWORK3G;
                    break;
                case 3:
                    workStatus = YANETWORK4G;
                    break;
                case 5:
                {
                    workStatus = YANETWORKWIFI;
                }
                    break;
                default:
                    break;
            }
        }
    }
    return workStatus;
    
}
@end
