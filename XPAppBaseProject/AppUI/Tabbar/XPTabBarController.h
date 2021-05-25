//
//  XPTabBarController.h
//  XPTabBarController
//
//  Created by LXP on 2019/10/2.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XPTabBarController;

@protocol HSATabBarControllerDelegate <NSObject>

@optional
- (BOOL)XPTabBarController:(XPTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController isCenterTab:(BOOL)isCenterTab;

- (void)XPTabBarController:(XPTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end

@interface XPTabBarController : UITabBarController

@property (nonatomic, weak) id<HSATabBarControllerDelegate> tabbarDelegate;

// 移除系统TabBar顶部线
- (void)removeSystemTabBarTopLine:(BOOL)isHasCurveLine;

/**
 设置Tab元素

 @param vcArr Tab 对应 VC数组
 @param titleArr Tab 标题数组
 @param imageNameArr Tab 图片默认数组
 @param selectedImageNameArr Tab 图片选中数组
 */

/**
 设置Tab元素

 @param vcArr Tab 对应 VC数组
 @param imageNameArr Tab 图片默认数组
 @param selectedImageNameArr Tab 图片选中数组
 @param titleArr Tab 标题数组
 @param titleColor Tab 标题颜色
 @param selecedTitleColor Tab 标题选中颜色
 */
- (void)setupTabWithVCArr:(NSArray *)vcArr imageNameArr:(NSArray *)imageNameArr selectedImageNameArr:(NSArray *)selectedImageNameArr titleArr:(NSArray *)titleArr titleColor:(UIColor *)titleColor selecedTitleColor:(UIColor *)selecedTitleColor ;

/**
 设置中间Tab
 需要先调用setupTabWithVCArr 设置其他Tab元素，在调用此方法设置中间Tab

 @param centerTitle 中间Tab标题
 @param centerTitleColor 中间Tab标题颜色
 @param centerImage 中间Tab图片
 @param centerSelectImage 中间Tab选中图片
 @param middleVC 中间Tab对应VC
 @param isPresentVC 中间Tab 是否Present
 @param isHasCurveLine 中间Tab是否含有特殊曲线
 @param curveLineColor 中间Tab特殊曲线颜色
 */
- (void)setupCenterTabWithTitle:(NSString *)centerTitle centerTitleColor:(UIColor *)centerTitleColor centerImage:(NSString *)centerImage centerSelectImage:(NSString *)centerSelectImage middleVC:(UIViewController *)middleVC isPresentVC:(BOOL)isPresentVC isHasCurveLine:(BOOL)isHasCurveLine curveLineColor:(UIColor *)curveLineColor;

@end

