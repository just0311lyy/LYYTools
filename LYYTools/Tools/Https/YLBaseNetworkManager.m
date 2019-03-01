//
//  YLBaseNetworkManager.m
//  LYYTools
//
//  Created by YangyangLi on 2019/3/1.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "YLBaseNetworkManager.h"
#import "UIImage+YylCategory.h"
//@interface YLBaseNetworkManager
//
//@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
//
//@end

@implementation YLBaseNetworkManager
singleM(YLBaseNetworkManager)

- (void)sendRequestToServiceByGet:(NSString *)url
                            parms:(NSDictionary *)parms
                          success:(YylNetworkSuccess)success
                          failure:(YylNetworkFailure)failure
{
    self.sessionManager = [AFHTTPSessionManager manager];
    self.sessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    //请求头设置
    [self.sessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"X-Request-Platform"];
    [self.sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure(error);
        
    }];
}

- (void)sendRequestToServiceByPost:(NSString *)url
                             parms:(NSDictionary *)parms
                           success:(YylNetworkSuccess)success
                           failure:(YylNetworkFailure)failure
{
    self.sessionManager = [AFHTTPSessionManager manager];
//    [self.sessionManager.requestSerializer setValue:CHECK_Nil([[CMBSystemInfoManager instance] getSystemInfo].idfv) forHTTPHeaderField:@"X-Device-Id"];
//    [self.sessionManager.requestSerializer setValue:CHECK_Nil([[CMBSystemInfoManager instance] getSystemInfo].versionNumber) forHTTPHeaderField:@"X-Request-Version"];
//    [self.sessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"X-Request-Platform"];
    [self.sessionManager POST:url parameters:parms progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure(error);
    }];
}

- (void)sendUploadImageToServiceByPost:(NSString *)url
                                 image:(UIImage *)image
                                  size:(CGSize)size
                                 parms:(NSDictionary *)parms
                               success:(YylNetworkSuccess)success
                               failure:(YylNetworkFailure)failure
{
    self.sessionManager = [AFHTTPSessionManager manager];
    [self.sessionManager POST:url parameters:parms constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = nil;
        UIImage *uploadImage = [UIImage yyl_imageWithImage:image scaledToSize:size];
        
        if (UIImagePNGRepresentation(uploadImage)) {
            data = UIImagePNGRepresentation(uploadImage);
        }else {
            data = UIImageJPEGRepresentation(uploadImage, 1.0);
        }
        
        [formData appendPartWithFileData:data name:@"imageFile" fileName:@"imageFile.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

// 上传多张图片
- (void)uploadMostImageWithURLString:(NSString *)url
                               parms:(NSDictionary *)parms
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                             success:(YylNetworkSuccess)success
                             failure:(YylNetworkFailure)failure
{
    self.sessionManager = [AFHTTPSessionManager manager];

    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [self.sessionManager POST:url parameters:parms constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        for (int i=0; i < uploadDatas.count; i++) {

            NSData *data = nil;
            UIImage *uploadImage = uploadDatas[i];

            CGFloat width = uploadImage.size.width;
            CGFloat height = uploadImage.size.height;

            uploadImage = [UIImage yyl_imageWithImage:uploadImage scaledToSize:CGSizeMake(width/([UIScreen mainScreen].scale *3), height/([UIScreen mainScreen].scale *3))];

            if (UIImagePNGRepresentation(uploadImage)) {
                data = UIImagePNGRepresentation(uploadImage);
            }else {
                data = UIImageJPEGRepresentation(uploadImage, 1.0);
            }

            NSString *fileName = [NSString stringWithFormat:@"imageFile%d.png",i];

            [formData appendPartWithFileData:data name:@"imageFiles" fileName:fileName mimeType:@"image/png"];
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure(error);
    }];
}

+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize
{

    if (maxSize <= 0.0) maxSize = 1024.0;
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;

    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);

    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;

    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }

    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;

    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }

    return imageData;
}

@end
