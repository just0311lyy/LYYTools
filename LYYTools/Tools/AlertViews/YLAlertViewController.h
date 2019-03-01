//
//  YLAlertViewController.h
//  LYYTools
//
//  Created by YangyangLi on 2019/3/1.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, EPSAlertControllerStyle) {
//    EPSAlertControllerStyleActionSheet = 0,
//    EPSAlertControllerStyleAlert
//};

@interface YLAlertViewController : UIAlertController
/** 参数说明:
 * title      弹框标题;
 * message    弹框的展示的信息;
 * style      是0或者1;代表弹框的类型:UIAlertControllerStyleActionSheet = 0,UIAlertControllerStyleAlert = 1;
 * titleArr   弹框中出现的按钮标题的数组;
 * alerAction block回调时间,只需要判断点击的按钮坐标就可以;
 */
+ (instancetype)initYLAlertViewControllerWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style titleArr:(NSMutableArray *)titleArr alertAction:(void (^)(NSInteger index))alertAction;

- (void)showYLAlert;
@end
