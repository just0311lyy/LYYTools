//
//  YLFileManage.h
//  LYYTools
//
//  Created by YangyangLi on 2019/3/1.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSUInteger, YylFileType){//文件存储位置
    YylFileTypeDocument,
    YylFileTypeCache,
    YylFileTypeLibrary,
    YylFileTypeTem
};
@interface YLFileManage : NSObject
singleH(EPSFileManage)
/** 获取Document路径 */
+(NSString *)getDocumentPath;
/** 获取Cache路径 */
+(NSString *)getCachePath;
/** 获取Library路径 */
+(NSString *)getLibraryPath;
/** 获取Tem路径 */
+(NSString *)getTemPath;

/** 判断文件是否存在 */
+(BOOL)fileIsExists:(NSString *)path;

/**
 *  创建目录下文件
 *  一般来说，文件要么放在Document,要么放在Labrary下的Cache里面
 *  这里也是只提供这两种存放路径
 *  @param fileName 文件名
 *  @param Type     路径类型
 *  @param context  数据内容
 *  @return 文件路径
 */
+(NSString *)createFileName:(NSString *)fileName type:(YylFileType)Type context:(NSData *)context;

/**
 写入文件
 @param filePath 文件路径
 @param textData 内容
 @return 是否成功
 */
+(BOOL)writeToFileName:(NSString *)filePath data:(NSData *)textData;
@end
