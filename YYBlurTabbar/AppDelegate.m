//
//  AppDelegate.m
//  YYBlurTabbar
//
//  Created by Journey on 2020/11/15.
//

#import "AppDelegate.h"
#import "FTBaseTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    FTBaseTabBarViewController *tabvc = [[FTBaseTabBarViewController alloc]init];
    [tabvc showRedDot:YES];
    self.window.rootViewController = tabvc;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
