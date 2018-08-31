//
//  SXTLoginViewController.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "BaseViewController.h"
#import <UMShare/UMShare.h>

@interface UMSAuthInfo : NSObject

@property (nonatomic, assign) UMSocialPlatformType platform;
@property (nonatomic, strong) UMSocialUserInfoResponse *response;

+ (instancetype)objectWithType:(UMSocialPlatformType)platform;

@end

@interface SXTLoginViewController : BaseViewController

@end
