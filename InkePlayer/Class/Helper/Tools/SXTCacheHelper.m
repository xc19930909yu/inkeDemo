//
//  SXTCacheHelper.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/19.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTCacheHelper.h"

// 静态
static NSString *const  adImagename = @"adImageName";
@implementation SXTCacheHelper
+ (NSString *)getAdvertiseImage{
    
    return  [[NSUserDefaults standardUserDefaults] objectForKey:adImagename];
}

+ (void)setAdvertiseImage:(NSString *)imageName{
    
    [[NSUserDefaults standardUserDefaults] setObject:imageName forKey:adImagename];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
