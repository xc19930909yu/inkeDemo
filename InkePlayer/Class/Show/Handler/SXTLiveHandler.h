//
//  SXTLiveHandler.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTBaseHandle.h"
@interface SXTLiveHandler : SXTBaseHandle

/**
 * 获取热门直播信息
 */
+ (void)excuteGetHotLiveTaskWithSuccess:(SuccessBlock)success falied:(FailedBlock)failed;



/// 获取附近的直播
+ (void)excuteGetNearLiveTaskWithSuccess:(SuccessBlock)success falied:(FailedBlock)failed;



// 下载广告
+ (void)executeGetAdvertiseWithSuccess:(SuccessBlock)success falied:(FailedBlock)failed;

@end
