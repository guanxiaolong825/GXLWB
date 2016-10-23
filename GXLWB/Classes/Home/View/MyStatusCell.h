//
//  MyStatusCell.h
//  GXLWB
//
//  Created by 关晓龙 on 16/10/4.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyStatusFrame;

@interface MyStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,strong) MyStatusFrame *statusFrame;

@end
