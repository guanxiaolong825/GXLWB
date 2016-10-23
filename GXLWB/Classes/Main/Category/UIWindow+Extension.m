//
//  UIWindow+Extension.m
//  GXLWB
//
//  Created by administrator on 16/8/9.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "TabbarViewController.h"
#import "MYNewfeatureViewController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    //上一次的使用版本号（从沙盒中获取）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //当前软件的版本号（从info。plist中获取）
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;//读取系统产生的info.plist
    NSString *currentVersion = info[key];//获取当前的版本
    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {//版本好相同 这次打开和上次打开的是同意的版本
        self.rootViewController = [[TabbarViewController alloc]init];
    }else{//这次打开和上次打开的版本号不一样  显示新特性
        self.rootViewController = [[MYNewfeatureViewController alloc]init];
        //将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];//立刻存储不可少
    }
    
}

@end
