//
//  SXTAdvertiseView.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/19.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTAdvertiseView.h"
#import "SXTLiveHandler.h"
#import "SXTAdvertise.h"
#import "UIImageView+SDWebImage.h"
#import "NSString+CachePath.h"
#import "SXTCacheHelper.h"
#import <SDWebImage/SDImageCache.h>

@interface SXTAdvertiseView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

// 广告显示时间
static int const  showTime = 3;

@implementation SXTAdvertiseView


+ (instancetype)loadAdvertise{
    
    return  [[[NSBundle mainBundle] loadNibNamed:@"SXTAdvertiseView" owner:self options:nil] lastObject];
    
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.frame = [UIScreen mainScreen].bounds;
    
    [self showAd];
    
    [self downLoadAd];
    
    [self startCountdown];
}


- (void)showAd{
    
    NSString *fileName = [SXTCacheHelper getAdvertiseImage];
    
    NSString *fielPath = [NSString stringWithFormat:@"%@%@", IMAGE_HOST, fileName];
    
    UIImage *lastPreviousCacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:fielPath];
    
    if (!lastPreviousCacheImage) {
        
        self.hidden = YES;
    }else{
        
        self.imageView.image = lastPreviousCacheImage;
    }
    
}



// 下载广告
- (void)downLoadAd{
  
    [SXTLiveHandler executeGetAdvertiseWithSuccess:^(id obj) {
        SXTAdvertise *ad = obj;
        
        NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGE_HOST, ad.image]];
        
        //SDWebImageAvoidAutoSetImage 下载完成不会直接赋值给imageview  放在磁盘中
        
//        [[SDWebImageManager sharedManager]downloadImageWithURL:imageUrl options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//
//            [SXTCacheHelper setAdvertiseImage:ad.image];
//
//            NSLog(@"%@",  @"下载成功");
//        }];
        
        [[SDWebImageManager sharedManager] loadImageWithURL:imageUrl options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            [SXTCacheHelper setAdvertiseImage:ad.image];
            NSLog(@"%@",  @"下载成功");
        }];
        
        
    } falied:^(id obj) {
        
        
    }];
    
    
   
    
      
    
    
    
    
}


- (void)startCountdown{
    
    __block int timeout =  showTime + 1; // 倒计时时间 + 1
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer =  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    
  
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    // 每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if (timeout <= 0) {  // 倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dismiss];
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.timeLabel.text = [NSString stringWithFormat:@"跳过%d", timeout];
            });
            
            timeout--;
        }
        
    });
    
    dispatch_resume(_timer);
    
    
}


- (void)dismiss{
    
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
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
