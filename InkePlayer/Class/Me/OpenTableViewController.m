//
//  OpenTableViewController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/8/1.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "OpenTableViewController.h"

@interface OpenTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *payTableview;

@property (weak, nonatomic) IBOutlet UIWebView *payWebView;

@end

@implementation OpenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURL*url = [NSURL URLWithString:@"https://wxpay.wxutil.com/mch/pay/h5.v2.php"];
    
    NSURLRequest *reest = [NSURLRequest requestWithURL:url];
    
    [self.payWebView loadRequest:reest];
    
    
    // Do any additional setup after loading the view from its nib.
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
