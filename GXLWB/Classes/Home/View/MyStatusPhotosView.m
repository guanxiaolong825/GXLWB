//
//  MyStatusPhotosView.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/13.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyStatusPhotosView.h"
#import "MyPhoto.h"
#import "UIImageView+WebCache.h"
#import "MyStatusPhotoView.h"


#define MyStatusPhotoWH 70
#define MyStatusPhotoMargin 10
#define MyStatusPhotoMaxCol(count) ((count == 4)?2:3)

@implementation MyStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    NSUInteger photosCount = self.photos.count;
    
    //创建足够数量的imageView
//    if (self.subviews.count>=photos.count) {//内部的imageView够用
//        
//        
//    }else{//内部的imageView不够用
        //创建缺少的imageView
        while (self.subviews.count<photosCount) {
            MyStatusPhotoView *photoView = [[MyStatusPhotoView alloc]init];
            [self addSubview:photoView];
            
        }
        
//    }
    
    //遍历图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        MyStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) {//显示
//            MyPhoto *photo = photos[i];
            photoView.photo = photos[i];
            photoView.hidden = NO;
            
            
            //设置图片
//            [photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
        }else{//隐藏
            photoView.hidden = YES;
        }
        
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger photosCount = self.photos.count;
    
    NSInteger maxCol = MyStatusPhotoMaxCol(photosCount);
    
    //设置imageView的尺寸位置
    for (int i = 0; i<photosCount; i++) {
        MyStatusPhotoView *photoView = self.subviews[i];
        
        int col = i%maxCol;
        photoView.x = col*(MyStatusPhotoWH+MyStatusPhotoMargin);
        int row = i/maxCol;
        photoView.y = row*(MyStatusPhotoMargin+MyStatusPhotoWH);
        photoView.width = MyStatusPhotoWH;
        photoView.height = MyStatusPhotoWH;

    }
    
}

+ (CGSize )sizeWithCount:(NSUInteger )count
{
    
    NSUInteger maxCol = MyStatusPhotoMaxCol(count);
    
    //列数
    NSUInteger cols = count>=maxCol ? maxCol:count;
    CGFloat photosW = cols * MyStatusPhotoWH +(cols-1)*MyStatusPhotoMargin;
    
    
    //行数
    //    NSInteger rows = 0;
    //    if (count%3 == 0) {
    //        rows = count/3;
    //    }else {
    //        rows = count/3+1;
    //    }
    NSUInteger rows = (count + maxCol - 1)/maxCol;
    
    CGFloat photosH = rows * MyStatusPhotoWH +(rows-1)*MyStatusPhotoMargin;
    
    
    return CGSizeMake(photosW,photosH);
    
}


@end









