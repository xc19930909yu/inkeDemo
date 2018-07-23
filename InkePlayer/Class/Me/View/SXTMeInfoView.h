//
//  SXTMeInfoView.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/23.
//  Copyright © 2018年 sd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXTMeInfoView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (instancetype)loadInfoView;


@end
