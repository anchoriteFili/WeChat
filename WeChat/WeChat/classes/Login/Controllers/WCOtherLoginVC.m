//
//  WCOtherLoginVC.m
//  WeChat
//
//  Created by 赵宏亚 on 16/3/18.
//  Copyright © 2016年 赵宏亚. All rights reserved.
//

#import "WCOtherLoginVC.h"
#import "AppDelegate.h"

@interface WCOtherLoginVC ()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;



@property (weak, nonatomic) IBOutlet UITextField *userInfo; //账号


@property (weak, nonatomic) IBOutlet UITextField *userPwd; //密码



@end

@implementation WCOtherLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //判断适配的类型 改变左右约束的距离
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        self.leftConstraint.constant = 10;
        self.rightConstraint.constant = 10;
    }
    
}

#pragma mark 登陆按钮点击事件
- (IBAction)loginBtnClick:(UIButton *)sender {
    
    [self.view endEditing:YES]; //收回键盘，结束编辑状态
    
    /**
     1. 把用户名和密码放在沙盒
     2. 调用AppDelegate的一个connect连接服务器并登陆
     */
    
#pragma mark 把用户名和密码放在沙盒
    NSString *user = self.userInfo.text;
    NSString *pwd = self.userPwd.text;
    
    user = @"20247";
    pwd = @"25d55ad283aa400af464c76d713c07ad";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:user forKey:@"user"];
    [defaults setObject:pwd forKey:@"pwd"];
    [defaults synchronize];
    
    //登陆过程中添加登录中提示
    [MBProgressHUD showMessage:@"正在登陆中..." toView:self.view];
    
#pragma mark 对appdelegate中授权返回的值进行判断，启动不同的方法
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    __weak typeof(self) selfVC = self;
    [app xmppLogin:^(XMPPResultType type) {
        [selfVC handleResultType:type];
    }];
}

#pragma mark 调用appdelegate中的登陆方法 回到主线程
- (void)handleResultType:(XMPPResultType)type {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view]; //登陆成功或隐藏掉登陆中提示
        switch (type) {
            case XMPPResultTypeLoginSuccess:
                NSLog(@"登陆成功");
                [self enterMainPage]; //进入主页面
                break;
            case XMPPResultTypeNetErr:
                NSLog(@"网络不给力");
                [MBProgressHUD showError:@"网络不给力" toView:self.view];
                break;
                
            case XMPPResultTypeLogiFailure:
                NSLog(@"登陆失败");
                [MBProgressHUD showError:@"用户账号或者密码错误" toView:self.view];
                break;
            default:
                break;
        }
    });
}

#pragma mark 返回成功信息后进入主页面，进入主页面前，将模态试图先隐藏掉，防止内存泄露
- (void)enterMainPage {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    //    授权成功后进入主界面 更改创空的根控制器
    //    注意：由于代理是在子线程中运行的，所以界面反应的会很慢，那么就将调换主界面换控制器放到主线程中刷新UI
    UIStoryboard *stortboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = stortboard.instantiateInitialViewController;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
