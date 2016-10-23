//
//  MyUser.m
//  GXLWB
//
//  Created by administrator on 16/8/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyUser.h"

@implementation MyUser

//set方法是调用
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

////get方法
//- (BOOL)isVip
//{
//    return self.mbrank > 2;
//}

@end
