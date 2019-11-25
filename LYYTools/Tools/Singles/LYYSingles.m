//
//  LYYSingles.m
//  LYYTools
//
//  Created by 李阳洋 on 2018/8/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "LYYSingles.h"

//严谨起见,遵循<NSCopying,NSMutableCopying>两个协议 是为了重写copyWithZone以及MutableCopyWithZone这两个对象方法
@interface LYYSingles ()<NSCopying, NSMutableCopying>

@end

@implementation LYYSingles
// 创建静态对象 防止外部访问
static LYYSingles *_instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    //    @synchronized (self) {
    //        // 为了防止多线程同时访问对象，造成多次分配内存空间，所以要加上线程锁
    //        if (_instance == nil) {
    //            _instance = [super allocWithZone:zone];
    //        }
    //        return _instance;
    //    }
    // 也可以使用一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

// 为了使实例易于外界访问 我们一般提供一个类方法
// 类方法命名规范 share类名|default类名|类名
+(instancetype)shareTools
{
    //return _instance;
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc] init];
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

@end
