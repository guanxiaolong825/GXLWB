//
//  MyStatusFrame.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/4.
//  Copyright © 2016年 administrator. All rights reserved.
//  一个MyStatusFrame模型存放一个cell内部所有子空间的frame数据，存放一个cell的高度，存放着一个数据模型MyStatus

#import <Foundation/Foundation.h>

//昵称字体
#define MyStatusCellNameFont [UIFont systemFontOfSize:15]

//时间字体
#define MyStatusCellTimeFont [UIFont systemFontOfSize:12]

//来源字体
#define MyStatusCellSourceFont [UIFont systemFontOfSize:12]

//正文字体
#define MyStatusCellContentFont [UIFont systemFontOfSize:14]

//被转发微博的正文字体
#define MyStatusCellRetweetContentFont [UIFont systemFontOfSize:13]


//cell之间的间距
#define MYStatusCellMargin 15


//cell的边框宽度
#define MYStatusCellBorderW 10

@class MyStatus;

@interface MyStatusFrame : NSObject

@property (nonatomic ,strong) MyStatus *status;


//原创微博整体
@property(nonatomic,assign)CGRect originalViewF;
//头像
@property(nonatomic,assign)CGRect iconViewF;
//配图
@property(nonatomic,assign)CGRect photosViewF;
//会员图标
@property(nonatomic,assign)CGRect vipViewF;
//昵称
@property(nonatomic,assign)CGRect nameLabelF;
//时间
@property(nonatomic,assign)CGRect timeLabelF;
//来源
@property(nonatomic,assign)CGRect sourceLabelF;
//正文
@property(nonatomic,assign)CGRect contentLabelF;
//cell的高度
@property(nonatomic,assign)CGFloat cellHeight;



//转发微博  转发微博整体
@property (nonatomic ,assign) CGRect retweetViewF;

//转发微博正文
@property(nonatomic,assign)CGRect retweetContentLabelF;

//转发微博的配图
@property(nonatomic,assign)CGRect retweetPhotosViewF;

//底部toolbar工具条
@property(nonatomic,assign)CGRect toolbarF;


@end
