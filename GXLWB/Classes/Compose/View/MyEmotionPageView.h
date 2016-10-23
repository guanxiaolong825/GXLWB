//
//  MyEmotionPageView.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/17.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>


// 一页中最多3行
#define MyEmotionMaxRows 3
// 一行中最多7列
#define MyEmotionMaxCols 7
// 每一页的表情个数
#define MyEmotionPageSize ((MyEmotionMaxRows * MyEmotionMaxCols) - 1)


@interface MyEmotionPageView : UIView

//这一页显示的表情（里面是MyEmotion模型）
@property (nonatomic ,strong) NSArray *emotions;

@end
