//
//  MyTabBar.m
//  GXLWB
//
//  Created by administrator on 16/4/20.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyTabBar.h"

@interface MyTabBar ()
@property(nonatomic ,weak) UIButton *pluseBtn;
@end

@implementation MyTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc]init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        plusBtn.centerX = self.width*0.5;
        plusBtn.centerY = self.height*0.5;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.pluseBtn = plusBtn;
    }
    return self;
}

//点击加号按钮
- (void)plusClick
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
    
}

- (void)layoutSubviews
{
#warning [super layoutSubviews] 一定要调用 布局用
    [super layoutSubviews];
    
    //设置加号按钮的位置
    self.pluseBtn.centerX = self.width*0.5;
    self.pluseBtn.centerY = self.height*0.5;
    
    //设置其他tabbrbutton的位置和尺寸
    CGFloat tabbarButtonW = self.width/5;
    CGFloat tabbarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class calss = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:calss]) {
            //设置宽度
            child.width = tabbarButtonW;
            //设置X
            child.x = tabbarButtonIndex * tabbarButtonW;
            
            //增加索引
            tabbarButtonIndex++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }
    
}












@end
