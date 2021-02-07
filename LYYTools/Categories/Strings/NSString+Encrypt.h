//
//  NSString+Encrypt.h
//  LYYTools
//
//  Created by YangyangLi on 2020/11/23.
//  Copyright © 2020 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  MD5 32位加密类型
 */
typedef NS_ENUM(NSUInteger,MD532BitType) {
    /**
     *  小写加密
     */
    MD5BitTypeLower = 1,
    /**
     *  大写加密
     */
    MD5BitTypeUpper = 2
};

/**
 *  计算字符串的宽高
 */
typedef NS_ENUM(NSUInteger,calculateRowType) {
    /**
     *  计算高
     */
    calculateRowTypeHeight = 1,
    /**
     *  计算宽
     */
    calculateRowTypeWidth = 2
};
@interface NSString (Encrypt)

#pragma mark -- *****  MD5加密  *****
/**
 *  MD5 32位加密
 *  @param type        加密类型（大小写）
 *  @return nsstring   加密结果
 */
- (NSString *)yyl_md532BitType:(MD532BitType)type;

@end

NS_ASSUME_NONNULL_END
