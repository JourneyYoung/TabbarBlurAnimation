//
//  LMTabBarItem.m
//  CustomTabBar
//
//  Created by LiMin on 2019/12/18.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "LMTabBarItem.h"
#import <YYImage/YYImage.h>
#import <Masonry.h>

static NSInteger defaultTag = 100000;

@interface LMTabBarItem ()

@property (nonatomic, strong) UIVisualEffectView *backView;

@property (nonatomic, strong) YYAnimatedImageView *animationView;//动画view

@property (nonatomic, strong) UIImageView *normalImageView; //未选中状态view

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) NSInteger radian;

@property (nonatomic, assign) NSInteger minusRadian;

@property (nonatomic, strong) NSTimer *selectedTimer;

@property (nonatomic, strong) NSTimer *unSelectedTimer;

@property (nonatomic, strong) NSString *animateName;

@property (nonatomic, strong) NSString *normalImageName;

@property (nonatomic, strong) NSString *titleName;


@end

@implementation LMTabBarItem

//重写初始化方法
- (instancetype)initWithPngName:(NSString *)name normalImage:(NSString *)normal title:(NSString *)title{
    if (self = [super init]) {
        self.animateName = name;
        self.normalImageName = normal;
        self.titleName = title;
        [self configUI];
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

- (void)configUI{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.backView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self addSubview:self.backView];
    
    YYImage *image = [YYImage imageNamed:self.animateName];
    self.animationView = [[YYAnimatedImageView alloc] initWithImage:image];
    [self.animationView startAnimating];
    self.animationView.currentAnimatedImageIndex = 0;
    self.animationView.userInteractionEnabled = NO;
    self.animationView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.animationView];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapItem:)];
    [self addGestureRecognizer:gesture];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.normalImageView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(42);
        make.centerX.equalTo(self);
    }];
    
    [self.normalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.centerX.equalTo(self);
        make.height.width.equalTo(@24);
    }];
    
    self.titleLabel.text = self.titleName;
    UIImage *normalImage = [UIImage imageNamed:self.normalImageName];

    self.normalImageView.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

// 重写setTag方法
- (void)setTag:(NSInteger)tag {
    [super setTag:tag + defaultTag];
}

- (void)setSelected:(BOOL)animated{
    self.isSelected = YES;
    //未选中图片淡出，
    [UIView animateWithDuration:0.1 animations:^{
        self.normalImageView.alpha = 0.0;
        self.animationView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    //选中图片淡入向上弹动再下来
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position"];
    animation.mass = 0.5;
    animation.stiffness = 150.f;
    animation.damping = 1.f;
    animation.initialVelocity = 10.f;
    animation.duration = 0.25;
    animation.removedOnCompletion = YES;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeRemoved;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width*0.5, 16)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width*0.5, 10)];
    self.animationView.center = CGPointMake(self.frame.size.width*0.5, 16);
    [self.animationView.layer addAnimation:animation forKey:@"spring"];
    
    [self setNeedsDisplay];

    
    if(self.selectedTimer){
        [self.selectedTimer invalidate];
        self.selectedTimer = nil;
    }
    if(self.unSelectedTimer){
        [self.unSelectedTimer invalidate];
        self.unSelectedTimer = nil;
    }
    if(!animated){
        self.minusRadian = 6;
        self.radian = 6;
        [self drawCircle];
    }else{
        self.radian = 6;
        self.minusRadian = 6;
        self.selectedTimer = [NSTimer timerWithTimeInterval:0.025 target:self selector:@selector(moveToSelected) userInfo:nil repeats:YES];

        [[NSRunLoop mainRunLoop] addTimer:self.selectedTimer forMode:NSDefaultRunLoopMode];
    }
}

- (void)setUnSelected:(BOOL)animated{
    self.isSelected = NO;
    //未选中图片淡入
    [UIView animateWithDuration:0.1 animations:^{
        self.normalImageView.alpha = 1.0;
        self.animationView.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
    if(self.selectedTimer){
        [self.selectedTimer invalidate];
        self.selectedTimer = nil;
    }
    if(self.unSelectedTimer){
        [self.unSelectedTimer invalidate];
        self.unSelectedTimer = nil;
    }
    if(!animated){
        self.minusRadian = 6;
        self.radian = 6;
        [self clearCircle];
    }else{
        self.radian = 6;
        self.minusRadian = 6;
        self.unSelectedTimer = [NSTimer timerWithTimeInterval:0.025 target:self selector:@selector(moveToUnSelected) userInfo:nil repeats:YES];

        [[NSRunLoop mainRunLoop] addTimer:self.unSelectedTimer forMode:NSDefaultRunLoopMode];
    }
}

- (void)moveToUnSelected{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.minusRadian -= 0.25;
    
    if(self.minusRadian <= 0){
        [self.unSelectedTimer invalidate];
        self.unSelectedTimer = nil;
        self.radian = 6;
        [self clearCircle];
        return;
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint: CGPointMake(width*0.5-16, self.radian)];
    
    [bezierPath addQuadCurveToPoint:CGPointMake(width*0.5+16, self.radian) controlPoint:CGPointMake(width*0.5, -self.minusRadian)];
    [bezierPath addLineToPoint:CGPointMake(width, self.radian)];
    if(self.tag == 100003){
        CGFloat startAngle = M_PI*1.5; //
        CGFloat endAngle = 0 ;
        [bezierPath addArcWithCenter:CGPointMake(width-20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    [bezierPath addLineToPoint: CGPointMake(width, height+60)];
    [bezierPath addLineToPoint: CGPointMake(0, height+60)];
    [bezierPath addLineToPoint: CGPointMake(0, self.radian)];
    if(self.tag == 100000){
        CGFloat startAngle = M_PI; //
        CGFloat endAngle = M_PI*1.5 ;
        [bezierPath addArcWithCenter:CGPointMake(20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = bezierPath.CGPath;
    [self.backView.layer setMask:layer];
}

- (void)clearCircle{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint: CGPointMake(width, self.radian)];
    if(self.tag == 100003){
        CGFloat startAngle = M_PI*1.5; //
        CGFloat endAngle = 0 ;
        [bezierPath addArcWithCenter:CGPointMake(width-20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    
    [bezierPath addLineToPoint:CGPointMake(width, height+60)];
    
    [bezierPath addLineToPoint: CGPointMake(0, height+60)];
    [bezierPath addLineToPoint: CGPointMake(0, self.radian)];
    if(self.tag == 100000){
        CGFloat startAngle = M_PI; //
        CGFloat endAngle = M_PI*1.5 ;
        [bezierPath addArcWithCenter:CGPointMake(20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    [self.backView.layer setMask:layer];
}

- (void)moveToSelected{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.minusRadian += 0.25;
    if(self.minusRadian >= 6){
        [self.selectedTimer invalidate];
        self.selectedTimer = nil;
        self.radian = 6;
        [self drawCircle];
        return;
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint: CGPointMake(width*0.5-16, self.radian)];
    
    [bezierPath addQuadCurveToPoint:CGPointMake(width*0.5+16, self.radian) controlPoint:CGPointMake(width*0.5, -self.minusRadian)];
    [bezierPath addLineToPoint:CGPointMake(width, self.radian)];
    if(self.tag == 100003){
        CGFloat startAngle = M_PI*1.5; //
        CGFloat endAngle = 0 ;
        [bezierPath addArcWithCenter:CGPointMake(width-20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    [bezierPath addLineToPoint: CGPointMake(width, height+60)];
    [bezierPath addLineToPoint: CGPointMake(0, height+60)];
    [bezierPath addLineToPoint: CGPointMake(0, self.radian)];
    if(self.tag == 100000){
        CGFloat startAngle = M_PI; //
        CGFloat endAngle = M_PI*1.5 ;
        [bezierPath addArcWithCenter:CGPointMake(20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = bezierPath.CGPath;
    [self.backView.layer setMask:layer];
}

- (void)drawCircle{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint: CGPointMake(width*0.5-16, self.radian)];
    
    [bezierPath addQuadCurveToPoint:CGPointMake(width*0.5+16, self.radian) controlPoint:CGPointMake(width*0.5, -self.radian)];
    [bezierPath addLineToPoint:CGPointMake(width, self.radian)];
    if(self.tag == 100003){
        CGFloat startAngle = M_PI*1.5; //
        CGFloat endAngle = 0 ;
        [bezierPath addArcWithCenter:CGPointMake(width-20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    [bezierPath addLineToPoint: CGPointMake(width, height+60)];
    [bezierPath addLineToPoint: CGPointMake(0, height+60)];
    [bezierPath addLineToPoint: CGPointMake(0, self.radian)];
    if(self.tag == 100000){
        CGFloat startAngle = M_PI; //
        CGFloat endAngle = M_PI*1.5 ;
        [bezierPath addArcWithCenter:CGPointMake(20, 26) radius:20 startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = bezierPath.CGPath;
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
        [self setSelected:NO];
    }else{
        [self setUnSelected:NO];
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

- (UIImageView *)normalImageView{
    if(!_normalImageView){
        _normalImageView = [[UIImageView alloc]init];
        _normalImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _normalImageView;
}

@end
