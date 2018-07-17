//
//  SXTMainTopView.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^MainTopBlock)(NSInteger tag);

@interface SXTMainTopView : UIView


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles tapView:(MainTopBlock)block;

- (void)scrolling:(NSInteger)tag;

@end
