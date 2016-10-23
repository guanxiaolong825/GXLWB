//
//  UITextView+Extension.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

- (void)insertAttributeText:(NSAttributedString *)text;

//需要设置字体
- (void)insertAttributeText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString *attributeText))settingBlock;

@end
