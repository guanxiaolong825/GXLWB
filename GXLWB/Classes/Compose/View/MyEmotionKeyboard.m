//
//  MyEmotionKeyboard.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/16.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyEmotionKeyboard.h"
#import "MyEmotionTabBar.h"
#import "MyEmotionListView.h"
#import "MyEmotion.h"
#import "MJExtension.h"

@interface MyEmotionKeyboard ()<MyEmotionTabBarDelegate>

//容纳表情内容的控件
@property (nonatomic ,weak) UIView *contentView;

//表情内容
@property(nonatomic ,strong) MyEmotionListView *recentListView;
@property(nonatomic ,strong) MyEmotionListView *defaultListView;
@property(nonatomic ,strong) MyEmotionListView *emojiListView;
@property(nonatomic ,strong) MyEmotionListView *lxhListView;

//tabbar
@property (nonatomic ,weak) MyEmotionTabBar *tabBar;

@end

@implementation MyEmotionKeyboard


#pragma mark - 懒加载
- (MyEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[MyEmotionListView alloc]init];
    }
    return _recentListView;
}

- (MyEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[MyEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"info1" ofType:@"plist"];
        self.defaultListView.emotions = [MyEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
    }
    return _defaultListView;
}

- (MyEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[MyEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"info2" ofType:@"plist"];
        self.emojiListView.emotions = [MyEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
    }
    return _emojiListView;
}

- (MyEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[MyEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"info3" ofType:@"plist"];
        self.lxhListView.emotions = [MyEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
    }
    return _lxhListView;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //contentView
        UIView *contentView = [[UIView alloc]init];
        [self addSubview:contentView];
        self.contentView  = contentView;
        
        //tabbar
        MyEmotionTabBar *tabBar = [[MyEmotionTabBar alloc]init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置tabBar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    
    self.contentView.x = self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.tabBar.y;
    
    
    
    //设置frame
    UIView *child = [self.contentView.subviews lastObject];
    child.frame = self.contentView.bounds;
//    child.x = self.contentView.frame.origin.x;
//    child.y = self.contentView.frame.origin.y;
//    child.width = self.contentView.frame.size.width;
//    child.height = self.contentView.frame.size.height;
    
    
}


#pragma mark - MyEmotionTabBarDelegate
- (void)emotionTabBar:(MyEmotionTabBar *)tabBar didSelectButton:(MyEmotionTabBarButtonType)type
{
    
    //移除contentView之前显示的控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.contentView removeFromSuperview];
    
    //根据按钮的类型切换contentView的listView
    switch (type) {
        case MyEmotionTabBarButtonTypeRecent:{//最近
            
            [self.contentView addSubview:self.recentListView];
            
            break;
        }
            
        case MyEmotionTabBarButtonTypeDefault:{//默认
            [self.contentView addSubview:self.defaultListView];

            
            break;
        }
            
        case MyEmotionTabBarButtonTypeEmotion:{//emotion
            
            [self.contentView addSubview:self.emojiListView];

            break;
        }
        case MyEmotionTabBarButtonTypeLXH:{//浪小花
            
            [self.contentView addSubview:self.lxhListView];

            break;
        }
            
        default:
            break;
    }
    
    //重新计算子控件的frame (setNeedsLayout 内部会在恰当的时刻重新调用layoutSubviews 重新布局子控件)
    [self setNeedsLayout];
    
    
    
    //设置frame
//    UIView *child = [self.contentView.subviews lastObject];
//    child.frame = self.contentView.bounds;
    
    

}













@end
