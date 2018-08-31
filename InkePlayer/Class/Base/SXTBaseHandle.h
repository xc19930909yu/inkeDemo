//
//  SXTBaseModel.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 处理完成时间
 */
typedef void(^CompleteBlock)();

/**
 
  处理事件成功
 
  @param obj 返回数据
 */
typedef void(^SuccessBlock)(id obj);

// 处理失败
typedef void(^FailedBlock)(id obj);

@interface SXTBaseHandle : NSObject




@end
