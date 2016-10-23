//
//  MyStatusPhotosView.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/13.
//  Copyright © 2016年 administrator. All rights reserved.
//  cell上面的配图相册，里面会显示1-9张图片 脸面都是MyStatusPhotoView

#import <UIKit/UIKit.h>

@interface MyStatusPhotosView : UIView

@property (nonatomic ,strong) NSArray * photos;

/**
 *  根据图片个数计算相册尺寸
 *
 */
+ (CGSize )sizeWithCount:(NSUInteger )count;


@end
