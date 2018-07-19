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
@interface SXTLocationManager : NSObject

+ (instancetype)sharedManager;


- (void)getGps:(LocationBlock)block;


@property(nonatomic, copy)NSString *lat;

@property(nonatomic, copy)NSString *lont;


@end
