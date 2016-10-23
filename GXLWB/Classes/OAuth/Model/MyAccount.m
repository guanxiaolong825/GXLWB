//
//  MyAccount.m
//  GXLWB
//
//  Created by administrator on 16/8/8.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyAccount.h"

@implementation MyAccount
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    MyAccount *account = [[self alloc]init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    
    //获得账号存储的时间（accessToken的产生时间）
    account.created_time = [NSDate date];
    
    return account;
}

/**
 *  当一个对象要归档近沙盒中时 会调用这个方法
 *  目的是，在这个方法中说明这个对象的那些属性要存入沙盒中
 
 *  @param encoder
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
    [encoder encodeObject:self.name forKey:@"name"];

}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时） 会调用这个方法
 *  目的是，在这个方法中说明沙盒中的属性怎么解析（需要去那些属性）
 
 *  @param encoder
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
        self.name = [decoder decodeObjectForKey:@"name"];

    }
    return self;
}

@end
