//
//  MyAccountTool.h
//  GXLWB
//
//  Created by administrator on 16/8/8.
//  Copyright © 2016年 administrator. All rights reserved.
//处理与账号有关的所有操作  存储账号 取出账号  验证账号

#import <Foundation/Foundation.h>
#import "MyAccount.h"

//业务逻辑 

@interface MyAccountTool : NSObject

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(MyAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期  返回nil）
 */
+ (MyAccount *)account;

@end
