//
//  MyStatusCell.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/4.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyStatusCell.h"
#import "MyUser.h"
#import "MyStatus.h"
#import "MyStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "MyPhoto.h"
#import "MyStatusToolbar.h"
#import "MyStatusPhotosView.h"
#import "MyIconView.h"

@interface MyStatusCell()
//原创微博
//原创微博整体
@property(nonatomic,weak)UIView *originalView;
//头像
@property(nonatomic,weak)MyIconView *iconView;
//配图
@property(nonatomic,weak)MyStatusPhotosView *photosView;
//会员图标
@property(nonatomic,weak)UIImageView *vipView;
//昵称
@property(nonatomic,weak)UILabel *nameLabel;
//时间
@property(nonatomic,weak)UILabel *timeLabel;
//来源
@property(nonatomic,weak)UILabel *sourceLabel;
//正文
@property(nonatomic,weak)UILabel *contentLabel;

//转发微博  转发微博整体
@property (nonatomic ,weak) UIView *retweetView;

//转发微博正文
@property(nonatomic,weak)UILabel *retweetContentLabel;

//转发微博的配图
@property(nonatomic,weak)MyStatusPhotosView *retweetPhotosView;


//工具条
@property (nonatomic ,weak) MyStatusToolbar *toolbar;



@end

@implementation MyStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    MyStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MyStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

//cell的初始化方法，一个cell只会调用一次  一般在这里添加所有可能显示的子空间，以及子控件的一次性设置
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化原创微博
        [self setupOriginal];
        
        //初始化转发微博
        [self setupRetweet];
        
        //初始化工具条
        [self setupToolbar];
        
    }
    return self;
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y += MYStatusCellMargin;
//    [super setFrame:frame];
//    
//}

//初始化工具条
- (void)setupToolbar
{
    MyStatusToolbar *toolbar = [MyStatusToolbar toolbar];
//    toolbar.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
    
    
    
    
    
}

//初始化原创微博
- (void)setupOriginal
{
    //原创微博的整体
    UIView *originalView = [[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    //头像
    MyIconView *iconView = [[MyIconView alloc]init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    //配图
    MyStatusPhotosView *photosView = [[MyStatusPhotosView alloc]init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    
    
    
    //会员图标
    UIImageView *vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    //昵称
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = MyStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    //时间
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = MyStatusCellTimeFont;
    [originalView addSubview:timeLabel];
    timeLabel.textColor = [UIColor orangeColor];
    self.timeLabel = timeLabel;
    //来源
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = MyStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    //正文
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = MyStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

//初始化转发微博
- (void)setupRetweet
{
    
    //转发微博的整体
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = GXLColor(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    //转发微博正文+昵称
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = MyStatusCellRetweetContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    //转发微博的配图
    MyStatusPhotosView *retweetPhotosView = [[MyStatusPhotosView alloc]init];
    retweetPhotosView.contentMode = UIViewContentModeCenter;
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
    
    
}

- (void)setStatusFrame:(MyStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    MyStatus *status = statusFrame.status;
    MyUser *user = status.user;
    
    //原创微博的整体
    self.originalView.frame = statusFrame.originalViewF;
    
    //头像
    self.iconView.frame = statusFrame.iconViewF;
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.user = user;
    
    //配图
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
        
        self.photosView.hidden = NO;
    }else{
        
        self.photosView.hidden = YES;
    }
    
    
    //会员图标
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else
    {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    
    //昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    
    //时间
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + MYStatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithFont:MyStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    //时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(statusFrame.timeLabelF) + MYStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:MyStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    //来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    
    //正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    
    //被转发的微博
    if (status.retweeted_status) {
        
        MyStatus *retweeted_status = status.retweeted_status;
        MyUser *reweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        //被转发微博的整体
        self.retweetView.frame = statusFrame.retweetViewF;
        
        //被转发微博的正文
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",reweeted_status_user.name,retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        //转发微博的配图
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            
            self.retweetPhotosView.hidden = NO;
        }else{
            
            self.retweetPhotosView.hidden = YES;
        }
        
    }else{
        self.retweetView.hidden = YES;
    }
    
    //工具条
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
