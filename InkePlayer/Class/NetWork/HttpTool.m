//
//  HttpTool.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "HttpTool.h"
#import <AFNetworking.h>


static NSString *kBaseurl = SERVER_HOST;

@interface AFHttpClient :  AFHTTPSessionManager

@end

@implementation AFHttpClient

+ (instancetype)sharedClient{
    
    static AFHttpClient *client = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
       
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseurl] sessionConfiguration:configuration];
        
        // 接收类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        
        //设置超时时间
        client.requestSerializer.timeoutInterval = 15;
        
        // 安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
        
    });
    
    return client;
}

@end

@implementation HttpTool
+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure{
    
    
    // 获取完成的url路径
    NSString *url = [kBaseurl stringByAppendingString:path];
    
    [[AFHttpClient sharedClient] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}


+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure{
    //获取完整的url路径
    NSString * url = [kBaseurl stringByAppendingPathComponent:path];
    
    [[AFHttpClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}


+ (void)downloadWithPath:(NSString *)path
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
                progress:(HttpDownloadProgressBlock)progress{
    //获取完整的url路径
    NSString * urlString = [kBaseurl stringByAppendingPathComponent:path];
    
    //下载
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        //获取沙盒cache路径
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
        
    }];
    
    [downloadTask resume];
}


+ (void)uploadImageWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)imagekey
                      image:(UIImage *)image
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress{
    //获取完整的url路径
    NSString * urlString = [kBaseurl stringByAppendingPathComponent:path];
    
    NSData * data = UIImagePNGRepresentation(image);
    
    [[AFHttpClient sharedClient] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:imagekey fileName:@"01.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}


@end