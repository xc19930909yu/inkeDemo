//
//  SXTMainTopView.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/17.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTMainTopView.h"

@interface SXTMainTopView()

@property(nonatomic, strong) UIView *lineView;

@property(nonatomic, copy)MainTopBlock block;

@property(nonatomic, strong)NSMutableArray *buttons;



@end

@implementation SXTMainTopView

- (NSMutableArray *)buttons{
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    
    return  _buttons;
}


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles tapView:(MainTopBlock)block{
    
    if (self = [super initWithFrame:frame]) {
        
        self.block = block;
        
        CGFloat btnW =  self.frame.size.width / titles.count;
        
        CGFloat btnH = self.frame.size.height;
        
        CGFloat btnx;
        
        for ( int i = 0; i < titles.count; i++) {
            
            UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [self.buttons addObject:titleButton];
            
            titleButton.tag = i;
            
            NSString *vcName = titles[i];
            
            [titleButton setTitle:vcName forState:UIControlStateNormal];
            
            //设置标题颜色
            [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            // 设置标题字体
            titleButton.titleLabel.font = [UIFont systemFontOfSize:18];
            
            btnx = i * btnW;
            
            titleButton.frame = CGRectMake(btnx, 0, btnW, btnH);
            
            // 监听按钮点击
            [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:titleButton];
        
        
        if ( i == 1) {
            
            // 添加下划线
            // 下划线宽度 = 按钮文字宽度
            // 线画线中点x= 按钮中心点x
            
            CGFloat h = 2;
            
            CGFloat y = 35;
            
            // 先计算文字尺寸，再给label赋值
            [titleButton.titleLabel sizeToFit];
            
            UIView *lineView = [[UIView alloc] init];
            
            // 位置和尺寸
            lineView.height = h;
            lineView.width = titleButton.titleLabel.width;
            lineView.centerX = titleButton.centerX;
            lineView.top = y;
            lineView.backgroundColor = [UIColor whiteColor];
            
            self.lineView = lineView;
            
            [self  addSubview:self.lineView];
            
            
        }
        
        }
    
    }
    
    return  self;
}


- (void)titleClick:(UIButton *)btn{
    self.block(btn.tag);
    [self scrolling:btn.tag];
    
}

- (void)scrolling:(NSInteger)tag{
    
    UIButton *button = self.buttons[tag];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.lineView.centerX = button.centerX;
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
