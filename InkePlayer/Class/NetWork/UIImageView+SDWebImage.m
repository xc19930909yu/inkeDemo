//
//  UIImageView+SDWebImage.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "UIImageView+SDWebImage.h"

@implementation UIImageView (SDWebImage)

- (void)downloadImage:(NSString*)url placeholder:(NSString *)placeImage{
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeImage] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    
}


- (void)downloadImage:(NSString *)url placeholder:(NSString*)imageName success:(DownloadImageSuccessBlock)success faild:(DownloadImageFailedBlock)failed progress:(DownloadImageProgressBlock)progress{
    
    
//    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        progress(receivedSize*1.0/expectedSize);
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (error) {
//
//            failed(error);
//        }else{
//
//            self.image = image;
//
//            success(image);
//        }
//    }];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        progress(receivedSize*1.0/expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            
            failed(error);
        }else{
            
            self.image = image;
            
            success(image);
        }
    }];
    
//    [self sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        progress(receivedSize*1.0/expectedSize);
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//        if (error) {
//
//            failed(error);
//        }else{
//
//            self.image = image;
//
//            success(image);
//        }
//    }];
    
}


@end
