//
//  AppDelegate.m
//  XPAppBaseProject
//
//  Created by LinXipin on 2021/5/21.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "XPTabBarController.h"

#import "XPAppMainViewController.h"

@interface AppDelegate ()<HSATabBarControllerDelegate>

@property (nonatomic, strong) XPTabBarController *tabbarVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.tabbarVC = [[XPTabBarController alloc] init];
    self.tabbarVC.tabbarDelegate = self;

    XPAppMainViewController *homeVC =  [[XPAppMainViewController alloc] init];
    UIViewController *placeZoneVC = [[ViewController alloc] init];
    UIViewController *newsVC = [[ViewController alloc] init];
    UIViewController *mineVC = [[ViewController alloc] init];
    
    NSArray *vcArr = @[homeVC,placeZoneVC,newsVC,mineVC];
    NSArray *titleArr = @[@"首页",@"地方专区",@"办事指南",@"我的"];
    NSArray *imageNameArr = @[@"tabbar_home",@"tabbar_place",@"tabbar_consult",@"tabbar_mine"];
    NSArray *selectedImageNameArr = @[@"tabbar_home_selected",@"tabbar_place_selected",@"tabbar_consult_selected",@"tabbar_mine_selected"];
    
    [self.tabbarVC setupTabWithVCArr:vcArr imageNameArr:imageNameArr selectedImageNameArr:selectedImageNameArr titleArr:titleArr titleColor:kColorWithHex(0xDDDDDD) selecedTitleColor:kColorWithHex(0x1890FF)];
    //中间凸出的tabbar
//    [self.tabbarVC setupCenterTabWithTitle:@"医保电子凭证" centerTitleColor:[UIColor redColor] centerImage:@"tabbar_middle_certificate" centerSelectImage:@"tabbar_middle_certificate" middleVC:nil isPresentVC:NO isHasCurveLine:NO curveLineColor:UIColor.clearColor];
    
    self.window.rootViewController = self.tabbarVC;
    self.window.backgroundColor = [UIColor whiteColor];

    return YES;
}


- (BOOL)hsaTabBarController:(XPTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController isCenterTab:(BOOL)isCenterTab {
    return YES;
}

- (void)hsaTabBarController:(XPTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"didSelectViewController");
}


@end
