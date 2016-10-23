//
//  MyIconView.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/14.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyIconView.h"
#import "MyUser.h"
#import "UIImageView+WebCache.h"


@interface MyIconView()

@property(nonatomic,weak) UIImageView *verifiedView;

@end

@implementation MyIconView


- (UIImageView *)verifiedView
{
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc]init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.clipsToBounds = YES;
        
        
    }
    
    return self;
}


- (void)setUser:(MyUser *)user
{
    _user = user;
    
    //1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    
    //2.设置加v图片
    switch (user.verified_type) {
//        case MyUserVerifiedTypeNone: // 没有任何认证
//            self.verifiedView.hidden = YES;
//            break;
        case MyUserVerifiedPersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case MyUserVerifiedOrgEnterprice: // 企业官方：CSDN、EOE、搜狐新闻客户端
        case MyUserVerifiedOrgMedia: // 媒体官方：程序员杂志、苹果汇
        case MyUserVerifiedOrgWebsite: // 网站官方：猫扑   官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            
            break;
        case MyUserVerifiedDaren: // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];

            break;
        default:
            self.verifiedView.hidden = YES;
            break;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat scale = 0.6;
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width-self.verifiedView.width * scale;
    self.verifiedView.y = self.height-self.verifiedView.height * scale;
    
}




//MyUserVerifiedTypeNone = -1, // 没有任何认证
//
//MyUserVerifiedPersonal = 0,  // 个人认证
//
//MyUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
//MyUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
//MyUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
//
//MyUserVerifiedDaren = 220 // 微博达人

@end
