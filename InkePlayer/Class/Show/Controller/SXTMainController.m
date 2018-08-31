//
//  SXTMainController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTMainController.h"
#import "SXTNearViewController.h"
#import "SXTHotViewController.h"
#import "XSTFucusViewController.h"
#import "SXTMainTopView.h"

@interface SXTMainController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;


@property(nonatomic, strong)NSArray *dataList;

@property(nonatomic, strong) SXTMainTopView *topView;

@end

@implementation SXTMainController

- (NSArray *)dataList{
    if (!_dataList) {
        
        _dataList = @[@"关注",@"热门",@"附近"];
    }
    return _dataList;
    
}


- (SXTMainTopView *)topView{
    if (!_topView) {
        
        _topView = [[SXTMainTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 40) titles:self.dataList tapView:^(NSInteger tag) {
            
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
            
            [self.contentScrollView setContentOffset:point animated:YES];
        }];
    }
    
    return  _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.topView;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate = self;
    [self setupNav];
    
    
    // 添加子视图控制器
    [self setupChildViewContrlllers];
   
    // Do any additional setup after loading the view from its nib.
}


- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:self action:@selector(moreTap)];
    
}


- (void)setupChildViewContrlllers{
    NSArray *vcNames =@[@"XSTFucusViewController",@"SXTHotViewController",@"SXTNearViewController"];
    
    for ( NSInteger i = 0; i < vcNames.count; i++) {
        
        NSString *vcName = vcNames[i];
        UIViewController *vc =  [[NSClassFromString(vcName) alloc] init];
        
        vc.title = self.dataList[i];
        // 当执行这句话不会执行该vc的viewDidLoad
        [self addChildViewController:vc];
    }
    
    //  将控制器的view，加到mainvc的view上
    // 设置scrollView的contentSize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.dataList.count, 0);
    
    // 默认展示第二个界面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    /// 进入控制器加载第一个页面
   /// [self scrollViewDidEndDecelerating:self.contentScrollView];
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}


- (void)search{
    
}


- (void)moreTap{
    
    
}


// 减速结束加载子控制器view的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat width = SCREEN_WIDTH;  /// SCREEN_WIDTH
    CGFloat height = SCREEN_HEIGHT;
    
    CGFloat contentOfset = scrollView.contentOffset.x;
    /// 获取索引值
    NSInteger idx = scrollView.contentOffset.x / width;
    
    //标题线
    [self.topView scrolling:idx];
    
    /// 根据索引值 返回vc的引用
    UIViewController *vc = self.childViewControllers[idx];
    
    /// 判断当前的vc是否执行过viewdidload
    if ([vc isViewLoaded]) {
        
        return;
    }
    vc.view.frame = CGRectMake(contentOfset, 0, scrollView.frame.size.width, height);
    
    [scrollView addSubview:vc.view];

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
