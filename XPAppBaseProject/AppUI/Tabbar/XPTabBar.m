//
//  XPTabBar.m
//  XPTabBar
//
//  Created by LXP on 2019/10/2.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "XPTabBar.h"

#define SCREENWIDTH  ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight  ([UIScreen mainScreen].bounds.size.height)

static NSInteger const kBarBackgroundTag = 999;

@interface XPTabBar()

@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, assign) NSInteger tabbarBtnNum;

// 自定义特殊曲线
@property (nonatomic, strong) UIColor *curveLineColor;
@property (nonatomic, assign) BOOL isHasCurveLine;

@end

@implementation XPTabBar

- (instancetype)initWithNeedCenterBtn:(BOOL)isNeedCenterBtn tabbarBtnNum:(NSInteger)tabbarBtnNum isHasCurveLine:(BOOL)isHasCurveLine curveLineColor:(UIColor *)curveLineColor {
    self = [super init];
    if (self) {
        _tabbarBtnNum = tabbarBtnNum;
        _isHasCurveLine = isHasCurveLine;
        _curveLineColor = curveLineColor;
        if (isNeedCenterBtn) {
            [self initSubViews];
        }
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.centerButton];
    self.translucent = NO;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews{
    [super layoutSubviews];

    if (self.isHasCurveLine) {
        [self setupTabBarCurveLineColor:self.curveLineColor];
    }
    
    
    CGFloat width = self.frame.size.width/self.tabbarBtnNum;
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *view in self.subviews) {
        if ([view isEqual:self.centerButton]) {
            view.size = CGSizeMake(width, self.isHasCurveLine?50:(SCREENWIDTH == 320 ? 50 : 80));
            view.center = CGPointMake(self.frame.size.width/2, self.isHasCurveLine?6:8);
        } else if ([view isKindOfClass:class]) {
            CGRect frame = view.frame;
            int indexFromOrign = view.frame.origin.x/width;
            if (indexFromOrign >= (self.tabbarBtnNum - 1) / 2) {
                indexFromOrign++;
            }
            CGFloat x = indexFromOrign * width;
            view.frame = CGRectMake(x, view.frame.origin.y, width, frame.size.height);
        }
    }
    if (self.centerBtnTitle.isNotBlank) {
        if (SCREENWIDTH == 320) {
            self.centerButton.titleEdgeInsets = UIEdgeInsetsMake(self.centerButton.imageView.height + 10, -self.centerButton.imageView.width, 0.0, 0.0);
            self.centerButton.imageEdgeInsets = UIEdgeInsetsMake(-self.centerButton.titleLabel.height, (self.centerButton.width-self.centerButton.imageView.width)/2.0, 0.0, (self.centerButton.width-self.centerButton.imageView.width)/2.0);
        } else {
            self.centerButton.titleEdgeInsets = UIEdgeInsetsMake(self.centerButton.imageView.height-8, -self.centerButton.imageView.width, 0.0, 0.0);
            self.centerButton.imageEdgeInsets = UIEdgeInsetsMake(-self.centerButton.titleLabel.height, (self.centerButton.width-self.centerButton.imageView.width)/2.0, 0.0, (self.centerButton.width-self.centerButton.imageView.width)/2.0);
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (!self.isHidden) {
        CGPoint newP = [self convertPoint:point toView:self.centerButton];
        if ([self.centerButton pointInside:newP withEvent:event]) {
            return self.centerButton;
        }else{
            return [super hitTest:point withEvent:event];
        }
    } else {
        return [super hitTest:point withEvent:event];
    }
}

#pragma mark - 自定义曲线
- (void)setupTabBarCurveLineColor:(UIColor *)lineColor {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            if (![view viewWithTag:kBarBackgroundTag]) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
                lineView.userInteractionEnabled = NO;
                lineView.backgroundColor = [UIColor clearColor];
                lineView.tag = kBarBackgroundTag;
                
                [view addSubview:[self addLineViewToParentView:lineView lineColor:lineColor]];
            }
        }
    }
}

- (UIView *)addLineViewToParentView:(UIView *)parent lineColor:(UIColor *)lineColor {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat middleW = 95;
    CGFloat lineW = (width - middleW)/2;
    CGFloat lineY = 0;
    CGFloat lineBottomY = 34;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, lineY)];
    [bezierPath addLineToPoint:CGPointMake(lineW, lineY)];
    
    [bezierPath addCurveToPoint:CGPointMake(self.center.x, lineY+lineBottomY)
                  controlPoint1:CGPointMake(self.center.x-18, lineY)
                  controlPoint2:CGPointMake(self.center.x-32, lineY+lineBottomY-3)];

    [bezierPath addCurveToPoint:CGPointMake(width-lineW, lineY)
                  controlPoint1:CGPointMake(self.center.x+32, lineY+lineBottomY-3)
                  controlPoint2:CGPointMake(self.center.x+18, lineY)];
    
    [bezierPath addLineToPoint:CGPointMake(width, lineY)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.strokeColor = lineColor.CGColor;
    shapeLayer.fillColor = nil;
    shapeLayer.lineWidth = 1;
    shapeLayer.frame = CGRectMake(0.0, 0.0, width, [UIScreen mainScreen].bounds.size.height);
    [parent.layer addSublayer:shapeLayer];
    parent.userInteractionEnabled = NO;
    return parent;
}

#pragma mark - Button 操作
- (void)didMiddleBtn:(UIButton*)sender {
    if (self.didTabBarMiddleBtn) {
        self.didTabBarMiddleBtn();
    }
}

- (void)setCenterBtnImage:(NSString *)centerBtnImage {
    _centerBtnImage = centerBtnImage;
    [self.centerButton setImage:[UIImage imageNamed:self.centerBtnImage] forState:UIControlStateNormal];
    [self.centerButton setImage:[UIImage imageNamed:self.centerBtnImage] forState:UIControlStateHighlighted];
}

- (void)setCenterBtnSelectImage:(NSString *)centerBtnSelectImage {
    _centerBtnSelectImage = centerBtnSelectImage;
    [self.centerButton setImage:[UIImage imageNamed:self.centerBtnSelectImage] forState:UIControlStateSelected];
}

- (void)setCenterBtnTitle:(NSString *)centerBtnTitle {
    _centerBtnTitle = centerBtnTitle;
    [self.centerButton setTitle:self.centerBtnTitle forState:UIControlStateNormal];
    [self.centerButton setTitle:self.centerBtnTitle forState:UIControlStateHighlighted];
}

- (void)setCenterBtnTitleColor:(UIColor *)centerBtnTitleColor {
    _centerBtnTitleColor = centerBtnTitleColor;
    [self.centerButton setTitleColor:centerBtnTitleColor forState:UIControlStateNormal];
    [self.centerButton setTitleColor:centerBtnTitleColor forState:UIControlStateHighlighted];
}

- (UIButton *)centerButton{
    if (!_centerButton) {
        _centerButton = [[UIButton alloc] init];
        _centerButton.titleLabel.font = SCREENWIDTH == 320 ? [UIFont systemFontOfSize:8.32]: [UIFont systemFontOfSize:10.32];
        [_centerButton addTarget:self action:@selector(didMiddleBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}

@end
