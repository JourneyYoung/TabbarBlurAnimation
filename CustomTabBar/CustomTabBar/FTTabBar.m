//
//  FTTabBar.m
//  FTCustomTabBar
//
//  Created by Journey on 2020/11/15.
//  Copyright © 2020 Journey. All rights reserved.
//

#import "FTTabBar.h"
#import "FTTabBarItem.h"

//主要是将系统的item移除掉, 然后添加上自定义的item:
@interface FTTabBar ()<FTTabBarItemDelegate>

@end

@implementation FTTabBar

//重写初始化方法
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        if (@available(iOS 13.0, *)) {
            UITabBarAppearance *appearance = [self.standardAppearance copy];
            appearance.backgroundImage = [self imageWithColor:UIColor.clearColor size:CGSizeMake(1, 1)];
            appearance.shadowImage = [self imageWithColor:UIColor.clearColor size:CGSizeMake(1, 1)];
            //下面这行代码最关键
            [appearance configureWithTransparentBackground];
            self.standardAppearance = appearance;
        } else {
            [self setBackgroundImage:[self imageWithColor:UIColor.clearColor size:CGSizeMake(1, 1)]];
            [self setShadowImage:[self imageWithColor:UIColor.clearColor size:CGSizeMake(1, 1)]];
        }
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 93+20);
        
//        [self insertSubview:effectView atIndex:0];//添加到 tabbar 底层
        
    }
    return self;
}

- (void)setLmItems:(NSArray<FTTabBarItem *> *)lmItems {
    _lmItems = lmItems;
}

//重写layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    // 移除系统的tabBarItem
     //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，移除

    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *item in self.subviews) {
        if ([item isKindOfClass:class]) {//这里的安全判断是很有必要的
            [item removeFromSuperview];
        }
    }
    // 设置自定义的tabBarItem
    [self setupItems];
}


/// 设置自定义的LMTabBarItem
- (void)setupItems {
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor clearColor];
    [self addSubview:backView];
    CGFloat width = self.frame.size.width/self.lmItems.count;
    for (int i = 0; i < self.lmItems.count; i++) {
        FTTabBarItem *item = [self.lmItems objectAtIndex:i];
        //+1是因为float/count的精度问题
        item.frame = CGRectMake(i*width, 0, width+1, LMTabBarHeight);

        [self addSubview:item];
        item.delegate = self;
    }
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark ----LMTabBarItemDelegate
//实现代理方法
- (void)tabBarItem:(FTTabBarItem *)item didSelectIndex:(NSInteger)index {
    if (self.lmDelegate && [self.lmDelegate respondsToSelector:@selector(tabBar:didSelectItem:atIndex:)]) {
        [self.lmDelegate tabBar:self didSelectItem:item atIndex:index];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
