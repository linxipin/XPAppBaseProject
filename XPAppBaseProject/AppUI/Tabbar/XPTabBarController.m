//
//  XPTabBarController.m
//  XPTabBarController
//
//  Created by yuan on 2019/10/2.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "XPTabBarController.h"
#import "XPTabBar.h"

@interface XPTabBarController () <UITabBarControllerDelegate>

@property (nonatomic, strong) NSArray *vcArr;

@end

@implementation XPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.delegate = self;
}

#pragma mark - 移除系统TabBar顶部线
- (void)removeSystemTabBarTopLine:(BOOL)isHasCurveLine {
    if (isHasCurveLine) {
        self.tabBar.shadowImage = [UIImage new];
    } else {
        self.tabBar.shadowImage = [UIImage imageWithColor:UIColorHex(D9DEE8) size:CGSizeMake(self.tabBar.frame.size.width, 0.5)];
    }
    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.barTintColor = [UIColor whiteColor];
}

#pragma mark - 设置Tab元素
- (void)setupTabWithVCArr:(NSArray *)vcArr imageNameArr:(NSArray *)imageNameArr selectedImageNameArr:(NSArray *)selectedImageNameArr titleArr:(NSArray *)titleArr titleColor:(UIColor *)titleColor selecedTitleColor:(UIColor *)selecedTitleColor {
    //设置系统默认
    //没有选中的tabbar文字的颜色
    [self.tabBar setUnselectedItemTintColor:titleColor];
    //没有选中的tabbar文字的颜色
    [self.tabBar setTintColor:selecedTitleColor];
    _vcArr = vcArr;
    [vcArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildVC:[vcArr objectAtIndex:idx]
               imageName:[imageNameArr objectAtIndex:idx]
       selectedImageName:[selectedImageNameArr objectAtIndex:idx]
                   title:[titleArr objectAtIndex:idx]
              titleColor:titleColor
       selecedTitleColor:selecedTitleColor];
    }];
}

- (void)addChildVC:(UIViewController *)childVc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title titleColor:(UIColor *)titleColor selecedTitleColor:(UIColor *)selecedTitleColor {
    if (!childVc) {
        return;
    }
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
    tabBarItem.image = [self imageWithOriRenderingImage:imageName];
    tabBarItem.selectedImage = [self imageWithOriRenderingImage:selectedImageName];
    tabBarItem.title = title;
    
    childVc.tabBarItem = tabBarItem;
    childVc.navigationItem.title = title;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:childVc];

    [self addChildViewController:navi];
}

- (UIImage *)imageWithOriRenderingImage:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

#pragma mark - 设置中间Tab
- (void)setupCenterTabWithTitle:(NSString *)centerTitle centerTitleColor:(UIColor *)centerTitleColor centerImage:(NSString *)centerImage centerSelectImage:(NSString *)centerSelectImage middleVC:(UIViewController *)middleVC isPresentVC:(BOOL)isPresentVC isHasCurveLine:(BOOL)isHasCurveLine curveLineColor:(UIColor *)curveLineColor {
    
    if (!isPresentVC && middleVC) {
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:middleVC];
        [self addChildViewController:navi];
    }
    
    XPTabBar *tabBar = [[XPTabBar alloc] initWithNeedCenterBtn:YES tabbarBtnNum:(self.vcArr.count+1) isHasCurveLine:isHasCurveLine curveLineColor:curveLineColor];
    tabBar.centerBtnTitle = centerTitle;
    tabBar.centerBtnTitleColor = centerTitleColor;
    tabBar.centerBtnImage = centerImage;
    tabBar.centerBtnSelectImage = centerSelectImage;
    
    [self setValue:tabBar forKey:@"tabBar"];
    
    __weak __typeof(self)weakSelf = self;
    tabBar.didTabBarMiddleBtn = ^{
        [weakSelf didTabBarMiddleBtnWithMiddleVC:middleVC isPresentVC:isPresentVC];
    };
    
    [self removeSystemTabBarTopLine:isHasCurveLine];
}

/// 点击中间按钮触发的方法
/// @param middleVC 中间的控制器
/// @param isPresentVC 是否PresentVC
- (void)didTabBarMiddleBtnWithMiddleVC:(UIViewController *)middleVC isPresentVC:(BOOL)isPresentVC {
    BOOL isShouldSelect = NO;
    if ([self.tabbarDelegate respondsToSelector:@selector(XPTabBarController:shouldSelectViewController:isCenterTab:)]) {
        isShouldSelect = [self.tabbarDelegate XPTabBarController:self shouldSelectViewController:nil isCenterTab:YES];
    } else {
        isShouldSelect = YES;
    }
    
    if (!isShouldSelect) {
        return;
    }
    if (isPresentVC) {
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:middleVC];
        navi.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:navi animated:YES completion:nil];
    } else {
        self.selectedIndex = self.childViewControllers.count-1;
    }
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([self.tabbarDelegate respondsToSelector:@selector(XPTabBarController:shouldSelectViewController:isCenterTab:)]) {
        return [self.tabbarDelegate XPTabBarController:self shouldSelectViewController:viewController isCenterTab:NO];
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([self.tabbarDelegate respondsToSelector:@selector(XPTabBarController:didSelectViewController:)]) {
        [self.tabbarDelegate XPTabBarController:self didSelectViewController:viewController];
    }
}


@end
