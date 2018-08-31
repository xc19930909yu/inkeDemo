//
//  XSTFucusViewController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "XSTFucusViewController.h"
#import "SXTLiveHandler.h"
#import "SXTLive.h"
#import "SXTLiveCell.h"
#import "SXTPlayerViewController.h"

static NSString *identifier = @"SXTFucusCell";
@interface XSTFucusViewController ()<UITableViewDelegate, UITableViewDataSource>
    
    @property(nonatomic, strong)NSMutableArray *dataList;
    
    @property (weak, nonatomic) IBOutlet UITableView *dataTableView;
    
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewWidth;
    
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomGap;
    
@end

@implementation XSTFucusViewController

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
    
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.dataTableView registerNib:[UINib nibWithNibName:@"SXTLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    self.tableViewWidth.constant = SCREEN_WIDTH;
    self.bottomGap.constant = 49 + KTopHeight;
    
    [self.view setNeedsLayout];
    
    self.dataTableView.mj_header   = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        
    }];
    
}

/// 设置collection的偏移量
-(void) scrollToSectionHeader:(int)section {
   // NSIndexPath *indexPath = [NSIndexPath
  //                            indexPathForRow:0 inSection:section];
//    UICollectionViewLayoutAttributes
//       *attribs =
//     [self.dataTableView
//     layoutAttributesForSupplementaryElementOfKind:UICol
//     lectionElementKindSectionHeader
//     atIndexPath:indexPath];
    
//    CGPoint topOfHeader = CGPointMake(0,
 //                                     attribs.frame.origin.y -
  //                                     self.dataTableView.contentInset.top);
  //  [self.dataTableView
   //  setContentOffset:topOfHeader animated:YES];
}
    
    
- (void)loadData{
    [SXTLiveHandler excuteGetHotLiveTaskWithSuccess:^(id obj) {
        
        NSLog(@"%@", obj);
        [self.dataList removeAllObjects];
         
         [self.dataList addObject:[(NSArray *)obj firstObject]];
        ///[self.dataList addObjectsFromArray:obj];
        
        NSLog(@"%f",   self.dataTableView.frame.size.height);
        
        [self.dataTableView.mj_header endRefreshing];
        
        [self.dataTableView reloadData];
        
    } falied:^(id obj) {
        
        [self.dataTableView.mj_header endRefreshing];
        
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
