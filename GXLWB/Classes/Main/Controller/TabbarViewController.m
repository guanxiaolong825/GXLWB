//
//  TabbarViewController.m
//  GXLWB
//
//  Created by administrator on 16/2/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "TabbarViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "GXLNavigationController.h"
#import "MyTabBar.h"
#import "MyComposeViewController.h"

@interface TabbarViewController ()<MyTabBarDelegate>

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置子控制器
    HomeViewController *home = [[HomeViewController alloc]init];
    [self addChildVc:home Title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    MessageViewController *message = [[MessageViewController alloc]init];
    [self addChildVc:message Title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    DiscoverViewController *discover = [[DiscoverViewController alloc]init];
    [self addChildVc:discover Title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    ProfileViewController *profile = [[ProfileViewController alloc]init];
    [self addChildVc:profile Title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    //更换系统自带的tabbar  用的KVC
//    self.tabBar = [[MyTabBar alloc]init];
    MyTabBar *tabBar = [[MyTabBar alloc]init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    
    //很多重复代码  抽取代码
    //1、相同的代码放到一个方法
    //2、不同的东西编程参数
    //3、在使用到这段代码的这个地方调用方法，传递参数
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    MYLog(@"%@",self.tabBar.subviews);
//    NSUInteger count = self.tabBar.subviews.count;
//    for (int i = 0; i<count; i++) {
//        UIView *child = self.tabBar.subviews[i];
//        Class calss = NSClassFromString(@"UITabBarButton");
//        
//    }
//    
//}

- (void)addChildVc:(UIViewController *)childVc Title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectImage
{
    
    //设置子控制器的文字
//    childVc.tabBarItem.title = title;
//    //导航控制器的标题
//    childVc.navigationItem.title = title;
    childVc.title = title;//这一句相当于上面两句话
    
    //设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childVc.view.backgroundColor = GXLRandomColor;
    
    
    //设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    //先给外面传进来的小控制器包装一个导航控制器
    GXLNavigationController *nav = [[GXLNavigationController alloc]initWithRootViewController:childVc];
    //添加子控制器
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MYTabBarDelegate的代理方法
- (void)tabBarDidClickPlusButton:(MyTabBar *)tabBar
{
    MyComposeViewController *compose = [[MyComposeViewController alloc]init];
    GXLNavigationController *nav = [[GXLNavigationController alloc]initWithRootViewController:compose];
//    UIViewController *vc = [[UIViewController alloc]init];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}


//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    MYLog(@"%ld",(long)item.tag);
//    if (item.tag == 0) {
//        GXLNavigationController *nav = self.viewControllers.firstObject;
//        if (nav.viewControllers.count>1) {
//            [nav popToRootViewControllerAnimated:YES];
//        }
//        
//    }
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
