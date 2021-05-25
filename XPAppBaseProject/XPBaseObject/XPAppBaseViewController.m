//
//  XPAppBaseViewController.m
//  XPAppBaseProject
//
//  Created by LinXipin on 2021/5/24.
//

#import "XPAppBaseViewController.h"

@interface XPAppBaseViewController ()

@end

@implementation XPAppBaseViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"进入页面⭕️:========== %@ ========",NSStringFromClass([self class]));
}
#pragma mark - 界面销毁输出
-(void)dealloc{
    NSLog(@"销毁页面❌:========== %@ ========",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationView];
    [self addSubviewInView];
}

- (void)setNavigationView {
    [self.view addSubview:self.navigationCustomView];
    [self.view bringSubviewToFront:self.navigationCustomView];
    [self.view addSubview:self.navigationCustomLine];
    [self.navigationCustomView addSubview:self.navigationCustomImage];
    [self.navigationCustomView sendSubviewToBack:self.navigationCustomImage];
    [self.navigationCustomView addSubview:self.navigationCustomTitle];
    [self.navigationCustomView addSubview:self.backButton];

    //navigation height
    CGRect rectNav = self.navigationController.navigationBar.frame;
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat nav_status_height = rectStatus.size.height + rectNav.size.height;

    /**self.navigationCustomView*/
    [self.navigationCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(nav_status_height));
    }];
    /**navigationCustomLine*/
    [self.navigationCustomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationCustomView.mas_bottom).offset(-1);
        make.left.equalTo(self.navigationCustomView);
        make.right.equalTo(self.navigationCustomView);
        make.height.equalTo(@(0.5));
    }];
    
    /**navigationCustomImage*/
    [self.navigationCustomImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationCustomView);
        make.left.equalTo(self.navigationCustomView);
        make.right.equalTo(self.navigationCustomView);
        make.bottom.equalTo(self.navigationCustomView);
    }];
    
    /**self.navigationCustomTitle*/
    [self.navigationCustomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backButton);
        make.centerX.equalTo(self.navigationCustomView);
        make.right.equalTo(self.navigationCustomView).offset(-60);
        make.left.equalTo(self.navigationCustomView).offset(60);
//        make.height.equalTo(@(Height_NavBar_View));
    }];
    
    /**self.backButton*/
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationCustomView).offset(rectStatus.size.height);
        make.left.equalTo(self.navigationCustomView).offset(10);
        make.height.width.equalTo(@(rectNav.size.height));
    }];
}

#pragma mark - Target Mehtods
- (void)addSubviewInView {}


#pragma mark - Setter & Getter
/**navigationCustomView*/
- (UIView *)navigationCustomView
{
    if (!_navigationCustomView) {
        _navigationCustomView = [[UIView alloc]init];
        _navigationCustomView.backgroundColor = [UIColor clearColor];
    }
    return _navigationCustomView;
}
/**navigationCustomLine*/
- (UIImageView *)navigationCustomLine
{
    if (!_navigationCustomLine) {
        _navigationCustomLine = [[UIImageView alloc]init];
        _navigationCustomLine.hidden = NO;
        _navigationCustomLine.backgroundColor = kColorWithHex(0xEFEFEF);
    }
    return _navigationCustomLine;
}

/**navigationCustomImage*/
- (UIImageView *)navigationCustomImage
{
    if (!_navigationCustomImage) {
        _navigationCustomImage = [[UIImageView alloc]init];
    }
    return _navigationCustomImage;
}

/**navigationCustomTitle*/
- (UILabel *)navigationCustomTitle
{
    if (!_navigationCustomTitle) {
        _navigationCustomTitle = [[UILabel alloc]init];
        _navigationCustomTitle.textAlignment = NSTextAlignmentCenter;
        _navigationCustomTitle.numberOfLines = 2;
    }
    return _navigationCustomTitle;
}

/**backButton*/
- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backButton.backgroundColor = [UIColor clearColor];
        [_backButton setImage:[UIImage imageNamed:@"navi_back"] forState:(UIControlStateNormal)];
    }
    return _backButton;
}


@end
