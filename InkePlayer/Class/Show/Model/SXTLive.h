//
//  SXTLive.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXTCreater.h"
@interface SXTLive : NSObject
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) SXTCreater * creator;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, assign) NSInteger link;
@property (nonatomic, assign) NSInteger multi;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger onlineUsers;
@property (nonatomic, assign) NSInteger optimal;
@property (nonatomic, assign) NSInteger pubStat;
@property (nonatomic, assign) NSInteger roomId;
@property (nonatomic, assign) NSInteger rotate;
@property (nonatomic, strong) NSString * shareAddr;
@property (nonatomic, assign) NSInteger slot;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * streamAddr;
@property (nonatomic, assign) NSInteger version;


@property (nonatomic, assign ,getter=isShow) BOOL show;


@property (nonatomic, strong) NSString * distance;


@end
