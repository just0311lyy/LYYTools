//
//  UIColor+YylCategory.h
//  LYYTools
//
//  Created by YangyangLi on 2019/2/20.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 渐变方式
 */
typedef NS_ENUM(NSInteger, IHGradientChangeDirection) {
    IHGradientChangeDirectionLevel,                 //水平渐变
    IHGradientChangeDirectionVertical,              //竖直渐变
    IHGradientChangeDirectionUpwardDiagonalLine,    //向下对角线渐变
    IHGradientChangeDirectionDownDiagonalLine,      //向上对角线渐变
};

@interface UIColor (YylCategory)
#pragma mark -- *****  颜色相关  *****
+ (UIColor *)yyl_colorWith256Red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;
+ (UIColor *)yyl_colorWithHex:(long)hex;
+ (UIColor *)yyl_colorWithHex:(long)hex andAlpha:(float)alpha;


#pragma mark -- *****  渐变色  *****
/**
 创建渐变颜色
 
 @param size       渐变的size
 @param direction  渐变方式
 @param startcolor 开始颜色
 @param endColor   结束颜色
 @return 创建的渐变颜色
 */
+ (instancetype)yyl_colorGradientChangeWithSize:(CGSize)size
                                      direction:(IHGradientChangeDirection)direction
                                     startColor:(UIColor *)startcolor
                                       endColor:(UIColor *)endColor;
@end
