//
//  MyTextView.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/15.
//  Copyright © 2016年 administrator. All rights reserved.
//  增强：带有站位文字

#import <UIKit/UIKit.h>

@interface MyTextView : UITextView

//站为文字
@property (nonatomic ,copy) NSString *placeholder;
//占位文字颜色
@property (nonatomic ,strong) UIColor *placeholderColor;


@end
