//
//  MyEmotionPopView.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyEmotion;

@interface MyEmotionPopView : UIView

@property (nonatomic ,strong) MyEmotion *emotion;

+(instancetype)popView;

@end
