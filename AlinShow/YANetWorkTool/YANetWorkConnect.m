//
//  YANetWorkConnect.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/15.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YANetWorkConnect.h"
#import "YAHotBannerModel.h"
#import "YAHotCellModel.h"
static YANetWorkConnect *_netWorkConnect;

@interface YANetWorkConnect()

@end
@implementation YANetWorkConnect
+(instancetype)shareNetWorkConnect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _netWorkConnect = [[YANetWorkConnect alloc] init];
    });
    return _netWorkConnect;
}
-(void)getHotHomePageBannerData:(void(^)(NSArray *hotBannerModelArray , NSString *responsCode))successModel failData:(void(^)(NSError * error))failModel
{
   
    [[YANetWorkHandleTool shareNetWorkTool] getURL:BannerUrl SuccessBlock:^(YANetWorkModel *netWorkModel) {
    
        NSArray *dataArray = netWorkModel.data;
         NSArray *resultArray = [NSArray array];
        if (dataArray) {
           
            resultArray = [YAHotBannerModel mj_objectArrayWithKeyValuesArray:dataArray];
            successModel(resultArray,netWorkModel.code);
        }else{
            successModel(resultArray,netWorkModel.code);
        }
        
    } FailBlock:^(NSError *error) {
        failModel(error);
    }];
}
-(void)getHotHomePageCurrentPage:(NSUInteger)currentPage CellData:(void(^)(NSArray *hotCellModelArray , NSString *responsCode))successModel failData:(void(^)(NSError * error))failModel
{
    [[YANetWorkHandleTool shareNetWorkTool] getUrl:HotCellSourceUrl((long)currentPage) SuccessBlock:^( YANetWorkDisctionaryModel *netWorkModel) {
        
        NSArray *dataArray = [netWorkModel.data objectForKey:@"list"];
        NSArray *resultArray = [NSArray array];
        if (dataArray) {
            
            resultArray = [YAHotCellModel mj_objectArrayWithKeyValuesArray:dataArray];
            successModel(resultArray,netWorkModel.code);
        }else{
            successModel(resultArray,netWorkModel.code);
        }

    } FailBlock:^(NSError *error) {
        failModel(error);
    }];
    
}
-(void)getNewstPageCurrentPage:(long)currentPage cellData:(void(^)(NSArray *newstCellModelArray , NSString *responsCode))successModel failData:(void(^)(NSError *error))failModel
{
//    [[YANetWorkHandleTool shareNetWorkTool] get]
}
@end
