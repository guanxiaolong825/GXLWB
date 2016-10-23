//
//  MyEmotionTabBar.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/16.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

//枚举
typedef enum {
    MyEmotionTabBarButtonTypeRecent,//最近
    MyEmotionTabBarButtonTypeDefault,//默认
    MyEmotionTabBarButtonTypeEmotion,//emotion
    MyEmotionTabBarButtonTypeLXH //浪小花
}MyEmotionTabBarButtonType;

@class MyEmotionTabBar;

@protocol MyEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(MyEmotionTabBar *)tabBar didSelectButton:(MyEmotionTabBarButtonType )type;
@end

@interface MyEmotionTabBar : UIView

@property (nonatomic ,weak) id<MyEmotionTabBarDelegate> delegate;
@end
