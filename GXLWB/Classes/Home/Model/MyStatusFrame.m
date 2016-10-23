//
//  MyStatusFrame.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/4.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyStatusFrame.h"
#import "MyStatus.h"
#import "MyUser.h"
#import "MyStatusPhotosView.h"

//#define MyStatusPhotoWH 70
//#define MyStatusPhotoMargin 10


@implementation MyStatusFrame


- (void)setStatus:(MyStatus *)status
{
    _status = status;
    
    MyUser *user = status.user;
    
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    //原创微博
    //头像
    CGFloat iconWH = 35;
    CGFloat iconX = MYStatusCellBorderW;
    CGFloat iconY = MYStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + MYStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:MyStatusCellNameFont];
//    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    
    //会员图标
    if (status.user.isVip){//是会员
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF)+MYStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + MYStatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithFont:MyStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + MYStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:MyStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    //正文
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF))+MYStatusCellBorderW;
    CGFloat maxW = cellW - 2*contentX;
    CGSize contentSize = [status.text sizeWithFont:MyStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    
    //配图
    CGFloat originalH = 0;
    if (status.pic_urls.count) {//有配图
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabelF) + MYStatusCellBorderW;
        CGSize photosSize = [MyStatusPhotosView sizeWithCount:status.pic_urls.count];
        self.photosViewF = (CGRect){{photosX,photosY},photosSize};
//        CGRectMake(photosX, photosY, photosWH, photosWH);
        
        originalH = CGRectGetMaxY(self.photosViewF)+MYStatusCellBorderW;
    }else{//没有配图
        
        originalH = CGRectGetMaxY(self.contentLabelF)+MYStatusCellBorderW;
        
    }
    
    //原创微博整体
    CGFloat originalX = 0;
    CGFloat originalY = MYStatusCellMargin;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    CGFloat toolbarY = 0;
    //被转发微博
    if (status.retweeted_status) {
        
        MyStatus *retweeted_status = status.retweeted_status;
        MyUser *reweeted_status_user = retweeted_status.user;
        
        //被转发微博的正文
        CGFloat retweetContentX = MYStatusCellBorderW;
        CGFloat retweetContentY = MYStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",reweeted_status_user.name,retweeted_status.text];
        CGSize retweetContentSize = [retweetContent sizeWithFont:MyStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        //被转发微博的配图
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) {//转发微博有配图
            CGFloat retweetPhotosX = retweetContentX;
            CGFloat retweetPhotosY = CGRectGetMaxY(self.retweetContentLabelF) + MYStatusCellBorderW;
            CGSize retweetphotosSize = [MyStatusPhotosView sizeWithCount:retweeted_status.pic_urls.count];
            self.retweetPhotosViewF = (CGRect){{retweetPhotosX,retweetPhotosY},retweetphotosSize};
            
            retweetH = CGRectGetMaxY(self.retweetPhotosViewF) +MYStatusCellBorderW;
        }else{//转发微博没有配图
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) +MYStatusCellBorderW;

        }

        //被转发微博的整体
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewF);
        
//        self.cellHeight = CGRectGetMaxY(self.retweetViewF);
        
    }else{
        toolbarY = CGRectGetMaxY(self.originalViewF);
//        self.cellHeight = CGRectGetMaxY(self.originalViewF);
    }
    
    
    //工具条
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    //cell的高度
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
    
    
    
}












@end
