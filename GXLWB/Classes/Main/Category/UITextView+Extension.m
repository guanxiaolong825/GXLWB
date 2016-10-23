//
//  UITextView+Extension.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)


- (void)insertAttributeText:(NSAttributedString *)text
{
    
    [self insertAttributeText:text settingBlock:nil];
//    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
//    
//    //拼接之前的文字（图片和普通文字）
//    [attributedText appendAttributedString:self.attributedText];
//    
//    //拼接图片
//    NSUInteger loc = self.selectedRange.location;
//    //插入光标索引位置
//    [attributedText insertAttributedString:text atIndex:loc];
//    
//    
////    //设置字体
////    [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
//    //设置文字
//    self.attributedText = attributedText;
//    
//    //移动光标到表情的后面
//    self.selectedRange = NSMakeRange(loc+1, 0);
//    
//    return attributedText;
}

- (void)insertAttributeText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
    
    //拼接之前的文字（图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];
    
    //拼接图片
    NSUInteger loc = self.selectedRange.location;
    //插入光标索引位置
    [attributedText insertAttributedString:text atIndex:loc];
    
    //调用外面传进来的代码
    if (settingBlock) {
        settingBlock(attributedText);
    }
    
    //设置文字
    self.attributedText = attributedText;
    
    //移动光标到表情的后面
    self.selectedRange = NSMakeRange(loc+1, 0);
    
    
}


@end
