//
//  MyEmotionTabBar.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/16.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyEmotionTabBar.h"
#import "MyEmotionTabBarButton.h"

@interface MyEmotionTabBar ()

@property(nonatomic,weak) MyEmotionTabBarButton *selectButton;
@end

@implementation MyEmotionTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        MyEmotionTabBarButtonTypeRecent,//最近
//        MyEmotionTabBarButtonTypeDefault,//默认
//        MyEmotionTabBarButtonTypeEmotion,//emotion
//        MyEmotionTabBarButtonTypeLXH //浪小花

        
        [self setupBtn:@"最近" buttonType:MyEmotionTabBarButtonTypeRecent];
        [self btnClick:[self setupBtn:@"默认" buttonType:MyEmotionTabBarButtonTypeDefault]];
        [self setupBtn:@"Emoji" buttonType:MyEmotionTabBarButtonTypeEmotion];
        [self setupBtn:@"浪小花" buttonType:MyEmotionTabBarButtonTypeLXH];
        
    }
    return self;
}

//创建一个按钮
-(MyEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(MyEmotionTabBarButtonType)buttonType
{
    MyEmotionTabBarButton *btn = [[MyEmotionTabBarButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    
    btn.tag = buttonType;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    //设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }else if (self.subviews.count == 4){
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    
//    //选中默认按钮
//    if (buttonType == MyEmotionTabBarButtonTypeDefault) {
//        [self btnClick:btn];
//    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    [self addSubview:btn];
    
    return btn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width/count;
    CGFloat btnH = self.height;
    for (int i = 0; i<count; i++) {
        MyEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i*btnW;
        btn.height = btnH;
    }
    
}

- (void)setDelegate:(id<MyEmotionTabBarDelegate>)delegate
{
    
    _delegate = delegate;
    
    //选中默认按钮
    [self btnClick:[self viewWithTag:MyEmotionTabBarButtonTypeDefault]];
    
}

//按钮的点击
- (void)btnClick:(MyEmotionTabBarButton *)btn
{
    
    self.selectButton.enabled = YES;
    btn.enabled = NO;
    self.selectButton = btn;
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(MyEmotionTabBarButtonType)btn.tag];
    }
}











@end
