//
//  XPAppBaseViewController.h
//  XPAppBaseProject
//
//  Created by LinXipin on 2021/5/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPAppBaseViewController : UIViewController

/**navigationCustomView*/
@property (strong, nonatomic) UIView *navigationCustomView;
/**navigationCustomLine*/
@property (strong, nonatomic) UIImageView *navigationCustomLine;
/**navigationCustomImage 负责渲染背景*/
@property (strong, nonatomic) UIImageView *navigationCustomImage;

/**navigationCustomTitle*/
@property (strong, nonatomic) UILabel *navigationCustomTitle;
/**backButton*/
@property (strong, nonatomic) UIButton *backButton;

/**isLevelOnePage 是否是一级页*/
@property (assign, nonatomic) BOOL isLevelOnePage;

- (void)setNavigationView;
- (void)addSubviewInView;

@end

NS_ASSUME_NONNULL_END
