//
//  SXTTabBar.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
     SXTItemTypeLauch = 10,
     SXTItemTypeLive = 100 , // 展示直播
     SXTItemTypeMe, // 我的
} SXTItemType;

@class SXTTabBar;

typedef void(^TabBlock)(SXTTabBar *tabbar, SXTItemType idx);

@protocol SXTTabBarDelegate<NSObject>

- (void)tabbar:(SXTTabBar*)tabbar clickButton:(SXTItemType)idx;

@end

@interface SXTTabBar : UIView

@property(nonatomic, weak)id<SXTTabBarDelegate>delegate;

@property(nonatomic, copy)TabBlock block;
@end
