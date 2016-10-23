//
//  HomeViewController.m
//  GXLWB
//
//  Created by administrator on 16/2/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "HomeViewController.h"
#import "MyDropDownMenu.h"
#import "MyHomeTableViewController.h"
#import "AFNetworking.h"
#import "MyAccountTool.h"
#import "MyTitleButton.h"
#import "UIImageView+WebCache.h"
#import "MyUser.h"
#import "MyStatus.h"
#import "MJExtension.h"
#import "MyLoadMoreFooter.h"
#import "MyStatusCell.h"
#import "MyStatusFrame.h"

@interface HomeViewController ()<MYDropdownMenuDelegate>
/**
 *  微博数组（里面放的都是MyStatusFrame模型，一个mystatusframe代表一条微博）
 */
@property(nonatomic ,strong)NSMutableArray *statusesFrames;

@end

@implementation HomeViewController

- (NSMutableArray *)statusesFrames
{
    if (!_statusesFrames) {
        self.statusesFrames = [[NSMutableArray alloc]init];
    }
    return _statusesFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = GXLColor(211, 211, 211);
    
//    self.tableView.contentInset = UIEdgeInsetsMake(MYStatusCellMargin, 0, 0, 0);
    
    //设置导航栏的内容
    [self setupNav];
    
    //获得用户信息(昵称)
    [self setupUserInfo];
    
    //集成下拉刷新控件
    [self setDownRefresh];
    
    //集成上啦刷新控件
    [self setUpRefresh];
    
    // 获得未读数
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
//    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

/**
 *  获得未读数
 */
- (void)setupUnreadCount
{
    //    HWLog(@"setupUnreadCount");
    //    return;
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    MyAccount *account = [MyAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
//        //微博的未读数
//        int status = [responseObject[@"status"] intValue];
//        
//        //设置提醒数字
//        self.tabBarItem.badgeValue =  [NSString stringWithFormat:@"%d",status];
        
        
        //@20 -->@"20"
        //NSNumber -->NSString
        //设置提醒数字
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {//如果是0 清空数字
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else
        {
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
        
        
        
        
        // 微博的未读数
        //        int status = [responseObject[@"status"] intValue];
        // 设置提醒数字
        //        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", status];
        
        // @20 --> @"20"
        // NSNumber --> NSString
        // 设置提醒数字(微博的未读数)
//        NSString *status = [responseObject[@"status"] description];
//        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
//            self.tabBarItem.badgeValue = nil;
//            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//        } else { // 非0情况
//            self.tabBarItem.badgeValue = status;
//            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
//        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MYLog(@"请求失败-%@", error);
    }];
}

/**
 *  集成上拉刷新控件
 */
- (void)setUpRefresh
{
    MyLoadMoreFooter *footer = [MyLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

/**
 *  集成下拉刷新控件
 */
- (void)setDownRefresh
{
    //添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    //只有用户手动下拉刷新才会触发事件
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //马上进入刷新状态(仅仅是显示刷新状态，不会触发refreshStateChange事件)
    [control beginRefreshing];
    
    //马上加载数据
    [self loadNewStatus:control];
}

//将Mystatus模型转为MyStatusFrame模型
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    
    //讲MyStatus数组转为MyStatusFrame数组
    NSMutableArray *frames = [NSMutableArray array];
    for (MyStatus *status in statuses) {
        MyStatusFrame *f = [[MyStatusFrame alloc]init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
    
}

/**
 *  进入刷新状态
 */
- (void)refreshStateChange:(UIRefreshControl *)control
{
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //拼接请求参数
    MyAccount *account = [MyAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博
    MyStatusFrame *firstStatusF = [self.statusesFrames firstObject];
    if (firstStatusF) {
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    //    params[@"count"] = @1;//返回的微博条数
    
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        MYLog(@"%@",responseObject);
        
        //将微博字典  转为微博模型 通过MJ方法 转换模型
        NSArray *newStatuses = [MyStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
//        //讲MyStatus数组转为MyStatusFrame数组
//        NSMutableArray *newFrames = [NSMutableArray array];
//        for (MyStatus *status in newFrames) {
//            MyStatusFrame *f = [[MyStatusFrame alloc]init];
//            f.status = status;
//            [newFrames addObject:f];
//        }
        
        //将最新的微博数据添加到总数组的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusesFrames insertObjects:newFrames atIndexes:set];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [control endRefreshing];
        
        //显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
        
        //        MYLog(@"请求成功%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        MYLog(@"请求失败%@",error);
        
        [control endRefreshing];
    }];
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //拼接请求参数
    MyAccount *account = [MyAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博
    MyStatusFrame *lastStatusF = [self.statusesFrames lastObject];
    if (lastStatusF) {
//        params[@"since_id"] = lastStatusF.status.idstr;
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    //    params[@"count"] = @1;//返回的微博条数
    
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        //将微博字典  转为微博模型 通过MJ方法 转换模型
        NSArray *newStatuses = [MyStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //将MyStatus数组转为MyStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        //将更多微博数据加到总数组最后面
        [self.statusesFrames addObjectsFromArray:newFrames];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        self.tableView.tableFooterView.hidden = YES;
        
        //        MYLog(@"请求成功%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //       MYLog(@"请求失败%@",error);
        
        self.tableView.tableFooterView.hidden = YES;
    }];
}

/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量
 */
- (void)showNewStatusCount:(NSUInteger )count
{
    //刷新成功（清空图标数字）
    self.tabBarItem.badgeValue = nil;
    
    //图标未读消息数清零
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //创建label
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    //设置其他属性
    if (count == 0) {
        label.text =@"没有新的微博数据，请稍后再试";
     }else{
        label.text =[NSString stringWithFormat:@"共有%lu条新的数据",(unsigned long)count];
    }
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    
    //添加 window不行 tableview不行  导航栏的view
    label.y = 64-label.height;
//    [self.navigationController.view addSubview:label];
    //将label添加到导航控制器的view中，并且改在导航栏下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    
    //如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画*******
    //动画
    //先利用1s时间，让label往下移动一段距离
    CGFloat duration = 1.0; //动画时间
    [UIView animateWithDuration:duration animations:^{
//        label.y += label.height;
        //设置label的位置变化
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        
        //延迟一秒后 再用1s让label回到原来位置
        //下面UIViewAnimationOptionCurveLinear 匀速
        CGFloat delay = 1.0;//延迟1s
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
//            label.y -= label.height;
            //清空位置的变化 CGAffineTransformIdentity
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    
    
    
}

/**
 *  加载最新的微博数据
 */
- (void)loadNewStatus:(UIRefreshControl *)control
{
//    [self.statusesFrames removeAllObjects];
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //拼接请求参数
    MyAccount *account = [MyAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博
    //取出最前面的微博
    MyStatusFrame *firstStatusF = [self.statusesFrames lastObject];
    if (firstStatusF) {
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        //将微博字典  转为微博模型 通过MJ方法 转换模型
//        self.statuses = [MyStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newStatuses = [MyStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        
        //将MyStatus数组转为MyStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        
        
        //将最新的微博数据添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusesFrames insertObjects:newFrames atIndexes:set];
        
        //刷新表格 
        [self.tableView reloadData];
        
        [control endRefreshing];
        
        [self showNewStatusCount:newStatuses.count];
//        MYLog(@"请求成功%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        MYLog(@"请求失败%@",error);
        
        [control endRefreshing];
        
    }];
}

/**
 *  获得用户信息（昵称）
 */
- (void)setupUserInfo
{
    //https://api.weibo.com/2/users/show.json
    //access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
    //uid	false	int64	需要查询的用户ID。
    //screen_name	false	string	需要查询的用户昵称。
    
    
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //拼接请求参数
    MyAccount *account = [MyAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        //标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        //设置名字
        MyUser *user = [MyUser objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //存储昵称到沙盒中
        account.name = user.name;
        [MyAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}

/**
 *  设置导航栏内容
 */
- (void)setupNav
{
    //导航右侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    //设置导航栏中间的标题按钮
    MyTitleButton *titleButton = [[MyTitleButton alloc]init];
    titleButton.width = 100;
    titleButton.height = 30;
    
    //设置图片和文字
    NSString *name = [MyAccountTool account].name;//上一次的name
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    //监听标题的点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
}


/**
 *  标题的点击
 */
- (void)titleClick:(UIButton *)titleButton
{
    
    //创建下拉菜单
    MyDropDownMenu *menu = [MyDropDownMenu menu];
    menu.delegate =self;
    
    //设置内容
    MyHomeTableViewController *myHome = [[MyHomeTableViewController alloc]init];
    myHome.view.height = 150;
    myHome.view.width = 150;
    menu.contentController = myHome;
    
    //显示
    [menu showFrom:titleButton];
    
}



- (void)friendSearch
{
    
}

- (void)pop
{
    
}


#pragma mark - MYDropdownMenuDelegate
/**
 *  下拉菜单被销毁
 */
- (void)dropdownMenuDidDismiss:(MyDropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
    
}

/**
 *  下拉菜单显示
 */
- (void)dropdownMenuDidShow:(MyDropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statusesFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyStatusCell *cell = [MyStatusCell cellWithTableView:tableView];
    
//    static NSString *ID = @"status";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
    
//    //取出这行对应的微博
//    MyStatus *status = self.statuses[indexPath.row];
//    
//    //取出这条微博的作者（用户）
//    MyUser *user = status.user;
//    cell.textLabel.text = user.name;
//    
//    //设置微博的文字
//    cell.detailTextLabel.text = status.text;
//    
//    //设置头像
//    NSString *imageUrl = user.profile_image_url;
//    UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholder];
    
    
    //给cell传递模型数据
    cell.statusFrame = self.statusesFrames[indexPath.row];
    
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusesFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    //当最后一个cell完全显示在眼前，contentOffset的y值
    CGFloat judgeOffsetY= scrollView.contentSize.height+scrollView.contentInset.bottom-scrollView.height-self.tableView.tableFooterView.height;
    if (offsetY>= judgeOffsetY) {//最后一个cell完全进入视野内
        //显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        //加载更多的微博数据
        [self loadMoreStatus];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyStatusFrame *frame = self.statusesFrames[indexPath.row];
    return frame.cellHeight;
}


@end
