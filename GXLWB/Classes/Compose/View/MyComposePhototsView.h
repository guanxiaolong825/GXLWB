//
//  MyComposePhototsView.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/16.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyComposePhototsView : UIView

- (void)addPhoto:(UIImage *)photo;

@property (nonatomic ,strong , readonly) NSMutableArray *photos;
//- (NSArray *)photos; 

@end
