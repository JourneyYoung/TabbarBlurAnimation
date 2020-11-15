//
//  DViewController.m
//  CustomTabBar
//
//  Created by Journey on 2020/11/17.
//  Copyright © 2020 Journey. All rights reserved.
//

#import "DViewController.h"
#import "FTBaseTabBarViewController.h"

@interface DViewController ()

@end

@implementation DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    FTBaseTabBarViewController *tabbar = (FTBaseTabBarViewController *)self.navigationController.tabBarController;
//    [tabbar showRedDot:YES];
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

@end
