//
//  MyLoadMoreFooter.m
//  GXLWB
//
//  Created by administrator on 16/8/17.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyLoadMoreFooter.h"

@implementation MyLoadMoreFooter


+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MyLoadMoreFooter" owner:nil options:nil]lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
