//
//  LMTabBarItem.m
//  CustomTabBar
//
//  Created by LiMin on 2019/12/18.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "LMTabBarItem.h"
#import <YYImage/YYImage.h>

static NSInteger defaultTag = 100000;

@interface LMTabBarItem ()

@property (nonatomic, strong) UIVisualEffectView *backView;

@property (nonatomic, strong) YYAnimatedImageView *animationView;//动画view

@property (nonatomic, strong) UIImageView *normalImageView; //未选中状态view

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LMTabBarItem

//重写初始化方法
- (instancetype)initWithPngName:(NSString *)name{
    if (self = [super init]) {
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.backView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [self addSubview:self.backView];
        
        
        YYImage *image = [YYImage imageNamed:name];
        self.animationView = [[YYAnimatedImageView alloc] initWithImage:image];
        [self.animationView startAnimating];
        self.animationView.currentAnimatedImageIndex = 0;
        self.animationView.userInteractionEnabled = NO;
        self.animationView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.animationView];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapItem:)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}

/// item点击手势，响应点击事件
- (void)tapItem:(UITapGestureRecognizer *)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarItem:didSelectIndex:)]) {
        [self.delegate tabBarItem:self didSelectIndex:self.tag - defaultTag];
    }
}


#pragma mark ----set

// 重写setTag方法
- (void)setTag:(NSInteger)tag {
    [super setTag:tag + defaultTag];
}

- (void)setSelected{
    self.isSelected = YES;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat kRadian = 6;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint: CGPointMake(width*0.5-16, kRadian)];
    
    [bezierPath addQuadCurveToPoint:CGPointMake(width*0.5+16, kRadian) controlPoint:CGPointMake(width*0.5, -kRadian)];
    [bezierPath addLineToPoint:CGPointMake(width, kRadian)];
    if(self.tag == 100003){
        CGFloat startAngle = M_PI*1.5; //
        CGFloat endAngle = 0 ;
        [bezierPath addArcWithCenter:CGPointMake(width-20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    [bezierPath addLineToPoint: CGPointMake(width, height+60)];
    [bezierPath addLineToPoint: CGPointMake(0, height+60)];
    [bezierPath addLineToPoint: CGPointMake(0, kRadian)];
    if(self.tag == 100000){
        CGFloat startAngle = M_PI; //
        CGFloat endAngle = M_PI*1.5 ;
        [bezierPath addArcWithCenter:CGPointMake(20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = bezierPath.CGPath;
    [self.backView.layer setMask:layer];
}

- (void)setUnSelected{
    self.isSelected = NO;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    CGFloat kRadian = 6;
    
    [bezierPath moveToPoint: CGPointMake(width, kRadian)];
    if(self.tag == 100003){
        CGFloat startAngle = M_PI*1.5; //
        CGFloat endAngle = 0 ;
        [bezierPath addArcWithCenter:CGPointMake(width-20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    
    [bezierPath addLineToPoint:CGPointMake(width, height+60)];
    
    [bezierPath addLineToPoint: CGPointMake(0, height+60)];
    [bezierPath addLineToPoint: CGPointMake(0, kRadian)];
    if(self.tag == 100000){
        CGFloat startAngle = M_PI; //
        CGFloat endAngle = M_PI*1.5 ;
        [bezierPath addArcWithCenter:CGPointMake(20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.toValue = (id)bezierPath.CGPath;
    pathAnimation.duration = 1.0;
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
//    [layer addAnimation:pathAnimation forKey:@"revealAnimation"];
//    [self.backView.layer addAnimation:pathAnimation forKey:@"path"];
    [self.backView.layer setMask:layer];
}

#pragma mark ----layoutSubviews

//重写layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.frame;
    rect.origin.x = 0;
    rect.origin.y = -20;
    rect.size.height += 20;
    
    self.backView.frame = CGRectMake(0, -10, rect.size.width, rect.size.height+30);
    self.animationView.frame = CGRectMake(0, 0, 32, 32);
    self.animationView.center = CGPointMake(rect.size.width*0.5, 16);
    if(self.isSelected){
        [self setSelected];
    }else{
        [self setUnSelected];
    }
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:11];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
