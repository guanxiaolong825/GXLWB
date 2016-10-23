//
//  MyAccountTool.m
//  GXLWB
//
//  Created by administrator on 16/8/8.
//  Copyright © 2016年 administrator. All rights reserved.
//


#define MyAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"account.archive"]

#import "MyAccountTool.h"

@implementation MyAccountTool

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(MyAccount *)account
{
    //自定义对象的存储用NSKeyedArchiver 不再用什么writetofile
    [NSKeyedArchiver archiveRootObject:account toFile:MyAccountPath];
    
}

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期  返回nil）
 */
+ (MyAccount *)account
{
    //加载模型
    MyAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:MyAccountPath];
    
    //验证账号是否过期
    //过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    
    //获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    //获得当前的时间
    NSDate *now = [NSDate date];
    
    //如果now>=expiresTime 过期   反之没过期
    /*
     NSComparisonResult有三个取值
     NSOrderedAscending = -1L, 升序  右边>左边
     NSOrderedSame,  一样
     NSOrderedDescending 降序  右边< 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {//过期
        return nil;
    }
    
    return account;
}




@end
