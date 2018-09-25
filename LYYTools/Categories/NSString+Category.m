//
//  NSString+Category.m
//  LYYTools
//
//  Created by 李阳洋 on 2018/8/2.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Category)
- (NSString *)md532BitType:(MD532BitType)type{
    switch (type) {
        case MD5BitTypeLower:
        {
            const char *cStr = [self UTF8String];
            unsigned char result[16];
            
            NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
            CC_MD5( cStr,[num intValue], result );
            
            return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]
                     ] lowercaseString];
            break;
        }
        case MD5BitTypeUpper:
        {
            const char *cStr = [self UTF8String];
            unsigned char result[16];
            
            NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
            CC_MD5( cStr,[num intValue], result );
            
            return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]
                     ] lowercaseString];
            break;
        }
        default:
            break;
    }
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *pattern = @"^1+[3578]+\\d{9}";
    //    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    //    BOOL isMatch = [pred evaluateWithObject:telNumber];
    NSString *phoneRegex =@"^1[3|4|5|6|7|8|9][0-9]{1}[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMatch = [phoneTest evaluateWithObject:telNumber];
    return isMatch;
}

//邮箱
+(BOOL)validateEmail:(NSString *)email{
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



@end
