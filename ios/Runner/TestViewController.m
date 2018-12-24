//
//  TestViewController.m
//  Runner
//
//  Created by 米来 on 2018/12/20.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)testBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
