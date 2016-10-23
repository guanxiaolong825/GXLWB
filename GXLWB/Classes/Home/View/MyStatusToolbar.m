//
//  MyStatusToolbar.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/10.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyStatusToolbar.h"
#import "MyStatus.h"


@interface MyStatusToolbar()


/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak)UIButton *repostBtn;
@property (nonatomic, weak)UIButton *commentBtn;
@property (nonatomic, weak)UIButton *attitudeBtn;

@end



@implementation MyStatusToolbar


- (NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}


+ (instancetype)toolbar
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //timeline_card_bottom_line_highlighted
        
        self.backgroundColor = [UIColor whiteColor];
       
        self.repostBtn = [self setupBtn:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtn:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self setupBtn:@"赞" icon:@"timeline_icon_unlike"];
        
        // 添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

/**
 * 添加分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

//初始化一个按钮
- (UIButton *)setupBtn:(NSString *)title icon:(NSString *)icon
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    return btn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.btns.count;
    CGFloat btnW = self.width/count;
    CGFloat btnH = self.height;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.btns[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i*btnW;
        btn.height = btnH;
    }
    
    //设置分割线的frame
    NSUInteger dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }
    
}



- (void)setStatus:(MyStatus *)status
{
    _status = status;
    
    
    
    //转发
    [self setupBtnCount:status.reposts_count btn:self.repostBtn Title:@"转发"];
    
//    if (status.reposts_count) {
//        NSString *title = [NSString stringWithFormat:@"%d",status.reposts_count];
//        [self.repostBtn setTitle:title forState:UIControlStateNormal];
//    }else
//    {
//        [self.repostBtn setTitle:@"转发" forState:UIControlStateNormal];
//    }
    
    //评论
    [self setupBtnCount:status.comments_count btn:self.commentBtn Title:@"评论"];
    
    //赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn Title:@"赞"];
}



- (void)setupBtnCount:(int )count btn:(UIButton *)btn Title:(NSString *)title
{
    
    if (count) {//数字不是零
        /*
         不足一万直接显示数字
         达到一万 显示xx.x万
         */
        if (count<10000) {//不足一万
            
            title = [NSString stringWithFormat:@"%d",count];
            
        }else{//超过一万
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            
            //把字符串中的.0清空
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:title forState:UIControlStateNormal];
        
    }else
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
}










@end
