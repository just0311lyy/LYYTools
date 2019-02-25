//
//  UIView+YylCategory.m
//  LYYTools
//
//  Created by YangyangLi on 2019/2/22.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "UIView+YylCategory.h"

@implementation UIView (YylCategory)

//set方法
- (void)setYyl_x:(CGFloat)yyl_x
{
    CGRect frame = self.frame;
    
    frame.origin.x = yyl_x;
    
    self.frame = frame;
}

//get方法
- (CGFloat)yyl_x
{
    return self.frame.origin.x;
}


//set方法
- (void)setYyl_y:(CGFloat)yyl_y
{
    CGRect frame = self.frame;
    
    frame.origin.y = yyl_y;
    
    self.frame = frame;
}

//get方法
- (CGFloat)yyl_y
{
    return self.frame.origin.y;
}


//set方法
- (void)setYyl_w:(CGFloat)yyl_w
{
    CGRect frame = self.frame;
    
    frame.size.width = yyl_w;
    
    self.frame = frame;
}

//get方法
- (CGFloat)yyl_w
{
    return self.frame.size.width;
}

//set方法
- (void)setYyl_h:(CGFloat)yyl_h
{
    CGRect frame = self.frame;
    
    frame.size.height = yyl_h;
    
    self.frame = frame;
}

//get方法
- (CGFloat)yyl_h
{
    return self.frame.size.height;
}

@end
