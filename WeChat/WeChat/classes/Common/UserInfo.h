//
//  UserInfo.h
//  WeChat
//
//  Created by 赵宏亚 on 16/3/21.
//  Copyright © 2016年 赵宏亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface UserInfo : NSObject

SingletionH(userInfo)

@property (nonatomic,strong) NSString *userName; //用户名
@property (nonatomic,strong) NSString *pwd; //用户密码




@end
