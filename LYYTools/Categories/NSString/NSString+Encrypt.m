//
//  NSString+Encrypt.m
//  LYYTools
//
//  Created by YangyangLi on 2020/11/23.
//  Copyright © 2020 lyy. All rights reserved.
//

#import "NSString+Encrypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Encrypt)

#pragma mark -- *****  MD5加密  *****
- (NSString *)yyl_md532BitType:(MD532BitType)type{
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

@end
