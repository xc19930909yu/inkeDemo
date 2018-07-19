//
//  MJExtensionConfig.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "SXTCreater.h"
#import "SXTLive.h"
@implementation MJExtensionConfig


+ (void)load{
    /// 替换系统参数
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
    
    
    [SXTCreater mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"desc" : @"desciption"
                 };
    }];
    
    // 下划线  驼峰转下划线去取值
    [SXTCreater mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    
    [SXTLive mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
}
@end
