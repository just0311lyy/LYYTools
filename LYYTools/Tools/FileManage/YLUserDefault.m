//
//  YLUserDefault.m
//  LYYTools
//
//  Created by YangyangLi on 2019/3/1.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "YLUserDefault.h"

@implementation YLUserDefault
+ (void)yyl_setObject:(id)value forKey:(NSString *)defaultName{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)yyl_objectForKey:(NSString *)defaultName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)yyl_setValue:(id)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)yyl_valueForKey:(NSString *)defaultName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)yyl_removeObjectForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)yyl_clearAll
{
    NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = userDefatluts.dictionaryRepresentation;;
    for(NSString* key in [dictionary allKeys]){
        if ([key isEqualToString:@"isFirst"]) {
            continue;
        }
        [userDefatluts removeObjectForKey:key];
        [userDefatluts synchronize];
    }
}
@end
