//
//  UIFont+FTRoundFont.h
//  Fasting
//
//  Created by Journey on 2020/7/17.
//  Copyright © 2020 Journey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (FTRoundFont)

+ (UIFont *)roundBlodFont:(CGFloat)size;

+ (UIFont *)roundSemiBlodFont:(CGFloat)size;

+ (UIFont *)roundMediumFont:(CGFloat)size;

+ (UIFont *)roundRegularFont:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
