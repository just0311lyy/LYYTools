//
//  YLUserDefault.h
//  LYYTools
//
//  Created by YangyangLi on 2019/3/1.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLUserDefault : NSObject
+ (void)yyl_setObject:(id)value forKey:(NSString *)defaultName;

+ (id)yyl_objectForKey:(NSString *)defaultName;

+ (void)yyl_setValue:(id)value forKey:(NSString *)defaultName;

+ (id)yyl_valueForKey:(NSString *)defaultName;

+ (void)yyl_removeObjectForKey:(NSString *)key;

+ (void)yyl_clearAll;
@end
