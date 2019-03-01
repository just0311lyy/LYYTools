//
//  UIImage+YylCategory.h
//  LYYTools
//
//  Created by YangyangLi on 2019/2/20.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GPUImage.h"  //美颜滤镜处理三方库

CG_EXTERN UIImage* getGrayScaleImage(UIImage* originalImage);
CG_EXTERN CGImageRef CopyImageAndAddAlphaChannel(CGImageRef sourceImage);

@interface UIImage (YylCategory)
#pragma mark -- *****  切圆形带边框  *****
/**
 * 根据指定图片的文件名获取一张圆型的图片对象,并加边框
 * @param name 图片文件名
 * @param borderWidth 边框的宽
 * @param borderColor 边框的颜色
 * @return 切好的圆型图片
 */
+ (UIImage *)yyl_circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)yyl_circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;



+ (UIImage *)yyl_rotate:(UIImage *)src andOrientation:(UIImageOrientation)orientation;

//美颜滤镜相关
//+ (UIImage *)yyl_amatorkaFilterImage:(UIImage *)image;
//+ (UIImage *)yyl_kuwaharaFilterImage:(UIImage *)image;
//+ (UIImage *)yyl_brightnessFilterImage:(UIImage *)image brightness:(CGFloat)brightness ;
//+ (UIImage *)yyl_saturationFilterImage:(UIImage *)image vaule:(CGFloat)vaule;

+ (UIImage *)yyl_maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
+ (UIImage *)yyl_image:(UIImage *)image withMask:(UIImage *)maskImage;
+ (UIImage *)yyl_maskImage2:(UIImage *)image withMask:(UIImage *)maskImage;
+ (UIImage *)yyl_maskImage3:(UIImage *)image withMask:(UIImage *)maskImage;

+ (UIImage *)yyl_maskImage2:(CGImageRef)image withMask:(UIImage*)maskImage withFrame:(CGRect)currentFrame;
+ (UIImage *)yyl_squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)yyl_imageFromLayer:(CALayer *)layer;
+ (UIImage *)yyl_imageByTrimmingTransparentPixels:(UIImage *)image;

+ (UIImage *)yyl_scaleImageWithImage:(UIImage *)image maxLengt:(CGFloat)length;

/**
 * 将一张图片变成指定的大小
 * @param image 原图片
 * @param newSize 指定的大小
 * @return 指定大小的图片
 */
+ (UIImage *)yyl_imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (UIImage *)yyl_cropImageToRound:(UIImage *)image;

+ (UIImage *)yyl_circleImage:(UIImage *)oldImage withSize:(CGSize)size;
@end
