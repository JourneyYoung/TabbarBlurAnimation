//
//  AViewController.m
//  CustomTabBar
//
//  Created by LiMin on 2019/12/17.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "AViewController.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"A";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrol = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrol.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height*3);
    scrol.backgroundColor = UIColor.blueColor;
    [self.view addSubview:scrol];
    
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
