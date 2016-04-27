//
//  ViewController.m
//  StatueView
//
//  Created by 互动 on 16/4/27.
//  Copyright (c) 2016年 互动. All rights reserved.
//

#import "ViewController.h"
#import "StatueView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [StatueView showNormalStatueView:@"加载..." statue:Statue_sucecess];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
