//
//  NSString+Extension.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/12.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    //    return [text sizeWithAttributes:attrs];
    
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

@end
