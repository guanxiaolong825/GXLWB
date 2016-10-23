//
//  MyEmotionTextView.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyEmotionTextView.h"

@implementation MyEmotionTextView


- (void)insertEmotion:(MyEmotion *)emotion
{
    
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    }else if(emotion.png)
    {
        
//        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
//        
//        //拼接之前的文字（图片和普通文字）
//        [attributedText appendAttributedString:self.attributedText];
        
        
        //加载图片
        NSTextAttachment *attch = [[NSTextAttachment alloc]init];
        attch.image = [UIImage imageNamed:emotion.png];
        CGFloat attchWH = self.font.lineHeight;//字体文字的高度
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        
        //插入属性文字到光标处
        [self insertAttributeText:imageStr settingBlock:^(NSMutableAttributedString *attributeText) {
            //设置字体
            [attributeText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributeText.length)];
        }];
        
        //设置字体
//        NSMutableAttributedString *attributedText = (NSMutableAttributedString *)self.attributedText;
//        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
//        self.attributedText = attributedText;
        

//        //拼接图片
//        //        [attributedText appendAttributedString:imageStr];
//        NSUInteger loc = self.selectedRange.location;
//        //插入光标索引位置
//        [attributedText insertAttributedString:imageStr atIndex:loc];
//        
//        
//        //设置字体
//        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
//        //设置文字
//        self.attributedText = attributedText;
//        
//        //移动光标到表情的后面
//        self.selectedRange = NSMakeRange(loc+1, 0);
    }
    
    
}



@end
