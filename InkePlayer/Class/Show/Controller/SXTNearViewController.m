//
//  SXTNearViewController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTNearViewController.h"
#import "SXTLiveHandler.h"
#import "SXTNearCollectionCell.h"
#import "SXTPlayerViewController.h"
#import "SXTLocationManager.h"
#import <CoreLocation/CoreLocation.h>

static NSString *identifier = @"SXTNearCollectionCell";

#define KMargin 5
#define KItemWidth 100
@interface SXTNearViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;

@property(nonatomic, strong)NSMutableArray *dataList;

@end

@implementation SXTNearViewController

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    
    return  _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self  initUI];
    
    [self rquestlocation];
    
    
    // Do any additional setup after loading the view from its nib.
}




- (void)rquestlocation{
    if ([SXTLocationManager sharedManager].lat == nil || [[SXTLocationManager sharedManager].lat isEqualToString:@""]) {
        
        if ([self determineWhetherTheAPPOpensTheLocation] == NO) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"message:@"请到设置->隐私->定位服务中开启【映客】定位服务，以便于距离筛选能够准确获得你的位置信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",nil];
            
            [alert show];
            
        }else{
            [[SXTLocationManager sharedManager] getGps:^(NSString *lat, NSString *lon) {
                [self lodaData];
                
            }];
        }
        
       
    }else{
        
         [self lodaData];
    }
    
}


- (BOOL)determineWhetherTheAPPOpensTheLocation{
    
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        
        return YES;
        
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        
        return NO;
        
    }else{
        
        return NO;
        
    }
    
}


- (void)lodaData{
    [SXTLiveHandler excuteGetNearLiveTaskWithSuccess:^(id obj) {
        
        NSLog(@"数据%@", obj);
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:obj];
         [self.collectView.mj_header endRefreshing];
        [self.collectView reloadData];
        
    } falied:^(id obj) {
        [self.collectView.mj_header endRefreshing];

    }];
    
}


- (void)initUI{
    
    [self.collectView registerNib:[UINib nibWithNibName:@"SXTNearCollectionCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    self.bottomHeight.constant = 49 + KTopHeight;
    [self.view setNeedsLayout];
    
    self.collectView.mj_header   = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([self determineWhetherTheAPPOpensTheLocation] == NO) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"message:@"请到设置->隐私->定位服务中开启【映客】定位服务，以便于距离筛选能够准确获得你的位置信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",nil];
            
            [alert show];
            
            [self.collectView.mj_header endRefreshing];
            
        }else{
            
            [[SXTLocationManager sharedManager] getGps:^(NSString *lat, NSString *lon) {
                [self lodaData];
                
            }];
        }
        
    }];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataList.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SXTNearCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.live = self.dataList[indexPath.row];
    
    
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger count =  self.collectView.width / KItemWidth;
    
      CGFloat  etraWidth=  (self.collectView.width - KMargin*(count+1)) / count;
    
    return  CGSizeMake(etraWidth, etraWidth + 20);
}


/// 将要出现
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SXTNearCollectionCell *cells = (SXTNearCollectionCell *)cell;
    
    
    [cells showAnimation];
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    SXTLive *live = self.dataList[indexPath.row];
    
    SXTPlayerViewController *playVc = [[SXTPlayerViewController alloc] init];
    
    playVc.live = live;
    
    CATransition *amin = [[CATransition alloc] init];
    
    amin.duration = 1;
    
    amin.type = @"rippleEffect";
    
    amin.subtype =  kCATransitionFromRight;
    
    amin.timingFunction =  [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.navigationController.view.layer addAnimation:amin forKey:nil];
    playVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playVc animated:YES];
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
