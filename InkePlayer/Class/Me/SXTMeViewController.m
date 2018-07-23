//
//  SXTMeViewController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/23.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTMeViewController.h"
#import "SXTMeInfoView.h"
#import "SXTSetting.h"
#import "SXTUserHelper.h"
#import "SXTLoginViewController.h"
#import "UIImageView+SDWebImage.h"

@interface SXTMeViewController ()

@property(nonatomic, strong)NSArray *dataList;


@property(nonatomic, strong)SXTMeInfoView *infoView;
@end

@implementation SXTMeViewController

- (SXTMeInfoView*)infoView{
    if (!_infoView) {
        _infoView = [SXTMeInfoView loadInfoView];
        
        _infoView.frame =  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.45);
        
        if ([SXTUserHelper isAutoLogin] == true) {
            [_infoView.headImg downloadImage:[SXTUserHelper sharedUser].iconUrl placeholder:@"default_room"];

        }
    }
    return _infoView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 避免上面导航栏的影响
      // self.automaticallyAdjustsScrollViewInsets  = NO;
       if (@available(iOS 11.0, *)) {
           self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
       } else {
           self.automaticallyAdjustsScrollViewInsets = NO;

       }
    ///self.tableView.tableHeaderView = self.infoView;
    
    
    self.tableView.rowHeight = 60;
    
    self.tableView.sectionHeaderHeight = 5;
    
    
    [self loadData];
    
    
    /// 为group时自动带头部高度
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/// 加载数据
- (void)loadData{
    
    SXTSetting *set1 = [[SXTSetting alloc] init];
    
    set1.title = @"映客贡献榜";
    
    set1.subTitle = @"";
    
    set1.vcName = @"SXTGongViewController";
    
    
    SXTSetting *set2 = [[SXTSetting alloc] init];
    
    set2.title = @"票数";
    
    set2.subTitle = @"0 映票";
    
    set2.vcName = @"SXTGongViewController";
    
    
    SXTSetting *set3 = [[SXTSetting alloc] init];
    
    set3.title = @"收益";
    
    set3.subTitle = @"0 钻石";
    
    set3.vcName = @"SXTGongViewController";
    
    
    SXTSetting *set4 = [[SXTSetting alloc] init];
    
    set4.title = @"等级";
    
    set4.subTitle = @"3 级";
    
    set4.vcName = @"SXTGongViewController";
    
    
    SXTSetting *set5 = [[SXTSetting alloc] init];
    
    set5.title = @"退出登录";  /// 设置
    
    set5.subTitle = @"";
    
    set5.vcName = @"SXTGongViewController";
    
    NSArray *arr1 = @[set1,set2,set3];
    
    NSArray *arr2 = @[set4];
    
    NSArray *arr3 = @[set5];
    
    self.dataList  = @[arr1,arr2,arr3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataList[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    SXTSetting *set = self.dataList[indexPath.section]
    [indexPath.row];
    
//    if (indexPath.section == 2) {
//        cell.separatorInset = UIEdgeInsetsMake(0, self.view.bounds.size.width, 0, 0);
//
//    }else{
//
//        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
//
//    }
    cell.textLabel.text = set.title;
    
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.detailTextLabel.text = set.subTitle;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.infoView;
    }
//    UIView *headerView  =  [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor lightGrayColor];
//    return headerView ;
    return  nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return SCREEN_HEIGHT*0.45;
    }
    
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (indexPath.section == 2) {
        
        [SXTUserHelper loginOut];
        
        SXTLoginViewController *loginVc = [[SXTLoginViewController alloc] initWithNibName:@"SXTLoginViewController" bundle:nil];
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        
        keyWindow.rootViewController = loginVc;
        
    }else{
        
        
    }
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
