//
//  MyTabBar.h
//  GXLWB
//
//  Created by administrator on 16/4/20.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>


//写代理
@class MyTabBar;

#warning 因为MyTabBar集成UITabBar，所以成为MyTabBar的代理，也必须实现UITabBar的代理协议
@protocol MyTabBarDelegate <UITabBarDelegate>
@optional

- (void)tabBarDidClickPlusButton:(MyTabBar *)tabBar;
@end


@interface MyTabBar : UITabBar
@property(nonatomic ,weak) id<MyTabBarDelegate> delegate;

@end
