//
//  LYYHTTPSManager.h
//  LYYTools
//
//  Created by 李阳洋 on 2018/8/2.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFNetworking.h"
typedef void (^dataBlock)(id data);
typedef void (^errorBlock)(NSError *error);


/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 1,
    /**
     *  post请求
     */
    HttpRequestTypePost = 2,
    /**
     *  单张图片post请求上传
     */
    HttpRequestTypeImageUploadPost = 3,
    /**
     *  多张图片post请求上传
     */
    HttpRequestTypeImagesUploadPost = 4
};

@interface LYYHTTPSManager : NSObject
singleH(LYYHTTPSManager)
/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param success     请求的结果
 */
- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(dataBlock)success
                     failure:(errorBlock)failure;

//+ (LYYHTTPSManager *)sharedInstance;
@end
