//
//  ViewController.m
//  CST_LOGIN
//
//  Created by 春水堂 on 15/10/12.
//  Copyright © 2015年 zouao. All rights reserved.
//

#import "ViewController.h"
#import "SettingManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[SettingManager standerManager] onUpdateVersion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
