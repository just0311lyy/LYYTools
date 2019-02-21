//
//  UILabel+YylCategory.m
//  LYYTools
//
//  Created by YangyangLi on 2019/2/20.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "UILabel+YylCategory.h"

@implementation UILabel (YylCategory)

#pragma mark -- *****  数字文字 or 图文 展示  *****
- (NSAttributedString *)yyl_stringWithNum:(NSString*)num Text:(NSString *)str andImgName:(NSString*)name{
    // 创建一个富文本
    
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    if (name && name.length > 0) {
        
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, str.length)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.5] range:NSMakeRange(0, str.length)];
        
        // 添加图片
        NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
        attchImage.image = [UIImage imageNamed:name];
        attchImage.bounds = CGRectMake(0, -3, 34, 34);
        NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
        [attriStr insertAttributedString:stringImage atIndex:0];
        
    }else {
        
        NSMutableAttributedString * attriStr1 = [[NSMutableAttributedString alloc] initWithString:num];
        NSMutableAttributedString * attriStr2 = [[NSMutableAttributedString alloc] initWithString:str];
        
        //数字
        [attriStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, num.length)];
        [attriStr1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HirakakuProN-W6" size:24] range:NSMakeRange(0, num.length)];
        //文字
        [attriStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, str.length)];
        [attriStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, str.length)];
        
        [attriStr1 appendAttributedString:attriStr2];
        
        attriStr = attriStr1;
    }
    
    return attriStr;
}
@end
