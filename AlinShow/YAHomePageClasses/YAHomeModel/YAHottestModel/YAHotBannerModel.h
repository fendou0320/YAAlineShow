//
//  YAHotBannerModel.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/15.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAHotBannerModel : NSObject

@property(nonatomic, copy)NSString *lrCurrent;
///所在服务器号
@property(nonatomic, copy)NSString *serverid;
///主播名
@property(nonatomic, copy)NSString *myname;
///个性签名
@property(nonatomic, copy)NSString *signatures;
///主播头像
@property(nonatomic, copy)NSString *smallpic;
///大图
@property(nonatomic, copy)NSString *bigpic;
///所在城市
@property(nonatomic, copy)NSString *gps;
///主播id
@property(nonatomic, copy)NSString *useridx;
///直播流
@property(nonatomic, copy)NSString *flv;
@property(nonatomic, copy)NSString *hiddenVer;
@property(nonatomic, copy)NSString *cutTime;
@property(nonatomic, copy)NSString *adsmallpic;
@property(nonatomic, copy)NSString *contents;
///主题
@property(nonatomic, copy)NSString *title;
///图片url
@property(nonatomic, copy)NSString *imageUrl;
///链接
@property(nonatomic, copy)NSString *link;
///房间id
@property(nonatomic, copy)NSString *roomid;
///当前状态
@property(nonatomic, copy)NSString *state;
///广告序号
@property(nonatomic, copy)NSString *orderid;

/**--------------
"lrCurrent": 0,
"serverid": 0,
"myname": null,
"signatures": null,
"smallpic": null,
"bigpic": null,
"gps": null,
"useridx": 0,
"flv": null,
"hiddenVer": 171,
"cutTime": 5,
"adsmallpic": "http://liveimg.9158.com/pic/ad/20160726/201607261525466857.jpg",
"contents": "每日首充福利 充10元送10元",
"title": "喵播充值活动",
"imageUrl": "http://liveimg.9158.com/pic/ad/20160607/201606071640274836.png",
"link": "http://liveapi.9158.com/Active/20160606/index.html",
"roomid": 0,
"addTime": "/Date(-62135596800000)/",
"state": 0,
"orderid": 3
 --------**/

@end
