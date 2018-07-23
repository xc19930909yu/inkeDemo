//
//  SXTTabBarViewController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTTabBarViewController.h"
#import "SXTTabBar.h"
#import "SXTMainController.h"
#import "SXTMeController.h"
#import "SXTNaVigationController.h"
#import "SXTLauchViewController.h"

@interface SXTTabBarViewController ()<SXTTabBarDelegate>

@property(nonatomic, strong)SXTTabBar *sxtTabbar;
@end

@implementation SXTTabBarViewController

- (SXTTabBar *)sxtTabbar{
    if (!_sxtTabbar) {
        _sxtTabbar = [[SXTTabBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
        
        _sxtTabbar.delegate = self;
    }
    return _sxtTabbar;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载控制器 加载tabbar
    
    [self configureViewControllers];
    
    // 记载控制器
    
    [self.tabBar addSubview:self.sxtTabbar];
    
    
    /// 解决tabbar的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    // Do any additional setup after loading the view.
}

- (void)configureViewControllers{
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"SXTMainController",@"SXTMeViewController"]];
    for (NSInteger i = 0; i < array.count; i++) {
        
        NSString *vcName = array[i];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
       
        SXTNaVigationController *nav= [[SXTNaVigationController alloc] initWithRootViewController:vc];
        
        [array replaceObjectAtIndex:i withObject:nav];
        
        
        
    }
    self.viewControllers = array;
    
}


- (void)tabbar:(SXTTabBar *)tabbar clickButton:(SXTItemType)idx{
    
    /// 中间创建直播 模态视图
    if (idx == SXTItemTypeLauch) {
        
        SXTLauchViewController *lanchVc = [[SXTLauchViewController alloc] init];
        
        [self presentViewController:lanchVc animated:YES completion:nil];
        
    }else{
        
       self.selectedIndex = idx - SXTItemTypeLive;
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
