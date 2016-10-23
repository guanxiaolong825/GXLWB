//
//  MyEmotionPageView.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/17.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyEmotionPageView.h"
#import "MyEmotion.h"
#import "MyEmotionPopView.h"
#import "MyEmotionButton.h"

@interface MyEmotionPageView ()
//点击表情按钮后弹出的放大镜
@property (nonatomic ,strong) MyEmotionPopView *popView;
//删除按钮
@property  (nonatomic ,weak) UIButton *deleteButton;

@end


@implementation MyEmotionPageView

- (MyEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [MyEmotionPopView popView];
    }
    return _popView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteBtn = [[UIButton alloc]init];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [self addSubview:deleteBtn];
        [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton = deleteBtn;
        
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i<count; i++) {
        MyEmotionButton *btn = [[MyEmotionButton alloc]init];
        btn.emotion = emotions[i];
        [self addSubview:btn];
        
        //设置表情数组
        MyEmotion *emotion = emotions[i];
        if (emotion.png) {
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];

        }else if (emotion.code){
            [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];

        }
        
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    
}


- (void)layoutSubviews
{
    
    //内边距
    CGFloat inset = 10;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width-2*inset)/MyEmotionMaxCols;
    CGFloat btnH = (self.height-inset)/MyEmotionMaxRows;
    for (int i =0; i<count; i++) {
        UIButton *btn = self.subviews[i+1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset+(i%MyEmotionMaxCols)*btnW;
        btn.y = inset+(i/MyEmotionMaxCols)*btnH;
    }
    
    //删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.y = self.height -btnH;
    self.deleteButton.x = self.width-inset-btnW;
    
}


- (void)btnClick:(MyEmotionButton *)btn
{
    //给popView传数据
    self.popView.emotion = btn.emotion;
    

    
    //取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self.popView];
    //计算出被点击按钮在window上的frame
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];//或者window和nil都可以
    
    self.popView.y = CGRectGetMidY(btnFrame)-self.popView.height;
    self.popView.centerX = CGRectGetMidX(btnFrame);
    
    //等会让按钮自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[MySelectEmotionKey] = btn.emotion;
    [MyNotificationCenter postNotificationName:MyEmotionDidSelectedNotification object:nil userInfo:userInfo];
    
}

- (void)deleteClick
{
    
     [MyNotificationCenter postNotificationName:MyEmotionDidDeleteNotification object:nil userInfo:nil];
    
}










@end
