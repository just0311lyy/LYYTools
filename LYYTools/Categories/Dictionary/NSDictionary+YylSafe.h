//
//  NSDictionary+YylSafe.h
//  LYYTools
//
//  Created by YangyangLi on 2020/12/1.
//  Copyright © 2020 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (YylSafe)

- (id)yyl_safeObjectForKey:(NSString*)safeKey;

@end

NS_ASSUME_NONNULL_END
