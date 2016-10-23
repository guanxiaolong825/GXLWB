 //
//  MyEmotionButton.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyEmotionButton.h"
#import "MyEmotion.h"


@implementation MyEmotionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    
    //按钮高亮是不要调整图片颜色为灰色
    self.adjustsImageWhenHighlighted = NO;
}

- (void)setEmotion:(MyEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        
    }else if (emotion.code){
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
        
    }
    
}


//- (void)setHighlighted:(BOOL)highlighted
//{
//    
//}





@end
