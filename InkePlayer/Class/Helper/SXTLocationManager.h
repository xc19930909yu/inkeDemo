//
//  SXTLocationManager.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


typedef void(^LocationBlock)(NSString *lat, NSString *lon);

typedef void(^LocationCityBlock)(NSString *cityName);
@interface SXTLocationManager : NSObject

+ (instancetype)sharedManager;


- (void)getGps:(LocationBlock)block;
    
    
/// 获取定位的城市

- (void)getCity:(LocationCityBlock)block;
    


@property(nonatomic, copy)NSString *lat;

@property(nonatomic, copy)NSString *lont;
    
    
///  当前城市名
@property(nonatomic, copy)NSString *currentCity;


@end
