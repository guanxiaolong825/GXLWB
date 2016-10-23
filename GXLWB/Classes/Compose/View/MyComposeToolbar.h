//
//  MyComposeToolbar.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/16.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MyComposeToolbarButtonTypeCamera,//拍照
    MyComposeToolbarButtonTypePicture,//相册
    MyComposeToolbarButtonTypeMention,//@
    MyComposeToolbarButtonTypeTrend,//#
    MyComposeToolbarButtonTypeEmotion,//表情

    
    
}MyComposeToolbarButtonType;


@class MyComposeToolbar;
//代理
@protocol MyComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(MyComposeToolbar *)toolbar didClickButton:(MyComposeToolbarButtonType )buttonType;

@end

@interface MyComposeToolbar : UIView

@property (nonatomic ,weak) id<MyComposeToolbarDelegate> delegate;
//是否显示键盘按钮
@property (nonatomic ,assign) BOOL showKeyBoardButton;







@end
