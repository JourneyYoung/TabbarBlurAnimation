//
//  LMTabBarItem.h
//  CustomTabBar
//
//  Created by Journey on 2020/11/15.
//  Copyright © 2020 Journey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FTTabBarItemDelegate;

@interface FTTabBarItem : UIView//继承自UIView

//@property (nonatomic, strong) NSString *animationJsonName;

@property (nonatomic, weak) id <FTTabBarItemDelegate> delegate;

//重写初始化方法
- (instancetype)initWithPngName:(NSString *)name normalImage:(NSString *)normal title:(NSString *)title;

- (void)setSelected:(BOOL)animated;

- (void)setUnSelected:(BOOL)animated;

@end

@protocol FTTabBarItemDelegate <NSObject>

@optional

- (void)tabBarItem:(FTTabBarItem *)item didSelectIndex:(NSInteger)index;//代理处理点击事件

@end

NS_ASSUME_NONNULL_END
