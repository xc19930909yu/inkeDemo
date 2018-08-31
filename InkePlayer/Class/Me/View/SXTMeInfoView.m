//
//  SXTMeInfoView.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/23.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTMeInfoView.h"

#import "UIImageView+SDWebImage.h"
#import "SXTUserHelper.h"

@implementation SXTMeInfoView


//+ (void)load{
//
//
//}
+ (instancetype)loadInfoView{
    
    return  [[[NSBundle mainBundle] loadNibNamed:@"SXTMeInfoView" owner:self options:nil] lastObject];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
