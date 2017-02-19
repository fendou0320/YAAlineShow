//
//  YANetWorkConnect.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/15.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YANetWorkConnect : NSObject

+(instancetype)shareNetWorkConnect;
/*
 *@brif :首页Banner图地址
 *
 *@param
 *
 *@return successBlock：存放YABannerModel的数组  responseCode：返回网络响应的返回类型 failModel：返回失败的error 
 */
-(void)getHotHomePageBannerData:(void(^)(NSArray *hotBannerModelArray , NSString *responsCode))successModel failData:(void(^)(NSError * error))failModel;
/*
 * @brif :首页直播流数据
 *
 * @param currentPage:当前是第几页
 *
 * @return
*/
-(void)getHotHomePageCurrentPage:(NSUInteger *)currentPage CellData:(void(^)(NSArray *hotCellModelArray , NSString *responsCode))successModel failData:(void(^)(NSError * error))failModel;

@end
