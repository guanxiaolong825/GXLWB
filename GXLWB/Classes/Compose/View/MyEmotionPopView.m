//
//  MyEmotionPopView.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyEmotionPopView.h"
#import "MyEmotion.h"
#import "MyEmotionButton.h"

@interface MyEmotionPopView()

@property (weak, nonatomic) IBOutlet MyEmotionButton *emtionButton;

@end

@implementation MyEmotionPopView


+(instancetype)popView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"MyEmotionPopView" owner:nil options:nil]lastObject];
}


- (void)setEmotion:(MyEmotion *)emotion
{
    _emotion = emotion;
    
    self.emtionButton.emotion = emotion;
    
    
}












@end
