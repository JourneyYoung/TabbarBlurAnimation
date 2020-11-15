//
//  CViewController.m
//  CustomTabBar
//
//  Created by Journey on 2020/11/17.
//  Copyright © 2020 Journey. All rights reserved.
//

#import "CViewController.h"
#import "FTBaseTabBarViewController.h"

@interface CViewController ()

@property (nonatomic, strong) UIButton *clickButton;

@end



@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.clickButton = [[UIButton alloc]init];
    [self.view addSubview:self.clickButton];
    self.clickButton.frame = CGRectMake(200, 200, 200, 200);
    self.clickButton.backgroundColor = UIColor.redColor;
    [self.clickButton addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)clickAction{
    FTBaseTabBarViewController *tabbar = (FTBaseTabBarViewController *)self.navigationController.tabBarController;
    tabbar.selectedIndex = 0;
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
