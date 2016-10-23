//
//  MyComposeViewController.m
//  GXLWB
//
//  Created by 关晓龙 on 16/10/14.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyComposeViewController.h"
#import "MyAccountTool.h"
//#import "MyTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "MyComposeToolbar.h"
#import "MyComposePhototsView.h"
#import "MyEmotionKeyboard.h"
#import "MyEmotion.h"
#import "MyEmotionTextView.h"

@interface MyComposeViewController()<UITextViewDelegate,MyComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic ,weak) MyEmotionTextView *textView;
@property (nonatomic ,weak) MyComposeToolbar *toolbar;
//存放拍照或者相册中选择的图片
@property (nonatomic ,weak) MyComposePhototsView *photosView;

//表情键盘 一定要用strong 保证生命
@property (nonatomic ,strong) MyEmotionKeyboard *emotionKeyboard;

//是否正在切换键盘
@property(nonatomic ,assign) BOOL switchingKeyboard;

//@property (nonatomic ,assign) BOOL picking;

@end

@implementation MyComposeViewController

#pragma mark - 懒加载
- (MyEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {//保证只创建一次
        self.emotionKeyboard = [[MyEmotionKeyboard alloc]init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
        
    }
    return _emotionKeyboard;
    
}


#pragma mark - 系统方法

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航栏的内容
    [self setupNav];
    
    //添加输入控件
    [self setupTextView];
    
    //添加工具条
    [self setupToolbar];
    
    //添加相册
    [self setupPhotosView];
    
}


- (void)dealloc
{
    [MyNotificationCenter removeObserver:self];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    //成为第一响应者
//    [self.textView becomeFirstResponder];
//    
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //成为第一响应者
    [self.textView becomeFirstResponder];
    
}

#pragma mark - 初始化方法

- (void)setupPhotosView
{
    MyComposePhototsView *photosView = [[MyComposePhototsView alloc]init];
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    photosView.y = 100;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
    
}

- (void)setupToolbar
{
    
    MyComposeToolbar *toolbar = [[MyComposeToolbar alloc]init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    //inputView用来设置键盘
//    self.textView.inputView = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    self.textView.inputAccessoryView = toolbar;
    
}

- (void)setupTextView
{
    
    MyEmotionTextView *textView = [[MyEmotionTextView alloc]init];
    //textView设置可以拖拽 垂直方向永远可以拖拽（有弹簧效果）
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事...";
    textView.delegate = self;
//    textView.placeholderColor = [UIColor grayColor];
    [self.view addSubview:textView];
    self.textView = textView;
    //成为第一响应者（能输入文本的控件一旦成为第一响应者，就会叫出相应的键盘）
    [textView becomeFirstResponder];
    
    //监听文字通知
    [MyNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    //键盘通知
    [MyNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //表情选中的通知
    [MyNotificationCenter addObserver:self selector:@selector(emotionDidSelected:) name:MyEmotionDidSelectedNotification object:nil];
    
    //删除文字的通知
    [MyNotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:MyEmotionDidDeleteNotification object:nil];
    
}



- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    NSString *name = [MyAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        
        UILabel *titleView = [[UILabel alloc]init];
        titleView.width = 200;
        titleView.height = 44;
        titleView.textAlignment = NSTextAlignmentCenter;
        //自动换行
        titleView.numberOfLines = 0;
        
        //创建一个带有属性的字符串（比如颜色属性，自提属性等文字属性）
        NSString *str = [NSString stringWithFormat:@"发微博\n%@",name];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        //添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 3)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        
        //    NSShadow *shadow = [[NSShadow alloc]init];
        //    shadow.shadowColor = [UIColor blueColor];
        //    shadow.shadowOffset = CGSizeMake(5, 5);
        //    [attrStr addAttribute:NSShadowAttributeName value:shadow range:[str rangeOfString:name]];
        
        titleView.attributedText = attrStr;
        //    titleView.text = [NSString stringWithFormat:@"发微博\n%@",[MyAccountTool account].name];
        self.navigationItem.titleView = titleView;
        
    }else{
        self.title = prefix;
    }
    
    
    
    
}

#pragma mark - 监听方法
//删除文字的通知
- (void)emotionDidDelete
{
    
    [self.textView deleteBackward];//往回删除
    
}

//表情被选中
- (void)emotionDidSelected:(NSNotification *)notification
{
    
    MyEmotion *emotion = notification.userInfo[MySelectEmotionKey];
    
    
    [self.textView insertEmotion:emotion];
    
//    if (emotion.code) {
//        [self.textView insertText:emotion.code.emoji];
//    }else if(emotion.png)
//    {
//        
//        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
//        
//        //拼接之前的文字（图片和普通文字）
//        [attributedText appendAttributedString:self.textView.attributedText];
//        
//        NSTextAttachment *attch = [[NSTextAttachment alloc]init];
//        attch.image = [UIImage imageNamed:emotion.png];
//        //字体文字的高度
//        CGFloat attchWH = self.textView.font.lineHeight;
//        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
//        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
//        
//        //拼接图片
////        [attributedText appendAttributedString:imageStr];
//        NSUInteger loc = self.textView.selectedRange.location;
//        //插入光标索引位置
//        [attributedText insertAttributedString:imageStr atIndex:loc];
//        
//        
//        //设置字体
//        [attributedText addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, attributedText.length)];
//        //设置文字
//        self.textView.attributedText = attributedText;
//        
//        //移动光标到表情的后面
//        self.textView.selectedRange = NSMakeRange(loc+1, 0);
//        
//        //insertText  将文字插入到光标处
////        [self.textView insertText:emotion.png];
//    }
    
    
    
}


//键盘的frame发生改变时调用（显示隐藏）
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    
    //如果正在切换键盘，就不执行后面的代码
    if (self.switchingKeyboard) return;
    
//    if (self.picking) return;
    
    //notification.userInfo
//    UIKeyboardFrameEndUserInfoKey
    
    NSDictionary *userInfo = notification.userInfo;
    //动画持续的时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        //工具条的y值 == 键盘的y值-工具条的高度
        if (CGRectGetMaxY(self.toolbar.frame)>self.view.height) {//键盘的Y值已经远远超过了控制器的高度
            self.toolbar.y = self.view.height-self.toolbar.height;
        }else{
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
    }];
    
}

- (void)send
{
    
    if (self.photosView.photos.count) {
        [self sendWithImage];
    }else{
        [self sendWithoutImage];
    }
    
    
    
    
}

- (void)sendWithImage
{
   
    
    
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    /**	pic true binary 微博的配图。*/
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    MyAccount *account = [MyAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.text;
    
    
    // 3.发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //拼接文件数据
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);//5M以内的图片
         
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MYLog(@"请求失败-%@", error);
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    //dismiss
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}

- (void)sendWithoutImage
{
    
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    MyAccount *account = [MyAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.text;//
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MYLog(@"请求失败-%@", error);
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    //dismiss
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//监听文字改变
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
}

#pragma mark - MyComposeToolbarDelegate
- (void)composeToolbar:(MyComposeToolbar *)toolbar didClickButton:(MyComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case MyComposeToolbarButtonTypeCamera://拍照
            [self openCamera];
            break;
        case MyComposeToolbarButtonTypePicture://相册
            [self openAlbum];
            break;
        case MyComposeToolbarButtonTypeMention://@
            
            break;
        case MyComposeToolbarButtonTypeTrend://#
            
            break;
        case MyComposeToolbarButtonTypeEmotion://表情
            [self switchKeyboard];
            break;
        default:
            break;
    }
    
    
}

#pragma mark - 其他方法

//切换键盘
- (void)switchKeyboard
{
    
    if (self.textView.inputView == nil) {//切换为自定义键盘
        
        self.textView.inputView = self.emotionKeyboard;
        
        
        //显示键盘按钮
        self.toolbar.showKeyBoardButton = YES;
    }else{
        self.textView.inputView = nil;
        
        
        //显示表情按钮
        self.toolbar.showKeyBoardButton = NO;
    }
    
    //开始切换键盘
    
    self.switchingKeyboard = YES;
    
    //退出键盘
    [self.textView endEditing:YES];
//    [self.textView resignFirstResponder];
    
    //结束切换键盘
    self.switchingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //弹出键盘
        [self.textView becomeFirstResponder];
        
//        //结束切换键盘
//        self.switchingKeyboard = NO;
        
    });
    
    
    
}

- (void)openCamera
{
    [self openImagePictureController:UIImagePickerControllerSourceTypeCamera];
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;//相机不可用
//    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
//    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//    [self presentViewController:ipc animated:YES completion:^{
//        
//    }];
    
}

- (void)openAlbum
{
    //如果想自己写一个图片控制器，得利用AssetsLibrary。framework，利用这个框架可以获得手机上的所有图片
    
    
    [self openImagePictureController:UIImagePickerControllerSourceTypePhotoLibrary];
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;//相机不可用
//    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
//    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:ipc animated:YES completion:^{
//        
//    }];
}


- (void)openImagePictureController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;//相机不可用
    
//    self.picking = YES;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = type;
//    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate
/**
 *  UIImagePickerControllerDelegate 选择玩图片后就调用（拍照完毕或者选择图片完毕）
 *
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
//    self.picking = NO;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    //从info中
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //添加图片到photosView中
    [self.photosView addPhoto:image];
//    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.image = image;
//    [self.photosView addSubview:imageView];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25*NSEC_PER_SEC * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.picking = NO;
//    });
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25*NSEC_PER_SEC * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.picking = NO;
//    });
    
}


@end
