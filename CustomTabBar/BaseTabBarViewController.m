//
//  BaseTabBarViewController.m
//  CustomTabBar
//
//  Created by LiMin on 2019/12/17.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "BaseTabBarViewController.h"

#import "AViewController.h"
#import "BViewController.h"
#import "CViewController.h"
#import "DViewController.h"

#import "LMTabBar.h"
#import "LMTabBarItem.h"

#import <Masonry.h>
#import <lottie-ios/Lottie/LOTAnimationView.h>

#import <YYImage/YYImage.h>


#define Device_Is_iPhoneX_Devices \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

@interface BaseTabBarViewController ()<LMTabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) LMTabBar *customTabBar;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, assign) NSInteger currentSelectedIndex;

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

    [self setupChildVC];
    self.delegate = self;
    self.currentSelectedIndex = 0;
    self.selectedIndex = 0;
    // Do any additional setup after loading the view.
}
 

#pragma mark ----setupChildVC

//设置viewControllers，添加子控制器
- (void)setupChildVC {

    AViewController *avc = [[AViewController alloc]init];
    UINavigationController *aNav = [[UINavigationController alloc]initWithRootViewController:avc];
    BViewController *bvc = [[BViewController alloc]init];
    UINavigationController *bNav = [[UINavigationController alloc]initWithRootViewController:bvc];
    CViewController *cvc = [[CViewController alloc]init];
    UINavigationController *cNav = [[UINavigationController alloc]initWithRootViewController:cvc];
    DViewController *dvc = [[DViewController alloc]init];
    UINavigationController *dNav = [[UINavigationController alloc]initWithRootViewController:dvc];
    
    self.viewControllers = @[aNav,bNav,cNav,dNav];
    [self setupCustomTabBarItems];
}

/// 设置自定义的LMTabBar
- (void)setupCustomTabBarItems {
    self.tabBar.hidden = YES;
    
    //创建items数组
    NSArray *animationJsonNameArray = @[@"fasting_96",@"track_96",@"learn_96",@"coach_96"];
    NSArray *titleArary = @[@"Fasting",@"Track",@"Learn",@"Coach"];
    NSArray *normalArray = @[@"icon_tab_fast",@"icon_tab_track",@"icon_learn",@"icon_coach"];
    NSMutableArray <LMTabBarItem *>*items = [NSMutableArray array];
    for (int i = 0; i < self.viewControllers.count; i++) {
        LMTabBarItem *item = [[LMTabBarItem alloc]initWithPngName:animationJsonNameArray[i] normalImage:normalArray[i] title:titleArary[i]];
        
        [items addObject:item];
        item.tag = i;
    }
    self.customTabBar.lmItems = [items copy];

    [self.view addSubview:self.customTabBar];
    [self.customTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(Device_Is_iPhoneX_Devices ? LMTabBarHeight+34:LMTabBarHeight);
        make.bottom.mas_equalTo(0);
    }];
}


#pragma mark - LMTabBarDelegate

- (void)tabBar:(LMTabBar *)tab didSelectItem:(LMTabBarItem *)item atIndex:(NSInteger)index {
    if (index != self.currentSelectedIndex) {//切换tabBarItem，并且点击的是非选中的item，则执行下面动画
        self.lastSelectedIndex = self.currentSelectedIndex;
        self.currentSelectedIndex = index;
    }
    self.selectedIndex = index;
}

- (void)setLastSelectedIndex:(NSInteger)lastSelectedIndex {
    _lastSelectedIndex = lastSelectedIndex;
    LMTabBarItem *item = self.customTabBar.lmItems[lastSelectedIndex];
    [item setUnSelected:YES];
    for (UIView *view in item.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"YYAnimatedImageView")]) {//取YYAnimatedImageView
            YYAnimatedImageView *animationView = (YYAnimatedImageView *)view;
            [animationView stopAnimating];//停止动画并回到原点
            break;
        }
    }
}

- (void)setCurrentSelectedIndex:(NSInteger)currentSelectedIndex {
    _currentSelectedIndex = currentSelectedIndex;
    LMTabBarItem *item = self.customTabBar.lmItems[currentSelectedIndex];
    [item setSelected:YES];
    for (UIView *view in item.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"YYAnimatedImageView")]) {//取YYAnimatedImageView
            YYAnimatedImageView *animationView = (YYAnimatedImageView *)view;
            animationView.currentAnimatedImageIndex = 0;
            [animationView startAnimating];
            break;
        }
    }
}

#pragma mark ----lazy

- (LMTabBar *)customTabBar {
    if (!_customTabBar) {
        _customTabBar = [[LMTabBar alloc]init];
        _customTabBar.backgroundColor = [UIColor clearColor];
        _customTabBar.lmDelegate = self;
    }
    return _customTabBar;
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
