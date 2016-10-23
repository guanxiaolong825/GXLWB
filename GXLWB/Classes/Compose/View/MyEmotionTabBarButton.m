//
//  MyEmotionTabBarButton.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/17.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyEmotionTabBarButton.h"

@implementation MyEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置文字的颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        //设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
    //按钮高亮所做的一切操作都不在了
    
}

@end
