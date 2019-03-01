//
//  YLAlertViewController.m
//  LYYTools
//
//  Created by YangyangLi on 2019/3/1.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "YLAlertViewController.h"

@interface YLAlertViewController ()

@end

@implementation YLAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (instancetype)initYLAlertViewControllerWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style titleArr:(NSMutableArray *)titleArr alertAction:(void (^)(NSInteger index))alertAction{
    //判断弹框类型
    if (style == UIAlertControllerStyleAlert) {
        YLAlertViewController *alert = [YLAlertViewController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (NSInteger i = 0; i < titleArr.count; i++) {
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:[titleArr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (alertAction) {
                    alertAction(i);
                }
            }];
            [alert addAction:confirm];
        }
        return alert;
    }else /* if(style == UIAlertControllerStyleActionSheet) */ {
        YLAlertViewController *alert = [YLAlertViewController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSInteger i = 0; i < titleArr.count; i++) {
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:[titleArr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (alertAction) {
                    alertAction(i);
                }
            }];
            [alert addAction:confirm];
        }
        return alert;
    }
}

- (void)showYLAlert{
    [[self getCurrentVC] presentViewController:self animated:YES completion:nil];
}

-(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
