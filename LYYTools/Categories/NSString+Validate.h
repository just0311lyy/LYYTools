//
//  NSString+Validate.h
//  LYYTools
//
//  Created by YangyangLi on 2020/11/19.
//  Copyright © 2020 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Validate)

/**
* 邮箱
* @return bool值
*/
- (BOOL)yyl_validateEmail;

/**
* 手机号
* @return bool值
*/
- (BOOL)yyl_validateMobile;

/**
* 车牌号
* @return bool值
*/
- (BOOL)yyl_validateCarNo;

/**
* 车型
* @return bool值
*/
- (BOOL)yyl_validateCarType;

/**
* 用户名
* @return bool值
*/
- (BOOL)yyl_validateUserName;

/**
* 密码
* @return bool值
*/
- (BOOL)yyl_validatePassword;

/**
* 昵称
* @return bool值
*/
- (BOOL)yyl_validateNickname;

/**
* 是否身份证号
* @return bool值
*/
- (BOOL)yyl_validateIdentityCard;

/**
* 获取字符串长度
* @return 长度
*/
- (NSInteger)yyl_GB2312StringLength;

@end

NS_ASSUME_NONNULL_END
