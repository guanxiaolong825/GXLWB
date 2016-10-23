//
//  AppDelegate.m
//  GXLWB
//
//  Created by administrator on 16/2/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

/*
 什么样的应用才有资格被用户授权
 1注册一个新浪微博账号，成为新浪的开发者
 2登录开发者主页，创建一个应用
  AppKey:应用的唯一标识
  AppSecret
  Redl
 3.创建完应用后会获得一下主要信息
  APPKey （应用的唯一标示）: 3163877545
  AppSecret: 6c9f86d76603e1aed396c94fb4d4a6e5
  RedirectURI ： （回调地址） 默认就是http://
 */

#import "AppDelegate.h"
//#import "TabbarViewController.h"
//#import "MYNewfeatureViewController.h"
#import "MYOAuthViewController.h"
//#import "MyAccount.h"
#import "MyAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1、创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    
    
    
    //设置iOS8以后applicationIconBadgeNumber
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 8.0) {//8.0 以上
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    
    
    //2、设置根控制器
    MyAccount *account = [MyAccountTool account];
    
    
    
    if (account) {//之前已经登录成功  判断是否显示新特性
        [self.window switchRootViewController];
//        NSString *key = @"CFBundleVersion";
//        //上一次的使用版本号（从沙盒中获取）
//        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//    
//        //当前软件的版本号（从info。plist中获取）
//        NSDictionary *info = [NSBundle mainBundle].infoDictionary;//读取系统产生的info.plist
//        NSString *currentVersion = info[key];//获取当前的版本
//    
//        if ([currentVersion isEqualToString:lastVersion]) {//版本好相同 这次打开和上次打开的是同意的版本
//            self.window.rootViewController = [[TabbarViewController alloc]init];
//        }else{//这次打开和上次打开的版本号不一样  显示新特性
//            self.window.rootViewController = [[MYNewfeatureViewController alloc]init];
//            //将当前的版本号存进沙盒
//            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
//            [[NSUserDefaults standardUserDefaults] synchronize];//立刻存储不可少
//        }
    }else{
        self.window.rootViewController = [[MYOAuthViewController alloc]init];
    }
    
    
    //4、显示窗口
    [self.window makeKeyAndVisible];
    
    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/*
 *当app进入后台是调用
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    /*
     *app的状态
     *1.死亡状态：没有打开app
     *2.前台运行状态：
     *3.后台暂停状态：停止一切动画、定时器、多媒体操作，很难在做其他操作
     *4.后台运行状态
     */
    
    //向操作系统申请后台运行的资格，能维持多久是不确定的
    __block UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        //当申请的后台运行时间已经过期，就会调用这个block
        
        //赶紧结束任务
        [application endBackgroundTask:task];
        
    }];
    
    
    //在Info.plist中设置后台模式：Required background modes == App plays audio or streams audio、videousing AirPlay
    //搞一个0KB的mp3文件没有声音
    //循环播放
    
    //以前的后台模式
    //保持网络连接
    //多媒体应用
    //VOIP网络电话
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    //1取消下载
    [mgr cancelAll];
    
    //2.清除内存的所有图片
    [mgr.imageCache clearMemory];
}


////3、设置子控制器
//UIViewController *vc1 = [[UIViewController alloc]init];
//vc1.tabBarItem.title = @"首页";
//vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
////声明图片按照原始图片样式显示出来不要自动渲染成其他颜色
//vc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//vc1.view.backgroundColor = GXLRandomColor;
////设置文字的样式
//NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//[vc1.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//[vc1.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//
//
//UIViewController *vc2 = [[UIViewController alloc]init];
//vc2.tabBarItem.title = @"消息";
//vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
//vc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_message_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//vc2.view.backgroundColor = GXLRandomColor;
//[vc2.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//[vc2.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//
//UIViewController *vc3 = [[UIViewController alloc]init];
//vc3.tabBarItem.title = @"发现";
//vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
//vc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//vc3.view.backgroundColor = GXLRandomColor;
//[vc3.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//[vc3.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//
//UIViewController *vc4 = [[UIViewController alloc]init];
//vc4.tabBarItem.title = @"我";
//vc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
//vc4.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//vc4.view.backgroundColor = GXLRandomColor;
//[vc4.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//[vc4.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];

@end
