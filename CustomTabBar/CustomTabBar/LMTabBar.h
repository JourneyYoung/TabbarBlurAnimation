//
//  LMTabBar.h
//  CustomTabBar
//
//  Created by LiMin on 2019/12/18.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat LMTabBarHeight = 48.0;
NS_ASSUME_NONNULL_BEGIN

@class LMTabBarItem;
@protocol LMTabBarDelegate;

@interface LMTabBar : UITabBar//继承自UITabBar

@property (nonatomic, copy) NSArray<LMTabBarItem *> *lmItems;//item数组
@property (nonatomic, weak) id <LMTabBarDelegate> lmDelegate;

@end

@protocol LMTabBarDelegate <NSObject>

- (void)tabBar:(LMTabBar *)tab didSelectItem:(LMTabBarItem *)item atIndex:(NSInteger)index ;

@end
NS_ASSUME_NONNULL_END
