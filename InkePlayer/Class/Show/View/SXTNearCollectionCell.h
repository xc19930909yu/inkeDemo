//
//  SXTNearCollectionCell.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTLive.h"
@interface SXTNearCollectionCell : UICollectionViewCell


@property(nonatomic, strong)SXTLive *live;


- (void)showAnimation;
@end
