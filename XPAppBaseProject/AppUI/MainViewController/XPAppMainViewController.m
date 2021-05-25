//
//  XPAppMainViewController.m
//  XPAppBaseProject
//
//  Created by LinXipin on 2021/5/24.
//

#import "XPAppMainViewController.h"
//view
#import "XPAppMainView.h"
//viewModel
#import "XPAppMainViewModel.h"
//
#import "XPAppNetworking.h"

@interface XPAppMainViewController ()

/**mainView*/
@property (strong, nonatomic) XPAppBaseView<XPAppMainViewModel *> *mainView;
/**XPAppMainViewModel*/
@property (strong, nonatomic) XPAppMainViewModel *viewModel;

@end

@implementation XPAppMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self getHomeData];
}

- (void)setNavigationView {
    [super setNavigationView];
    self.navigationCustomTitle.text = @"navigation";
}
- (void)addSubviewInView {
    [self.view addSubview:self.mainView];
    /**mainView*/
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationCustomView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}



- (void)getData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithCapacity:1];
    [params setValue:@"IOS" forKey:@"systemType"];
    [XPAppNetworking XPNetworkingPostMethodWithURLPrefix_baseURL:@"" URL:@"http://111.12.155.112:8080/hsa-app-service/app/update/queryVersion" header:nil params:params successResult:^(id  _Nonnull responseObj) {
        NSLog(@"\nresponseObj\n%@",responseObj);
    } failResult:^(NSError * _Nonnull error) {
        NSLog(@"\nerror\n%@",error);
    }];
}

- (void)getHomeData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithCapacity:1];
    [params setValue:@"15759533627" forKey:@"mobile"];
    [params setValue:@"639900" forKey:@"cityCode"];
    [XPAppNetworking XPNetworkingPostMethodWithURLPrefix_baseURL:@"" URL:@"http://111.12.155.112:8080/hsa-app-service/app/manage/getHomePage" header:nil params:params successResult:^(id  _Nonnull responseObj) {
    } failResult:^(NSError * _Nonnull error) {
        NSLog(@"\nerror\n%@",error);
    }];
}

/**XPAppMainView*/
- (XPAppBaseView *)mainView
{
    if (!_mainView) {
        _mainView = [[XPAppMainView alloc]initWithFrame:CGRectZero viewModel:self.viewModel];
    }
    return _mainView;
}

/**XPAppMainViewModel*/
- (XPAppMainViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[XPAppMainViewModel alloc]init];
    }
    return _viewModel;
}


@end
