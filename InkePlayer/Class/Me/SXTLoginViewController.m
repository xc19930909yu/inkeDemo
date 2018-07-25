//
//  SXTLoginViewController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//


#import "SXTLoginViewController.h"
#import <UMCommon/UMCommon.h>
#import <UShareUI/UShareUI.h>

#import "SXTUserHelper.h"

#import "SXTTabBarViewController.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"

@implementation UMSAuthInfo

+ (instancetype)objectWithType:(UMSocialPlatformType)platform
{
    UMSAuthInfo *obj = [UMSAuthInfo new];
    obj.platform = platform;
    UMSocialUserInfoResponse *resp = nil;
    
    NSDictionary *authDic = [[UMSocialDataManager defaultManager ] getAuthorUserInfoWithPlatform:platform];
    if (authDic) {
        resp = [[UMSocialUserInfoResponse alloc] init];
        resp.uid = [authDic objectForKey:kUMSocialAuthUID];
        resp.unionId = [authDic objectForKey:kUMSocialAuthUID];
        resp.accessToken = [authDic objectForKey:kUMSocialAuthAccessToken];
        resp.expiration = [authDic objectForKey:kUMSocialAuthExpireDate];
        resp.refreshToken = [authDic objectForKey:kUMSocialAuthRefreshToken];
        resp.openid = [authDic objectForKey:kUMSocialAuthOpenID];
        
        if (platform == UMSocialPlatformType_QQ) {
            resp.uid = [authDic objectForKey:kUMSocialAuthOpenID];
        }
        if (platform == UMSocialPlatformType_QQ || platform == UMSocialPlatformType_WechatSession) {
            resp.usid = [authDic objectForKey:kUMSocialAuthOpenID];
        } else {
            resp.usid = [authDic objectForKey:kUMSocialAuthUID];
        }
        
        obj.response = resp;
    }
    return obj;
}

@end


@interface SXTLoginViewController ()


@end

@implementation SXTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


/// QQ登录
- (IBAction)qqLoginTap:(id)sender {
    if ([[UMSocialSinaHandler defaultManager] umSocial_isInstall]) {
        /// 手动点击  能获取到图片 用户名
        [[UMSocialManager defaultManager]  getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
            NSString *message =  nil;
            if (error) {
                message = @"获取用户信息失败";
                UMSocialLogInfo(@"登录失败 %@",error);
            }else{
                
                UMSocialUserInfoResponse *userInfoResp = [[UMSocialUserInfoResponse alloc] init];
                
                userInfoResp = result;
                
                NSLog(@"用户ID%@",userInfoResp.uid);
                [SXTUserHelper sharedUser].username  = userInfoResp.name;
                
                [SXTUserHelper sharedUser].iconUrl  = userInfoResp.iconurl;
                
                // 保存入本地
                [SXTUserHelper saveUser];
                
                self.view.window.rootViewController = [[SXTTabBarViewController alloc] init];
                
                
            }
            if (message) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
        
    }else{
        
        NSLog(@"没有安装QQapp!");
        
    }
    
}

/// 微信登录
- (IBAction)wechatLoginTap:(id)sender {

    if ([[UMSocialSinaHandler defaultManager] umSocial_isInstall]) {
        /// 手动点击  能获取到图片 用户名
        [[UMSocialManager defaultManager]  getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
            NSString *message =  nil;
            if (error) {
                message = @"获取用户信息失败";
                UMSocialLogInfo(@"登录失败 %@",error);
            
            }else{
                
                UMSocialUserInfoResponse *userInfoResp = [[UMSocialUserInfoResponse alloc] init];
                
                userInfoResp = result;
                
                NSLog(@"用户ID%@",userInfoResp.uid);
                [SXTUserHelper sharedUser].username  = userInfoResp.name;
                
                [SXTUserHelper sharedUser].iconUrl  = userInfoResp.iconurl;
                
                // 保存入本地
                [SXTUserHelper saveUser];
                
                self.view.window.rootViewController = [[SXTTabBarViewController alloc] init];
                
            }
            if (message) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
        
    }else{
        
        NSLog(@"没有安装微信app!");
        
    }
    
    
    
}


// 新浪微博登录
- (IBAction)sinaLogintap:(id)sender {
// __weak BaseViewController *weakSelf = self;
//    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_Sina completion:^(id result, NSError *error) {
//
//        [weakSelf authForPlatform:]
//    }];
    
    if ([[UMSocialSinaHandler defaultManager] umSocial_isInstall]) {
        /// 手动点击  能获取到图片 用户名
        [[UMSocialManager defaultManager]  getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
            NSString *message =  nil;
            if (error) {
                message = @"获取用户信息失败";
                UMSocialLogInfo(@"登录失败 %@",error);
            }else{
                
                UMSocialUserInfoResponse *userInfoResp = [[UMSocialUserInfoResponse alloc] init];
                
                userInfoResp = result;
                
                NSLog(@"用户ID%@",userInfoResp.uid);
                [SXTUserHelper sharedUser].username  = userInfoResp.name;
                
                [SXTUserHelper sharedUser].iconUrl  = userInfoResp.iconurl;
                
                // 保存入本地
                [SXTUserHelper saveUser];
                
                self.view.window.rootViewController = [[SXTTabBarViewController alloc] init];
                
                
            }
            if (message) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
        
    }else{
        
        NSLog(@"没有安装微博app!");
    
    }
    ///  自动登录
//    [[UMSocialManager defaultManager] authWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
//
//        NSString *message =  nil;
//
//        if (error) {
//              message = @"获取用户信息失败";
//             UMSocialLogInfo(@"登录失败 %@",error);
//        }else{
//
//            if ([result isKindOfClass:[UMSocialUserInfoResponse class]]) {
//
//               // UMSocialAuthResponse *resp  = result;
//
//                UMSocialUserInfoResponse *userInfoResp = [[UMSocialUserInfoResponse alloc] init];
//
//                userInfoResp = result;
//
//                //userInfoResp.name
//
//                [SXTUserHelper sharedUser].username  = userInfoResp.name;
//
//                [SXTUserHelper sharedUser].iconUrl  = userInfoResp.iconurl;
//
//                // 保存入本地
//                [SXTUserHelper saveUser];
//
//                self.view.window.rootViewController = [[SXTTabBarViewController alloc] init];
//
//            }
//
//        }
//
//        if (message) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                            message:message
//                                                           delegate:nil
//                                           cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
//                                                  otherButtonTitles:nil];
//            [alert show];
//        }
//
//    }];
    
    
}

//- (void)authForPlatform:(UMSAuthInfo *)authInfo
//{
//
//
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
