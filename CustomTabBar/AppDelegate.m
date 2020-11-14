//
//  AppDelegate.m
//  CustomTabBar
//
//  Created by LiMin on 2019/12/17.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    BaseTabBarViewController *tabvc = [[BaseTabBarViewController alloc]init];
    self.window.rootViewController = tabvc;
    [self.window makeKeyAndVisible];
    return YES;
}




@end
