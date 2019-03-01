//
//  YLFileManage.m
//  LYYTools
//
//  Created by YangyangLi on 2019/3/1.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "YLFileManage.h"

@implementation YLFileManage
singleM(EPSFileManage)
+(NSString *)getDocumentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
+(NSString *)getCachePath{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
+(NSString *)getLibraryPath{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}
+(NSString *)getTemPath{
    return NSTemporaryDirectory();
}

+(NSString *)getRootPath:(YylFileType)type{
    switch (type) {
        case YylFileTypeDocument:
            return [self getDocumentPath];
            break;
        case YylFileTypeCache:
            return [self getCachePath];
            break;
        case YylFileTypeLibrary:
            return [self getLibraryPath];
            break;
        case YylFileTypeTem:
            return [self getTemPath];
            break;
        default:
            break;
    }
    return nil;
}

+(BOOL)fileIsExists:(NSString *)path{
    if (!path || path.length == 0) {
        return NO;
    }
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+(NSString *)createFileName:(NSString *)fileName type:(YylFileType)Type context:(NSData *)context{
    if (!fileName || fileName.length == 0) {
        return nil;
    }
    NSString *rootPath = [[self getRootPath:Type] stringByAppendingString:fileName];
    if ([self fileIsExists:rootPath]) {
        if (![[NSFileManager defaultManager]removeItemAtPath:rootPath error:nil]) {
            return nil;
        }
    }
    if ([[NSFileManager defaultManager]createFileAtPath:rootPath contents:context attributes:nil]) {
        return rootPath;
    }
    return nil;
}

//追加写文件
+(BOOL)writeToFileName:(NSString *)filePath data:(NSData *)textData{
    if (![self fileIsExists:filePath]) {
        return NO;
    }
    if (textData.bytes>0) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:textData];
        [fileHandle synchronizeFile];
        [fileHandle closeFile];
        return YES;
    }else{
        return NO;
    }
}
@end
