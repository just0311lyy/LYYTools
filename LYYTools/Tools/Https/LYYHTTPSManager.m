//
//  LYYHTTPSManager.m
//  LYYTools
//
//  Created by 李阳洋 on 2018/8/2.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "LYYHTTPSManager.h"

@implementation LYYHTTPSManager
singleM(LYYHTTPSManager)
/**
 *  创建网络请求类的单例
 */
//static LYYHTTPSManager *httpRequest = nil;
//+ (LYYHTTPSManager *)sharedInstance
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (httpRequest == nil) {
//            httpRequest = [[self alloc] init];
//        }
//    });
//    return httpRequest;
//}
//+(instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (httpRequest == nil) {
//            httpRequest = [super allocWithZone:zone];
//        }
//    });
//    return httpRequest;
//}
//- (instancetype)copyWithZone:(NSZone *)zone
//{
//    return httpRequest;
//}

- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(dataBlock)success
                     failure:(errorBlock)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    switch (type) {
        case HttpRequestTypeGet:
        {
            [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    //                    id jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:nil];
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestTypePost:
        {
            [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    //                    id jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:nil];
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        default:
            break;
    }
    
}
@end
