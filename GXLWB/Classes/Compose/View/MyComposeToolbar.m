//
//  MyComposeToolbar.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/16.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyComposeToolbar.h"

@interface MyComposeToolbar ()
@property(nonatomic,weak)UIButton *emotionButton;

@end

@implementation MyComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
//        MyComposeToolbarButtonTypeCamera,//拍照
//        MyComposeToolbarButtonTypePicture,//相册
//        MyComposeToolbarButtonTypeMention,//@
//        MyComposeToolbarButtonTypeTrend,//#
//        MyComposeToolbarButtonTypeEmotion,//表情
        
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:MyComposeToolbarButtonTypeCamera];
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:MyComposeToolbarButtonTypePicture];
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:MyComposeToolbarButtonTypeMention];
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:MyComposeToolbarButtonTypeTrend];
        self.emotionButton = [self setupBtn:@"compose_keyboardbutton_background" highImage:@"compose_keyboardbutton_background_highlighted" type:MyComposeToolbarButtonTypeEmotion];

        
    }
    return self;
}

- (UIButton *)setupBtn:(NSString *)image highImage:(NSString *)heightImage type:(MyComposeToolbarButtonType )tag
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self addSubview:btn];
    
    return btn;
    
}

- (void)setShowKeyBoardButton:(BOOL)showKeyBoardButton
{
    _showKeyBoardButton = showKeyBoardButton;
    
    //默认图片
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    if (showKeyBoardButton) {//显示键盘图标
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置所有按钮的frame
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width/count;
    CGFloat btnH = self.height;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i*btnW;
        btn.height = btnH;
    }
    
}


- (void)btnClick:(UIButton *)btn
{
    //代理
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
//        NSUInteger index = (NSUInteger)(btn.x/btn.width);
        [self.delegate composeToolbar:self didClickButton:(MyComposeToolbarButtonType)btn.tag];
    }
    
}






@end
