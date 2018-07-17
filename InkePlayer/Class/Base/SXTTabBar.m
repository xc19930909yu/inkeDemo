//
//  SXTTabBar.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTTabBar.h"

@interface SXTTabBar()


@property(nonatomic, strong)UIImageView *tabBgView;

@property(nonatomic, strong)NSArray *dataList;

@property(nonatomic, strong)UIButton *lastItem;

@property(nonatomic, strong)UIButton *carmaButton;

@end

@implementation SXTTabBar


- (UIButton *)carmaButton{
    
    if (!_carmaButton) {
        _carmaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_carmaButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        
        /// 自适应大小
        [_carmaButton sizeToFit];
        
        _carmaButton.tag = SXTItemTypeLauch;
        
        [_carmaButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _carmaButton;
}

- (UIImageView *)tabBgView{
    if (!_tabBgView) {
        
        _tabBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    
    return _tabBgView;
}


- (NSArray *)dataList{
    if (!_dataList) {
        _dataList = @[@"tab_live",@"tab_me"];
    }
    return _dataList;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
       
        // 加背景
        [self addSubview:self.tabBgView];
        //  装载item
        for (NSInteger i = 0 ; i< self.dataList.count; i++) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [item setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
            
            item.tag = SXTItemTypeLive + i;
            
            NSLog(@"图片%@", [self.dataList[i]  stringByAppendingString:@"_p"]);
            [item setImage:[UIImage imageNamed:[self.dataList[i]  stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            // 不让图片在高亮下改变
            item.adjustsImageWhenHighlighted = NO;
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            [item setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
            
            if (i ==0 ) {
                item.selected = YES;
                self.lastItem = item;
            }
            
            [self addSubview:item];
        }
        
        /// 添加直播按钮  self.属性
        [self addSubview:self.carmaButton];
   
    
    }
    return self;
    
}


/// 写frame
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.tabBgView.frame = self.bounds;
    CGFloat width = self.frame.size.width/self.dataList.count;
    for (NSInteger i = 0 ; i < self.subviews.count; i++) {
        UIView *btn = self.subviews[i];
        if ([btn isKindOfClass:[UIButton class]]) {
            
          
            
            btn.frame  = CGRectMake((btn.tag - SXTItemTypeLive)*width, 0, width, self.frame.size.height);
        }
    }
    
    [self.carmaButton sizeToFit];
    self.carmaButton.center = CGPointMake(self.bounds.size.width/2 , self.bounds.size.height - 49);
    
    
}

- (void)clickItem:(UIButton *)item{

    
    if ( item == self.carmaButton) {
        if ( [self.delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
            
            [self.delegate tabbar:self clickButton:item.tag];
        }
        
        return;
     }
     self.lastItem.selected = NO;
     item.selected = YES;
     self.lastItem = item;
    
//  设置动画
//    CABasicAnimation *animation = CABasicAnimation()
//
//    animation.
    [UIView animateWithDuration:0.2 animations:^{
        item.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    } completion:^(BOOL finished) {
        
        /// 恢复原始状态
        item.transform = CGAffineTransformIdentity;
    }];
    
     if ( [self.delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
        
        [self.delegate tabbar:self clickButton:item.tag];
     }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
