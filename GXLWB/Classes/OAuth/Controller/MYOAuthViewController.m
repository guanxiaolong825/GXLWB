//
//  MYOAuthViewController.m
//  GXLWB
//
//  Created by administrator on 16/8/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MYOAuthViewController.h"
#import "AFNetworking.h"
//#import "TabbarViewController.h"
//#import "MYNewfeatureViewController.h"
#import "MBProgressHUD+MJ.h"
#import "MyAccountTool.h"

@interface MYOAuthViewController ()<UIWebViewDelegate>

@end

@implementation MYOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建微博view
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //用webView加载登录页面
    //请求地址 : https://api.weibo.com/oauth2/authorize
    //请求参数 :
    /*
     client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。 没有的话(默认)就是http://
     */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3163877545&redirect_uri=http://www.baidu.com"];
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
    MYLog(@"finish");
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
    MYLog(@"start");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    MYLog(@"url: %@",request.URL);
    //获取url
    NSString *url = request.URL.absoluteString;
    
    //判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {//是回调地址
        //截取code=后面的参数值
        NSUInteger fromIndex = range.location+range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        MYLog(@"%@ %@",code,url);
        
        //利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        //禁止加载回调地址
        return NO;
    }
    
    return YES;
}

/**
 *  利用code（授权成功后的reques token）换取一个accesstoken
 *
 *  @param code 授权成功后的request token
 */
- (void)accessTokenWithCode:(NSString *)code
{
    /*
     URL
     https://api.weibo.com/oauth2/access_token
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     */
    
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3163877545";
    params[@"client_secret"] = @"6c9f86d76603e1aed396c94fb4d4a6e5";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
    //发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        [MBProgressHUD hideHUD];
        
        //将返回的账号字典转换成模型
        MyAccount *account = [MyAccount accountWithDict:responseObject];
        //存储账号信息
        [MyAccountTool saveAccount:account];        
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
        
        //window的分类、MyWindowTool
        //UIViewcontroller的分类、MyControllerTool
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        MYLog(@"请求失败%@",error);
    }];
    
}






@end
