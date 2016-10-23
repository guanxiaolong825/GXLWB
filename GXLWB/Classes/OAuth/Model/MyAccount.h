//
//  MyAccount.h
//  GXLWB
//
//  Created by administrator on 16/8/8.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

//属性存进沙盒  遵循NSCoding协议
@interface MyAccount : NSObject<NSCoding>

@property(nonatomic ,copy)NSString *access_token;
@property(nonatomic ,copy)NSNumber *expires_in;
@property(nonatomic ,copy)NSString *uid;
@property(nonatomic ,strong)NSDate *created_time;//账号创建时间

//用户的昵称
@property(nonatomic ,copy)NSString *name;


/*
 access_token	string	用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据，第三方应用应该用该票据和自己应用内的用户建立唯一影射关系，来识别登录状态，不能使用本返回值里的UID字段来做登录识别。
 expires_in	string	access_token的生命周期，单位是秒数。
 remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid
 */

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
