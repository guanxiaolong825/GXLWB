//
//  MyTextView.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/15.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        //不要设置自己的delegate为自己
//        self.delegate = self;
        
        //通知
        //当UITextView的文字改变时，UITextView会自己发出UITextViewTextDidChangeNotification通知
        [MyNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        
        
    }
    return self;
}

- (void)dealloc
{
    [MyNotificationCenter removeObserver:self];
}

/**
 *  监听文字的改变
 */
- (void)textDidChange
{
    
    //重绘（重新调用）
    [self setNeedsDisplay];
    
}


- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}


- (void)setText:(NSString *)text
{
    [super setText:text];
    
    //setNeedsDisplay 会在下一个消息循环，调用drawRect
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
//    [self.placeholderColor set];
    
    //如果有输入文字就直接返回  不画占位文字
    if (self.hasText) return;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor grayColor];
//    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    
    
    CGFloat x = 5;
    CGFloat w = rect.size.width-2*x;
    CGFloat y = 8;
    CGFloat h = rect.size.height-2*y;
    CGRect placeHolderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeHolderRect withAttributes:attrs];//将占位图 限制在一个区域
}



@end
