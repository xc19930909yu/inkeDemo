//
//  SXTLauchViewController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTLauchViewController.h"
#import "LFLivePreview.h"
#import "SXTLocationManager.h"
@interface SXTLauchViewController ()<UIAlertViewDelegate>

    @property (weak, nonatomic) IBOutlet UIButton *cityBtn;
    
@end

@implementation SXTLauchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([SXTLocationManager sharedManager].currentCity == nil || [[SXTLocationManager sharedManager].currentCity isEqualToString:@""]){
       
         if ([self determineWhetherTheAPPOpensTheLocation] == NO) {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"message:@"请到设置->隐私->定位服务中开启【映客】定位服务，以便获取城市信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",nil];
             
             [alert show];
             
         }else{

             [[SXTLocationManager sharedManager] getCity:^(NSString *cityName) {
                  [self.cityBtn setTitle:cityName forState:UIControlStateNormal];
                 
             }];
             
         }
        
    }else{
         [self.cityBtn setTitle:[SXTLocationManager sharedManager].currentCity forState:UIControlStateNormal];
    }
   
    
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)closeTap:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

    
/// 是否开启定位
- (BOOL)determineWhetherTheAPPOpensTheLocation{
    
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        
        return YES;
        
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        
        return NO;
        
    }else{
        
        return NO;
        
    }
    
}


- (IBAction)startLive:(id)sender {
    UIView *back  =[[UIView alloc] initWithFrame:self.view.bounds];
    
    back.backgroundColor = [UIColor blackColor];
    [self.view addSubview:back];
    
    LFLivePreview *liveView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    
    // 开始直播
    [self.view addSubview:liveView];
    [liveView startLive];
    
   // [self.view addSubview:[[LFLivePreview alloc]  initWithFrame:self.view.bounds]];
    
}
    
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return  UIStatusBarStyleLightContent;
}
    
    
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{//点击弹窗按钮后
        
        if (buttonIndex ==1){//确定
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }
        
    }


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
