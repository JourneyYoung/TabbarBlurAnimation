//
//  LMTabBarItem.h
//  CustomTabBar
//
//  Created by LiMin on 2019/12/18.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LMTabBarItemDelegate;

@interface LMTabBarItem : UIView//继承自UIView

//@property (nonatomic, strong) NSString *animationJsonName;

@property (nonatomic, weak) id <LMTabBarItemDelegate> delegate;

//重写初始化方法
- (instancetype)initWithPngName:(NSString *)name;

- (void)setSelected;

- (void)setUnSelected;

@end

@protocol LMTabBarItemDelegate <NSObject>

@optional

- (void)tabBarItem:(LMTabBarItem *)item didSelectIndex:(NSInteger)index;//代理处理点击事件

@end

NS_ASSUME_NONNULL_END
