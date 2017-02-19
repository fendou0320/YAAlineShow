//
//  YATheDefinitionOfNetworkInterfaceName.h
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/11.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#ifndef YATheDefinitionOfNetworkInterfaceName_h
#define YATheDefinitionOfNetworkInterfaceName_h

static NSString *const RankingH5 = @"http://live.9158.com/Rank/WeekRank?Random=10";
static NSString *const BannerUrl =  @"http://live.9158.com/Living/GetAD";
#define HotCellSourceUrl(currentPage) [NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld", currentPage]
#define NewestCellSourceUrl(currentPage) [NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld", currentPage]

typedef NS_ENUM(NSInteger, NETWORKSTATUS){
    
    YANETWORKSUCCESS = 100,
    YANETWORKNOTSUCCESS,
    
};
#endif /* YATheDefinitionOfNetworkInterfaceName_h */
