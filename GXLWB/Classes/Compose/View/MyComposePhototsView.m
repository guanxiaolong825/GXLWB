//
//  MyComposePhototsView.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/16.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyComposePhototsView.h"

@interface MyComposePhototsView()
//@property(nonatomic,strong) NSMutableArray *addedPhotos;

@end

@implementation MyComposePhototsView


////懒加载
//- (NSMutableArray *)addedPhotos
//{
//    if (!_addedPhotos) {
//        self.addedPhotos = [NSMutableArray array];
//        
//    }
//    return _addedPhotos;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}

- (void)addPhoto:(UIImage *)photo
{
    UIImageView *photoView = [[UIImageView alloc]init];
    photoView.image = photo;
    [self addSubview:photoView];
    
    //存储图片
    [self.photos addObject:photo];
}


- (void)layoutSubviews
{
    [super layoutSubviews]; 
    
    NSUInteger count = self.subviews.count;
    
    NSInteger maxCol = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    
    //设置imageView的尺寸位置
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        
        int col = i%maxCol;
        photoView.x = col*(imageWH+imageMargin);
        int row = i/maxCol;
        photoView.y = row*(imageWH+imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
        
    }
    
    
}

//- (NSArray *)photos
//{
//    return self.addedPhotos;
//}

//- (NSArray *)photos
//{
//    NSMutableArray *photots = [NSMutableArray array];
//    for (UIImageView *imageView in self.subviews) {
//        [photots addObject:imageView.image];
//    }
//    return photots;
//}




@end
