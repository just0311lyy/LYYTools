//
//  NSDictionary+YylSafe.m
//  LYYTools
//
//  Created by YangyangLi on 2020/12/1.
//  Copyright © 2020 lyy. All rights reserved.
//

#import "NSDictionary+YylSafe.h"

@implementation NSDictionary (YylSafe)

- (id)yyl_safeObjectForKey:(NSString*)safeKey{
    if (![self isDictionary]) {
        return nil;
    }
    
    if ([[self allKeys] containsObject:safeKey] && [self objectForKey:safeKey]) {
        id safeValue = self[safeKey];
        return safeValue;
    }
    return nil;
}

- (BOOL)isDictionary{
    if (!self) {
        return NO;
    }
    return [self isKindOfClass:[NSDictionary class]];
}

@end
