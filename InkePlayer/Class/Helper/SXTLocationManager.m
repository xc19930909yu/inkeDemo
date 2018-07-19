//
//  SXTLocationManager.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTLocationManager.h"

@interface SXTLocationManager()<CLLocationManagerDelegate>

@property(nonatomic, strong)CLLocationManager *locManager;

@property(nonatomic, copy)LocationBlock block;

@end

@implementation SXTLocationManager
+ (instancetype)sharedManager{
    
    static  SXTLocationManager *_manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[SXTLocationManager alloc] init];
        }
    });
    
    return  _manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _locManager  = [[CLLocationManager alloc] init];
        
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        _locManager.distanceFilter = 100;
        
        
        _locManager.delegate = self;
        // 定位服务是否开启
        if (![CLLocationManager locationServicesEnabled]) {
            
            NSLog(@"开启服务! ");
            [_locManager requestWhenInUseAuthorization];
        }else{
            
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            
            if (status == kCLAuthorizationStatusNotDetermined) {
                
                [_locManager requestWhenInUseAuthorization];
            }
            
        }
    }
    return self;
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    CLLocationCoordinate2D coor = newLocation.coordinate;
    
    // 经度
    //    NSLog(@"%f", coor.longitude);
    //    NSLog(@"%f", coor.latitude);
    [SXTLocationManager sharedManager].lont = @(coor.longitude).stringValue;
    [SXTLocationManager sharedManager].lat = @(coor.latitude).stringValue;
    self.block(@(coor.longitude).stringValue, @(coor.latitude).stringValue);
    
    [self.locManager stopUpdatingLocation];
}


/// 实现回传经纬度
- (void)getGps:(LocationBlock)block{
    
    self.block = block;
    // 开始定位
    [self.locManager startUpdatingLocation];
    
}


@end