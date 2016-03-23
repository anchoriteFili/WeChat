//
//  ViewController.m
//  不规则button测试
//
//  Created by 赵宏亚 on 16/3/23.
//  Copyright © 2016年 赵宏亚. All rights reserved.
//

#import "ViewController.h"
#import "OBShapedButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    OBShapedButton *button = [[OBShapedButton alloc] initWithFrame:CGRectMake(100, 88, 88, 88)];
    [button setBackgroundImage:[UIImage imageNamed:@"众筹_H"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"众筹_N"] forState:UIControlStateHighlighted];
    [self.view addSubview:button];
    
    UIButton *buttonOne = [[OBShapedButton alloc] initWithFrame:CGRectMake(100, 200, 88, 88)];
    [buttonOne setBackgroundImage:[UIImage imageNamed:@"众筹_H"] forState:UIControlStateNormal];
//    [buttonOne setBackgroundImage:[UIImage imageNamed:@"众筹_N"] forState:UIControlStateHighlighted];
    [self.view addSubview:buttonOne];
    
    
    UIButton *buttonTwo = [[OBShapedButton alloc] initWithFrame:CGRectMake(100+66, 200+44, 104, 44)];
    [buttonTwo setBackgroundImage:[UIImage imageNamed:@"Contacts_N"] forState:UIControlStateNormal];
//    [buttonTwo setBackgroundImage:[UIImage imageNamed:@"Contacts_H"] forState:UIControlStateHighlighted];
    [self.view addSubview:buttonTwo];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
