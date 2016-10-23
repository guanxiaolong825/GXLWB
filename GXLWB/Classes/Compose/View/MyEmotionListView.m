//
//  MyEmotionListView.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/16.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyEmotionListView.h"
#import "MyEmotionPageView.h"


@interface MyEmotionListView ()<UIScrollViewDelegate>

@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,weak) UIPageControl *pageControl;

@end

@implementation MyEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        //1.UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        //去除水平方向的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        //去除垂直方向的滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        //只有一页是自动隐藏pageControl
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        //设置内部的原点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
    }
    return self;
}


- (void)setEmotions:(NSArray *)emotions
{
    
    _emotions = emotions;
    
    NSUInteger count = (emotions.count + MyEmotionPageSize -1) / MyEmotionPageSize;
    
    //设置页数
    self.pageControl.numberOfPages = count;
    
    //创建用来显示每一页表情的控件
    for (int i = 0; i<count; i++) {
        MyEmotionPageView *pageView = [[MyEmotionPageView alloc]init];
//        pageView.backgroundColor = [UIColor redColor];
        
        //计算这一页的表情范围
        NSRange range;
        range.location = i*MyEmotionPageSize;
        NSUInteger left = emotions.count - range.location;
        
        range.length = left >= MyEmotionPageSize ? MyEmotionPageSize : left;
        
        //设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        
        [self.scrollView addSubview:pageView];
        
        
    }
    
}


- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    //pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height-self.pageControl.height;
    
    //scrollerView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    //设置scrollerView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int  i = 0; i<count; i++) {
        MyEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width*i;
        pageView.y = 0;
        
    }
    
    //设置scrollerView的contentSize
    self.scrollView.contentSize = CGSizeMake(count*self.scrollView.width, 0);
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage = (int )(pageNo+0.5);
}












@end
