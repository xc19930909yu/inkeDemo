//
//  UIImageView+QSImageProcess.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/24.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "UIImageView+QSImageProcess.h"
#import <SDWebImage/SDWebImageManager.h>

@implementation UIImageView (QSImageProcess)
- (void)qs_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder{
      QSImageProcessConfig *config = [QSImageProcessConfig defaultConfigWithOutputSize:self.bounds.size];
    
    [self qs_setImageWithURL:url placeholderImage:placeholder config:config];
}


/**
 加载并显示网络图片
 @param url 图片url
 @param placeholder 占位图
 @param config 图片处理配置对象
 */
- (void)qs_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                    config:(QSImageProcessConfig *)config{
    if (placeholder && self.image != placeholder) {
        self.image = placeholder;
    }
    
    NSString *urlString = [url absoluteString];
    if (!urlString || [urlString length]  <= 0) {
        return;
    }
    
    NSString *configDesc = [config description];
    NSString *cacheUrlString = [NSString stringWithFormat:@"%@_%@",urlString,configDesc];
    NSLog(@"cacheUrlString = %@",cacheUrlString);
    SDWebImageManager *sdImageManager = [SDWebImageManager sharedManager];
    
    NSString *cacheKey = [sdImageManager cacheKeyForURL:[[NSURL alloc] initWithString:cacheUrlString]];
    [sdImageManager.imageCache queryCacheOperationForKey:cacheKey done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
        
        if (image) {
            self.image = image;
            NSLog(@"find it....");
        }else{
            NSLog(@"start download....");
            [sdImageManager.imageDownloader downloadImageWithURL:url options:SDWebImageRetryFailed | SDWebImageHighPriority | SDWebImageAvoidAutoSetImage  progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                
                if (image) {
                    [[QSImageProcess sharedInstance]processImage:image config:config completed:^(UIImage *outputImage) {
                        
                        if (outputImage) {
                            self.image = outputImage;
                            [sdImageManager.imageCache storeImage:outputImage forKey:cacheKey completion:nil];
                        }
                    }];
                }else{
                    NSLog(@"download error...");
                }
                NSLog(@"end download....");
            }];
        }
    }];
    
}
@end
