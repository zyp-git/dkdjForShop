//
//  baseNavigationController.m
//  shopForiOS
//
//  Created by 张允鹏 on 16/7/17.
//  Copyright © 2016年 张允鹏. All rights reserved.
//

#import "baseNavigationController.h"

@interface baseNavigationController ()

@end

@implementation baseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:216.0/255.0 blue:226.0/255.0 alpha:1];
    // Do any additional setup after loading the view.
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
