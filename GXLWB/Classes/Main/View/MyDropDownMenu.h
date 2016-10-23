//
//  MyDropDownMenu.h
//  GXLWB
//
//  Created by administrator on 16/3/24.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

//写代理
@class MyDropDownMenu;

@protocol MYDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuDidDismiss:(MyDropDownMenu *)menu;
- (void)dropdownMenuDidShow:(MyDropDownMenu *)menu;
@end


@interface MyDropDownMenu : UIView


@property (nonatomic ,weak) id<MYDropdownMenuDelegate> delegate;


+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;

/**
 *  销毁
 */
- (void)dismiss;

/**
 *  内容
 */
@property (nonatomic ,strong) UIView *content;

/**
 *  内容控制器
 */
@property (nonatomic ,strong)UIViewController *contentController;
@end
