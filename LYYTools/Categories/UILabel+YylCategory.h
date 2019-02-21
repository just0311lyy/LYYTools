//
//  UILabel+YylCategory.h
//  LYYTools
//
//  Created by YangyangLi on 2019/2/20.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YylCategory)
#pragma mark -- *****  数字文字 or 图文 展示  *****
/**
 * 数字+字符串，图片+字符串 （可分别设置大小）
 * @param num 数字字符串
 * @param str 文字
 * @param name 图片
 * @return 带数字的label或者带图片的label
 */
- (NSAttributedString *)yyl_stringWithNum:(NSString*)num Text:(NSString *)str andImgName:(NSString*)name;
@end
