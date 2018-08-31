//
//  SXTLiveHandler.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTLiveHandler.h"
#import "HttpTool.h"
#import "SXTLive.h"
#import "MJExtensionConfig.h"
#import "SXTLocationManager.h"
#import "SXTAdvertise.h"

@implementation SXTLiveHandler
+ (void)excuteGetHotLiveTaskWithSuccess:(SuccessBlock)success falied:(FailedBlock)failed{
    
    [HttpTool getWithPath:API_LiveGetTop params:nil success:^(id json) {
        
        if ( [json[@"dm_error"] integerValue]) {
            
            failed(json);
        }else{
            // 返回信息正确
            // 数据解析
            
          NSArray *lives =     [SXTLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            success(lives);
        }
        
    } failure:^(NSError *error) {
        
        failed(error);
        
    }];
    
    
}



+ (void)excuteGetNearLiveTaskWithSuccess:(SuccessBlock)success falied:(FailedBlock)failed{
    NSDictionary *param = @{@"uid":@"85149891",@"latitude":[SXTLocationManager sharedManager].lat, @"longitude": [SXTLocationManager sharedManager].lont};
    
    
    [HttpTool getWithPath:API_NearLocation params:param success:^(id json) {
        if ( [json[@"dm_error"] integerValue]) {
            
            failed(json);
        }else{
            // 返回信息正确
            
            // 数据解析
            NSArray *lives =     [SXTLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            success(lives);
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}

// 下载广告
+ (void)executeGetAdvertiseWithSuccess:(SuccessBlock)success falied:(FailedBlock)failed{
    
    
    [HttpTool getWithPath:API_Advertise params:nil success:^(id json) {
        
        NSDictionary *resources = json[@"resources"][0];
        
        SXTAdvertise *ad = [SXTAdvertise mj_objectWithKeyValues:resources];
        
        success(ad);
        
    } failure:^(NSError *error) {
        
        
        
    }];
    
    
}

@end
