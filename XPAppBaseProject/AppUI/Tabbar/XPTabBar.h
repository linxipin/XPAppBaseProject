//
//  XPTabBar.h
//  XPTabBar
//
//  Created by yuan on 2019/10/2.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DidTabBarMiddleBtn)(void);

@interface XPTabBar : UITabBar

@property (nonatomic, strong) UIColor *centerBtnTitleColor;
@property (nonatomic, strong) NSString *centerBtnTitle;
@property (nonatomic, strong) NSString *centerBtnImage;
@property (nonatomic, strong) NSString *centerBtnSelectImage;

@property (nonatomic, copy) DidTabBarMiddleBtn didTabBarMiddleBtn;

- (instancetype)initWithNeedCenterBtn:(BOOL)isNeedCenterBtn tabbarBtnNum:(NSInteger)tabbarBtnNum isHasCurveLine:(BOOL)isHasCurveLine curveLineColor:(UIColor *)curveLineColor;

// 自定义曲线
- (void)setupTabBarCurveLineColor:(UIColor *)lineColor;

@end

NS_ASSUME_NONNULL_END
