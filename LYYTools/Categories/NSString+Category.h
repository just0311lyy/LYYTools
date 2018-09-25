//
//  NSString+Category.h
//  LYYTools
//
//  Created by 李阳洋 on 2018/8/2.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
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


/**
 *  MD5 32位加密
 *  @param type        加密类型
 *  @return nsstring   加密结果
 */
- (NSString *)md532BitType:(MD532BitType)type;

//手机号验证
+(BOOL)checkTelNumber:(NSString *) telNumber;
//邮箱
+(BOOL)validateEmail:(NSString *)email;




@end
