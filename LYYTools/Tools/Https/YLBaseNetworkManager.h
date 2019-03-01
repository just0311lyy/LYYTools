//
//  YLBaseNetworkManager.h
//  LYYTools
//
//  Created by YangyangLi on 2019/3/1.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  网络操作成功的block处理。
 *  @param result 结果, 是个泛型,具体回调依据业务层注释说明。
 */
typedef void(^YylNetworkSuccess)(id result);

/**
 *  网络操作失败的block处理。
 *  @param result 原因。
 */
typedef void(^YylNetworkFailure)(id result);

@interface YLBaseNetworkManager : NSObject
singleH(YLBaseNetworkManager)
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
- (void)sendRequestToServiceByGet:(NSString *)url
                            parms:(NSDictionary *)parms
                          success:(YylNetworkSuccess)success
                          failure:(YylNetworkFailure)failure;

- (void)sendRequestToServiceByPost:(NSString *)url
                             parms:(NSDictionary *)parms
                           success:(YylNetworkSuccess)success
                           failure:(YylNetworkFailure)failure;

- (void)sendUploadImageToServiceByPost:(NSString *)url
                                 image:(UIImage *)image
                                  size:(CGSize)size
                                 parms:(NSDictionary *)parms
                               success:(YylNetworkSuccess)success
                               failure:(YylNetworkFailure)failure;


- (void)uploadMostImageWithURLString:(NSString *)url
                               parms:(NSDictionary *)parms
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                             success:(YylNetworkSuccess)success
                             failure:(YylNetworkFailure)failure;

@end
