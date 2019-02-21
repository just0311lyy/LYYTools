//
//  NSString+YylCategory.h
//  LYYTools
//
//  Created by YangyangLi on 2019/2/20.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@interface NSString (YylCategory)

#pragma mark -- *****  MD5加密  *****
/**
 *  MD5 32位加密
 *  @param type        加密类型
 *  @return nsstring   加密结果
 */
- (NSString *)yyl_md532BitType:(MD532BitType)type;

#pragma mark -- *****  正则表达式  *****
//手机号验证
+(BOOL)yyl_checkTelNumber:(NSString *) telNumber;
//邮箱
+(BOOL)yyl_validateEmail:(NSString *)email;
@end
