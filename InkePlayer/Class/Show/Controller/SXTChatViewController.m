//
//  SXTChatViewController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTChatViewController.h"
#import "UIImageView+SDWebImage.h"
@interface SXTChatViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet UIButton *msgBtn;


@property (weak, nonatomic) IBOutlet UIImageView *shareBtn;

@property (nonatomic, strong) dispatch_source_t timer;


@end

@implementation SXTChatViewController

- (void)setLive:(SXTLive *)live{
    
    _live = live;
    
    if ([live.creator.portrait hasPrefix:@"http"]) {
         [self.iconView downloadImage:[NSString stringWithFormat:@"%@", live.creator.portrait] placeholder:@"default_room"];
    }else{
          [self.iconView downloadImage:[NSString stringWithFormat:@"%@%@", IMAGE_HOST, live.creator.portrait] placeholder:@"default_room"];
    }
    
    
  
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    
    
    [self  initTimer];
    self.iconView.layer.cornerRadius = 15.0;
    
    self.iconView.layer.masksToBounds = YES;
    
    NSTimer *timer =  [NSTimer timerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
        
        self.namelabel.text =  @(arc4random()%10000).stringValue;
        
    } repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    // Do any additional setup after loading the view from its nib.
}



- (void)initTimer{
    
    // 初始化心形动画
    
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1*NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(self.timer, ^{
        
        [self showMoreLoveAnimateFromView:self.shareBtn addToView:self.view];
    });
    
    dispatch_resume(self.timer);
    
}
    
    
- (void)showMoreLoveAnimateFromView:(UIView *)fromView addToView:(UIView *)addToView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
    CGRect loveFrame = [fromView convertRect:fromView.frame toView:addToView];
    CGPoint position = CGPointMake(fromView.layer.position.x, loveFrame.origin.y - 30);
    imageView.layer.position = position;
    NSArray *imgArr = @[@"heart_1",@"heart_2",@"heart_3",@"heart_4",@"heart_5",@"heart_1"];
    NSInteger img = arc4random()%6;
    imageView.image = [UIImage imageNamed:imgArr[img]];
    [addToView addSubview:imageView];
    
    imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    
    CGFloat duration = 3 + arc4random()%5;
    CAKeyframeAnimation *positionAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimate.repeatCount = 1;
    positionAnimate.duration = duration;
    positionAnimate.fillMode = kCAFillModeForwards;
    positionAnimate.removedOnCompletion = NO;
    
    UIBezierPath *sPath = [UIBezierPath bezierPath];
    [sPath moveToPoint:position];
    CGFloat sign = arc4random()%2 == 1 ? 1 : -1;
    CGFloat controlPointValue = (arc4random()%50 + arc4random()%100) * sign;
    [sPath addCurveToPoint:CGPointMake(position.x, position.y - 300) controlPoint1:CGPointMake(position.x - controlPointValue, position.y - 150) controlPoint2:CGPointMake(position.x + controlPointValue, position.y - 150)];
    positionAnimate.path = sPath.CGPath;
    [imageView.layer addAnimation:positionAnimate forKey:@"heartAnimated"];
    
    [UIView animateWithDuration:duration animations:^{
        imageView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self showMoreLoveAnimateFromView:self.shareBtn addToView:self.view];
    
    
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
