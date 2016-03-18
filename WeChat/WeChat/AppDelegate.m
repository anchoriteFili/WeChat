//
//  AppDelegate.m
//  WeChat
//
//  Created by 赵宏亚 on 16/3/18.
//  Copyright © 2016年 赵宏亚. All rights reserved.
//

#import "AppDelegate.h"
#import "XMPPFramework.h"

@interface AppDelegate ()<XMPPStreamDelegate> {
    XMPPStream *_xmppStream;
    XMPPResultBlock _resultBlock;
}

// 1. 初始化XMPPStream
-(void)setupXMPPStream;


// 2.连接到服务器
-(void)connectToHost;

// 3.连接到服务成功后，再发送密码授权
-(void)sendPwdToHost;


// 4.授权成功后，发送"在线" 消息
-(void)sendOnlineToHost;


@end

@implementation AppDelegate

#pragma mark ==============XMPP开始====================

#pragma mark 程序启动连接到主机
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 程序一启动就连接到主机
//    [self connectToHost];
    
    return YES;
}

#pragma mark 连接到服务器
-(void)connectToHost{
    NSLog(@"开始连接到服务器");
    if (!_xmppStream) {
        [self setupXMPPStream];
    }
    
    // 设置登录用户JID
    //resource 标识用户登录的客户端 iphone android
    
    
    //沙盒中获取用户名
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    
//    user = 20247
    XMPPJID *myJID = [XMPPJID jidWithUser:user domain:@"op.iyotv.com" resource:@"Smack" ];
    _xmppStream.myJID = myJID;
    
    // 设置服务器域名
    _xmppStream.hostName = @"op.iyotv.com";//不仅可以是域名，还可是IP地址
    
    // 设置端口 如果服务器端口是5222，可以省略
    _xmppStream.hostPort = 5222;
    
    // 连接
    NSError *err = nil;
    if(![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&err]){
        NSLog(@"链接失败。。。");
        NSLog(@"%@",err);
    }
}

#pragma mark  -私有方法
#pragma mark 初始化XMPPStream
-(void)setupXMPPStream{
    
    _xmppStream = [[XMPPStream alloc] init];
    
    // 设置代理
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

#pragma mark -XMPPStream的代理
#pragma mark 与主机连接成功
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"与主机连接成功");
    
    // 主机连接成功后，发送密码进行授权
    [self sendPwdToHost];
}

#pragma mark  与主机断开连接
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    // 如果有错误，代表连接失败
    NSLog(@"与主机断开连接 %@",error);
    
}

#pragma mark 连接到服务成功后，再发送密码授权
-(void)sendPwdToHost{
    NSLog(@"再发送密码授权");
    NSError *err = nil;
    
    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
    
//    pwd
    [_xmppStream authenticateWithPassword:pwd error:&err];
    if (err) {
        NSLog(@"%@",err);
    }
}

#pragma mark 授权成功
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"授权成功");
    [self sendOnlineToHost];
    
//    授权成功后进入主界面 更改创空的根控制器
//    注意：由于代理是在子线程中运行的，所以界面反应的会很慢，那么就将调换主界面换控制器放到主线程中刷新UI
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIStoryboard *stortboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        self.window.rootViewController = stortboard.instantiateInitialViewController;
    });
}

#pragma mark  授权成功后，发送"在线" 消息
-(void)sendOnlineToHost{
    
    NSLog(@"发送 在线 消息");
    XMPPPresence *presence = [XMPPPresence presence];
    NSLog(@"%@",presence);
    
    [_xmppStream sendElement:presence];
}

#pragma mark 授权失败
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"授权失败 %@",error);
    
    //判断block又没有值，再回调登陆控制器
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLogiFailure);
    }
    
}

#pragma mark -公共方法
-(void)logout{
    // 1." 发送 "离线" 消息"
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
    
    // 2. 与服务器断开连接
    [_xmppStream disconnect];
    
    NSLog(@"离线成功");
}

#pragma mark用户登陆
- (void)xmppLogin:(XMPPResultBlock)resultBlock {
    
    //1. 先把block存起来
    _resultBlock = resultBlock;
    
    
    //连接服务器
    [self connectToHost];
}

#pragma mark ==============XMPP结束====================

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
