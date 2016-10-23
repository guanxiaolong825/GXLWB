//
//  MyEmotion.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/17.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEmotion : NSObject

//表情的文字描述
@property (nonatomic ,copy) NSString *chs;

//表情的图片名字
@property (nonatomic ,copy) NSString *png;

//emoji表情的16进制编码
@property (nonatomic ,copy) NSString *code;



@end
