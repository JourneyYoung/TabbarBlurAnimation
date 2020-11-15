//
//  UIFont+FTRoundFont.m
//  Fasting
//
//  Created by Journey on 2020/7/17.
//  Copyright © 2020 Journey. All rights reserved.
//

#import "UIFont+FTRoundFont.h"

@implementation UIFont (FTRoundFont)

+ (UIFont *)roundBlodFont:(CGFloat)size{
    UIFont *font = [self systemFontOfSize:size weight:UIFontWeightBold];
    if (@available(iOS 13.0, *)) {
        UIFontDescriptor *des = [[self systemFontOfSize:size weight:UIFontWeightBold].fontDescriptor fontDescriptorWithDesign:UIFontDescriptorSystemDesignRounded];
        font = [UIFont fontWithDescriptor:des size:size];
        return font;
    } else {
        font = [UIFont fontWithName:@"ArialRoundedMTBold" size:size];
        return  font;
    }
}

+ (UIFont *)roundSemiBlodFont:(CGFloat)size{
    UIFont *font = [self systemFontOfSize:size weight:UIFontWeightSemibold];
    if (@available(iOS 13.0, *)) {
        UIFontDescriptor *des = [[self systemFontOfSize:size weight:UIFontWeightSemibold].fontDescriptor fontDescriptorWithDesign:UIFontDescriptorSystemDesignRounded];
        font = [UIFont fontWithDescriptor:des size:size];
        return font;
    } else {
        return  font;
    }
}

+ (UIFont *)roundMediumFont:(CGFloat)size{
    UIFont *font = [self systemFontOfSize:size weight:UIFontWeightMedium];
    if (@available(iOS 13.0, *)) {
        UIFontDescriptor *des = [[self systemFontOfSize:size weight:UIFontWeightMedium].fontDescriptor fontDescriptorWithDesign:UIFontDescriptorSystemDesignRounded];
        font = [UIFont fontWithDescriptor:des size:size];
        return font;
    } else {
        return  font;
    }
}

+ (UIFont *)roundRegularFont:(CGFloat)size{
    UIFont *font = [self systemFontOfSize:size weight:UIFontWeightRegular];
    if (@available(iOS 13.0, *)) {
        UIFontDescriptor *des = [[self systemFontOfSize:size weight:UIFontWeightRegular].fontDescriptor fontDescriptorWithDesign:UIFontDescriptorSystemDesignRounded];
        font = [UIFont fontWithDescriptor:des size:size];
        return font;
    } else {
        return  font;
    }
}

@end
