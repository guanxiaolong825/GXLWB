//
//  MyStatusToolbar.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/10.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyStatus;
@interface MyStatusToolbar : UIView

+ (instancetype)toolbar;

@property (nonatomic ,strong) MyStatus *status;

@end
