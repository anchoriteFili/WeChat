//
//  LoginViewController.m
//  WeChat
//
//  Created by 赵宏亚 on 16/3/21.
//  Copyright © 2016年 赵宏亚. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()


@property (weak, nonatomic) IBOutlet UILabel *userLable; //账户号

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField; //密码登陆


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //从沙盒获取用户名
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    
    self.userLable.text = user;
    
}

#pragma mark 登陆
- (IBAction)loginBtnClick:(UIButton *)sender {
    
//    [self.view endEditing:YES]; //收回键盘，结束编辑状态
    
    /**
     1. 把用户名和密码放在沙盒
     2. 调用AppDelegate的一个connect连接服务器并登陆
     */
    
#pragma mark 把用户名和密码放在沙盒
    NSString *user = self.userLable.text;
    NSString *pwd = self.pwdTextField.text;
    
    user = @"20247";
    pwd = @"25d55ad283aa400af464c76d713c07ad";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:user forKey:@"user"];
    [defaults setObject:pwd forKey:@"pwd"];
    [defaults synchronize];
    
#pragma mark 抽取父类的方法 进入登陆流程
    [super login];
    
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
