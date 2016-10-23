//
//  MyDropDownMenu.m
//  GXLWB
//
//  Created by administrator on 16/3/24.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyDropDownMenu.h"
@interface MyDropDownMenu()
/**
 *  用来显示具体内容的容器
 */
@property (nonatomic ,weak)UIImageView *containerView;
@end
@implementation MyDropDownMenu


- (UIImageView *)containerView
{
    if (!_containerView) {
        //添加一个灰色图片
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
//        containerView.width = 217;
//        containerView.height = 217;
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;

    }
    return _containerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //清除颜色
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)setContent:(UIView *)content
{
    _content = content;
    
    //调整内容的位置
    content.x = 10;
    content.y = 15;
    
//    //调整把内容的宽度
//    content.width = self.containerView.width-2*content.x;
    
    //设置灰色的高度
    self.containerView.height = CGRectGetMaxX(content.frame) + 15;
    //设置灰色的宽度
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
//    //设置菜单的尺寸
//    self.containerView.height = CGRectGetMaxY(content.frame)+10;
//    self.containerView.width= CGRectGetMaxX(content.frame)+10;
    
    //添加内容到灰色图片中
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController  = contentController;
    self.content = contentController.view;
}

+ (instancetype)menu
{
    
    return [[self alloc]init];
}

/**
 *  显示
 */
- (void)showFrom:(UIView *)from
{
    
    //获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //添加自己到窗口上
    [window addSubview:self];
    
    //设置尺寸
    self.frame = window.bounds;
    
    
    //默认情况下frame是以父控件左上角为坐标原点
    //可以转换坐标系原点，改变frame的参照点   windew  和nil一样
    CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    CGRectGetMidX(newFrame);
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    //通知外界自己显示了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
    
}

/**
 *  销毁
 */
- (void)dismiss
{
    [self removeFromSuperview];
    
    //通知外界
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

//点击空白区域
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MYLog(@"touchesbegin");
    [self dismiss];
}



@end
