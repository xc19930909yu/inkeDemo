//
//  UIImageView+QSImageProcess.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/24.
//  Copyright © 2018年 sd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QSImageProcess/QSImageProcessConfig.h>

@interface UIImageView (QSImageProcess)

/**
 加载并显示网络图片，调用前需要先设置好UIImageView的frame或bounds
 
 @param url 图片url
 @param placeholder 图片处理配置对象
 */
- (void)qs_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder;


/**
 加载并显示网络图片
 @param url 图片url
 @param placeholder 占位图
 @param config 图片处理配置对象
 */
- (void)qs_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                    config:(QSImageProcessConfig *)config;



@end
