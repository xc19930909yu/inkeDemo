//
//  SXTNaVigationController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTNaVigationController.h"

@interface SXTNaVigationController ()

@end

@implementation SXTNaVigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor =  [UIColor colorWithRed:0/255.0 green:216/255.0 blue:201/255.0 alpha:1.0];
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
    
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
