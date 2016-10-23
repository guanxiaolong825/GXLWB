//
//  MyUser.h
//  GXLWB
//
//  Created by administrator on 16/8/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

//枚举
typedef enum {
    MyUserVerifiedTypeNone = -1, // 没有任何认证
    
    MyUserVerifiedPersonal = 0,  // 个人认证
    
    MyUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    MyUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    MyUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    MyUserVerifiedDaren = 220 // 微博达人
}MyUserVerifiedType;


@interface MyUser : NSObject

@property(nonatomic ,copy)NSString *idstr;
@property(nonatomic ,copy)NSString *name;
@property(nonatomic ,copy)NSString *profile_image_url;

//会员类型 >2 才代表是会员
@property (nonatomic ,assign) int mbtype;
//会员等级
@property (nonatomic ,assign) int mbrank;

@property (nonatomic ,assign ,getter=isVip) BOOL vip;

//认证类型
@property (nonatomic ,assign) MyUserVerifiedType verified_type;

@end


/*
 id	int64	用户UID
 idstr	string	字符串型的用户UID
 screen_name	string	用户昵称
 name	string	友好显示名称
 province	int	用户所在省级ID
 city	int	用户所在城市ID
 location	string	用户所在地
 description	string	用户个人描述
 url	string	用户博客地址
 profile_image_url	string	用户头像地址（中图），50×50像素
 */

















