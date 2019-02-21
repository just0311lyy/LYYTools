//
//  UIImage+YylCategory.h
//  LYYTools
//
//  Created by YangyangLi on 2019/2/20.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

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

/**
 * 将一张图片变成指定的大小
 * @param image 原图片
 * @param size 指定的大小
 * @return 指定大小的图片
 */
+ (UIImage *)yyl_scaleToSize:(UIImage *)image size:(CGSize)size;
@end
