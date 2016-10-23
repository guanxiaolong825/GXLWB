//
//  MYNewfeatureViewController.m
//  GXLWB
//
//  Created by administrator on 16/4/21.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MYNewfeatureViewController.h"
#import "TabbarViewController.h"
#define MYNewfeatureCount 3


@interface MYNewfeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic ,weak)UIPageControl *pageControl;

@end

@implementation MYNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //创建一个scrollerView 显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    //添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i<MYNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i*scrollW;
        //显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        //如果是最后一个imageView
        if (i == MYNewfeatureCount -1) {
            [self setupLastImageView:imageView];
        }
        
    }
    
#warning scrollerView中可能会存在其他的子控件（这是子控件是系统默认存在的）
    
    //设置scrollerView的其他属性
    //如果想要某个方向不能滚动，那么这个方向对对应的尺寸数值传零
    scrollView.contentSize = CGSizeMake(MYNewfeatureCount * scrollView.width, 0);
    scrollView.bounces = NO;   //去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //添加pageController  分页  展示目前看到的第几页
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = MYNewfeatureCount;
    //UIPsageCotrol 就算没有设置尺寸  里面的内容还是可以展示的
//    pageControl.width = 100;
//    pageControl.height = 50;
//    //设置不可点击
//    pageControl.userInteractionEnabled = NO;
    pageControl.centerX = scrollW*0.5;
    pageControl.centerY = scrollH - 50;
    pageControl.currentPageIndicatorTintColor = GXLColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = GXLColor(189, 189, 189);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    double page = scrollView.contentOffset.x/scrollView.width;
    
    //四舍五入计算出页码
    self.pageControl.currentPage = (int )(page +0.5);
    
}

/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    
    //开启交互功能（imageView默认没有交互）
    imageView.userInteractionEnabled = YES;
    
    //分享给大家（checkbox）
    UIButton *shareBtn = [[UIButton alloc]init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 120;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width *0.5;
    shareBtn.centerY = imageView.height *0.65;
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    
    //开始微博
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateSelected];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height*0.8;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
}

- (void)shareClick:(UIButton *)shareBtn
{
    //状态去反
    shareBtn.selected = !shareBtn.isSelected;
    
}

- (void)startClick
{
    //切换到TabbarviewController
    /*
     切换控制器的方法
     1.push  依赖于UINavigationcontroller，push控制器的切换时可逆的。比如A切换到B，B又可以回到A
     2.modal  控制器的切换时可逆的 比如A切换到B，B又可以回到A  presentViewController
     3.切换window的rootViewController
     */
    
    //主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[TabbarViewController alloc]init];
    
}

- (void)dealloc
{
    MYLog(@"NewFeatureViewController - dealloc");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 
   一个控件看不见的可能性
   1.根本没有创建实例化这个控件
   2.没有设置尺寸
   3.控件的颜色可能跟父控件的背景色一样（实际上已经显示了）
   4.透明度alpha《= 0.01
   5.hidden = YES
   6.没有添加到父控件
   7.被其他控件挡住了
   8.位置不对
   9.父控件发生了以上情况
   10.特殊情况：
      uiimageView没有设置image属性 ，或者设置的图片名不对
      UITextField没有设置文字或者没有设置边框的样式boardStyle
      uilabel 没有设置文字 或者文字颜色和父控件背景颜色一样
      uipageControl 没有设置总页数 不会显示小圆点
      UIButton内部imageView和titleLabel的frame呗篡改，或者imageView和titleLabel没有内容
      ......
    
    添加一个控件的建议（调试技巧）
    1最好设置背景色和尺寸
    2控件的颜色尽量不要跟父控件的背景色一样
 
 */
@end
