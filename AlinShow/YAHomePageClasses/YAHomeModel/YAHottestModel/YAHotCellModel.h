//
//  YAHotCellModel.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/13.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAHotCellModel : NSObject


//{
//    allnum = 6631;
//    bigpic = "http://liveimg.9158.com/pic/avator/2016-09/06/12/20160906120706_60876772_640.png";
//    curexp = 0;
//    familyName = "<null>";
//    flv = "http://hdl.9158.com/live/97649b1103b98e6bbd5f65206e2e1a92.flv";
//    gender = 0;
//    gps = "\U5929\U6d25\U5e02";
//    grade = 0;
//    level = 0;
//    myname = "\U7480\U0fd0\U74a8\U0fd0\U5168\U80fd\U5973\U795e";
//    roomid = 20312069;
//    serverid = 5;
//    signatures = "\U559c\U6b22\U4e3b\U64ad\U70b9\U5173\U6ce8\Uff0c\U7231\U4e3b\U64ad\U9001520";
//    smallpic = "http://liveimg.9158.com/pic/avator/2016-09/06/12/20160906120706_60876772_250.png";
//    starlevel = 2;
//    userId = WeiXin19488560;
//    useridx = 60876772;
//},
/** 群众数目 */
@property(nonatomic, copy)NSString *allnum;
/** 直播图 */
@property(nonatomic, copy)NSString *bigpic;
/** 直播流地址 */
@property(nonatomic, copy)NSString *flv;
/** 所在城市 */
@property(nonatomic, copy)NSString *gps;
/** 主播名 */
@property(nonatomic, copy)NSString *myname;
/** 直播房间号码 */
@property(nonatomic, copy)NSString *roomid;
/** 所处服务器 */
@property(nonatomic, copy)NSString *serverid;
/** 个性签名 */
@property(nonatomic, copy)NSString *signatures;
/** 主播头像 */
@property(nonatomic, copy)NSString *smallpic;
/** 星级 */
@property(nonatomic, copy)NSString *starlevel;
/** 用户ID */
@property(nonatomic, copy)NSString *userId;
/** 用户ID */
@property(nonatomic, copy)NSString *useridx;
/******----暂时不太清楚的字段-----*/
@property(nonatomic, copy)NSString *grade;
@property(nonatomic, copy)NSString *level;
@property(nonatomic, copy)NSString *gender;
@property(nonatomic, copy)NSString *curexp;
@property(nonatomic, copy)NSString *familyName;

@end
