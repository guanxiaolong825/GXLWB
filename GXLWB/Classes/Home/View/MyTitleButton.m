//
//  MyTitleButton.m
//  GXLWB
//
//  Created by administrator on 16/8/10.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyTitleButton.h"

#define MyMargin 10

@implementation MyTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.imageView.contentMode = UIViewContentModeCenter;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        
//        self.backgroundColor = [UIColor clearColor];
//        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.imageView.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

/**
 *  设置按钮内部的imageView的frame
 *
 *  @param contentRect 按钮的bounds
 */
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    CGFloat x = 80;
//    CGFloat y = 0;
//    CGFloat width = 13;
//    CGFloat height = contentRect.size.height;
//    return CGRectMake(x, y, width, height);
//}

/**
 *  设置按钮内部的titleView的frame
 *
 *  @param contentRect 按钮的bounds
*/
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    // 如果调用self.titlelabel会造成循环引用
//    CGFloat x = 0;
//    CGFloat y = 0;
//    CGFloat width = 80;
//    CGFloat height = contentRect.size.height;
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = self.titleLabel.font;
//    CGFloat titleW = [self.currentTitle sizeWithAttributes:attrs].width;
//    //此处可以拿到问题  self.cuurrenttitle
//    
//    return CGRectMake(x, y, width, height);
//
//}


//目的：在系统计算和设置完按钮的尺寸后，再修改一下尺寸
//如果想在系统设置完空间的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame中设置
//self.frame = cgrect  重写setframe方法
- (void)setFrame:(CGRect)frame
{
    frame.size.width += MyMargin;
    [super setFrame:frame];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //如果仅仅是调整按钮内部的titleLabel和imageView的位置 那么在layoutSubview中单独设置位置即可
    
    //1.计算titleLabel的frame
    self.titleLabel.x = self.imageView.x;
    
    //2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + MyMargin;
    
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    //设置按钮的自适应
    [self sizeToFit];
}


- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}


@end
