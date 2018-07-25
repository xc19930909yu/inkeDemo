//
//  AppDelegate.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "AppDelegate.h"
#import "SXTTabBarViewController.h"
#import "SXTLocationManager.h"
#import "SXTAdvertiseView.h"
#import "AppDelegate+SXTUmeng.h"
#import "SXTLoginViewController.h"
#import "SXTUserHelper.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 友盟初始化
    [self setupUmeng];
   
    
    UIViewController *mainVc;
    
    if ([SXTUserHelper isAutoLogin]) {
        
        mainVc = [[SXTTabBarViewController alloc] init];
    
    }else{
        
        mainVc = [[SXTLoginViewController alloc] init];
        
    }
    
    ///SXTTabBarViewController *mainvc = [[SXTTabBarViewController alloc] init];
    self.window.rootViewController = mainVc;
    
    // 载入广告
    SXTAdvertiseView *adverVc = [SXTAdvertiseView loadAdvertise];
    
    [self.window addSubview:adverVc];
    
    [[SXTLocationManager sharedManager] getGps:^(NSString *lat, NSString *lon) {
        
        NSLog(@"%@,%@", lat,lon);
        
        
    }];
    
  
    IQKeyboardManager.sharedManager.enable = YES;

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


// 支持ios9以上系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
   
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        
    }
    return result;
    
}


// 支持所有系统
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
