//
//  UIViewController+VCCategory.m
//  WeChat
//
//  Created by 赵宏亚 on 16/3/23.
//  Copyright © 2016年 赵宏亚. All rights reserved.
//

#import "UIViewController+VCCategory.h"

@implementation UIViewController (VCCategory)

//添加defaults的方法
- (void)userDefaultsSetObject:(NSString *)object forKey:(NSString *)key {
    
    NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
    [defaluts setObject:object forKey:key];
    [defaluts synchronize];
}

@end
