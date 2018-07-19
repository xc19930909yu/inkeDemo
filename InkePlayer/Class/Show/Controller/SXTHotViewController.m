//
//  SXTHotViewController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTHotViewController.h"
#import "SXTLiveHandler.h"
#import "SXTLive.h"
#import "SXTLiveCell.h"
#import "SXTPlayerViewController.h"

static NSString *identifier = @"SXTLiveCell";
@interface SXTHotViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)NSMutableArray *dataList;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableWidth;

@end

@implementation SXTHotViewController


- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    
    
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}


- (void)initUI{
   
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SXTLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    self.tableWidth.constant = SCREEN_WIDTH;
    self.bottomHeight.constant = 49 + KTopHeight;
    
    [self.view setNeedsLayout];

    self.tableView.mj_header   = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        
    }];
    
}

- (void)loadData{
    [self.dataList removeAllObjects];
    [SXTLiveHandler excuteGetHotLiveTaskWithSuccess:^(id obj) {
        
        NSLog(@"%@", obj);
        [self.dataList addObjectsFromArray:obj];
        
        NSLog(@"%f",   self.tableView.frame.size.height);

        [self.tableView.mj_header endRefreshing];

        [self.tableView reloadData];
        
    } falied:^(id obj) {
        
         [self.tableView.mj_header endRefreshing];
    
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SXTLiveCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.live = self.dataList[indexPath.row];
    
    return  cell;
    
    
    /// RTMP 协议     /// RTMP/HLS
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SXTLive *live = self.dataList[indexPath.row];
    
    SXTPlayerViewController *playVc = [[SXTPlayerViewController alloc] init];
    
    playVc.live = live;
    
    playVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playVc animated:YES];
//    MPMoviePlayerViewController *moviewVc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:live.streamAddr]];
//
//
//
//    [self presentViewController:moviewVc animated:YES completion:nil];
//
    
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 70 + SCREEN_WIDTH;
    
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
