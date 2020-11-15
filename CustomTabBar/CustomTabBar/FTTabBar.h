//
//  LMTabBar.h
//  CustomTabBar
//
//  Created by Journey on 2020/11/15.
//  Copyright © 2020 Journey. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat LMTabBarHeight = 48.0;
NS_ASSUME_NONNULL_BEGIN

@class FTTabBarItem;
@protocol LMTabBarDelegate;

@interface FTTabBar : UITabBar//继承自UITabBar

@property (nonatomic, copy) NSArray<FTTabBarItem *> *lmItems;//item数组
@property (nonatomic, weak) id <LMTabBarDelegate> lmDelegate;

@end

@protocol LMTabBarDelegate <NSObject>

- (void)tabBar:(FTTabBar *)tab didSelectItem:(FTTabBarItem *)item atIndex:(NSInteger)index ;

@end
NS_ASSUME_NONNULL_END
