//
//  AppDelegate+SXTUmeng.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/19.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "AppDelegate+SXTUmeng.h"

@implementation AppDelegate (SXTUmeng)
- (void)setupUmeng{
    //设置umengkey
   
    [UMConfigure initWithAppkey:@"59192467bbea83773900026f" channel:@"test"];
    
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2662888715" appSecret:@"888043295991ac9ec37dd177a1776d68" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    /// http分享
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
    
    
  //  [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2892166685"
//                                              secret:@"7849eb7a9922c4318b1a0cff9a215ff3"
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    
    
     
    
}
@end
