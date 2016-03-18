//
//  AppDelegate.h
//  WeChat
//
//  Created by 赵宏亚 on 16/3/18.
//  Copyright © 2016年 赵宏亚. All rights reserved.
//

#import <UIKit/UIKit.h>

//登陆成功失败的判断
typedef enum {
    
    XMPPResultTypeLoginSuccess, //登陆成功
    XMPPResultTypeLogiFailure, //登陆失败
    XMPPResultTypeNetErr //网络不给力
}XMPPResultType;

typedef void(^XMPPResultBlock)(XMPPResultType type); //xmpp请求结果的block

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 注销
-(void)logout;

//用户登陆
- (void)xmppLogin:(XMPPResultBlock)resultBlock;



@end

