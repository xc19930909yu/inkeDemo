//
//  NSString+CachePath.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/19.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "NSString+CachePath.h"

@implementation NSString (CachePath)
- (NSString *)cacheWithPath{
    
    NSString *sandox = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    return  [sandox stringByAppendingPathComponent:self];
}
@end
