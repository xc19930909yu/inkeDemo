//
//  UIImageView+SDWebImage.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^DownloadImageSuccessBlock)(UIImage *image);

typedef void(^DownloadImageFailedBlock)(NSError *error);
typedef void(^DownloadImageProgressBlock)(CGFloat progress);

@interface UIImageView (SDWebImage)

/**
 
 异步加载图片
  // 图片地址
  //  占位图片
 */

- (void)downloadImage:(NSString*)url placeholder:(NSString *)placeImage;


/**
  // 图片地址
  // 占位图片名
  //  下载成功
  //  下载失败
  //  下载进度
 */


- (void)downloadImage:(NSString *)url placeholder:(NSString*)imageName success:(DownloadImageSuccessBlock)success faild:(DownloadImageFailedBlock)failed progress:(DownloadImageProgressBlock)progress;




@end
