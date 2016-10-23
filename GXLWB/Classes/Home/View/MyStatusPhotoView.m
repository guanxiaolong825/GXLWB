//
//  MyStatusPhotoView.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/14.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyStatusPhotoView.h"
#import "MyPhoto.h"
#import "UIImageView+WebCache.h"

@interface MyStatusPhotoView()
@property(nonatomic,weak)UIImageView *gifView;
@end

@implementation MyStatusPhotoView

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        /*
         UIViewContentModeScaleToFill,         //图片拉伸至填充整个imageView（图片可能变形）
         UIViewContentModeScaleAspectFit,      //图片拉伸至完全显示在imageView里面位置（图片不变形）
         UIViewContentModeScaleAspectFill,     // 图片拉伸至图片的宽度或者高度同imageView相同为止
         UIViewContentModeRedraw,              // 调用了setNeedDisplay方法时，就会将图片重新渲染
         UIViewContentModeCenter,              // 居中显示
         UIViewContentModeTop,
         UIViewContentModeBottom,
         UIViewContentModeLeft,
         UIViewContentModeRight,
         UIViewContentModeTopLeft,
         UIViewContentModeTopRight,
         UIViewContentModeBottomLeft,
         UIViewContentModeBottomRigh
         
         经验规律
         1.凡是带有Scal单词的，图片都会拉伸
         2.凡是带有Aspect单词的，图片都会保持原来的宽高比，图片不会变形
         
         
         */
        
        
        
        //内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;//超出边框的内容减掉（删掉）
        
    }
    return self;
}


- (void)setPhoto:(MyPhoto *)photo
{
    _photo = photo;
    
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //显示或者隐藏gif图片
//    if ([photo.thumbnail_pic hasSuffix:@"gif"]) {//是否是gif结尾
//        self.gifView.hidden = NO;
//        
//    }else{
//        self.gifView.hidden = YES;
//        
//    }
    
    //显示或者隐藏gif图片 判断是否以gif或者GIF结尾
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];//变为小写lowercaseString
    
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width-self.gifView.width;
    self.gifView.y = self.height-self.gifView.height;
    
}

@end








