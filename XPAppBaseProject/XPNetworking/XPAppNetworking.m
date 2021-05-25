//
//  XPAppNetworking.m
//  XPAppBaseProject
//
//  Created by LinXipin on 2021/5/24.
//

#import "XPAppNetworking.h"

@implementation XPAppNetworking

+ (void)XPNetworkingPostMethodWithURLPrefix_baseURL:(NSString *)URLProfix_baseURL URL:(NSString *)URL header:(NSDictionary<NSString *,NSString *> *)headerDic params:(NSMutableDictionary *)params successResult:(void (^)(id _Nonnull))successResult failResult:(void (^)(NSError * _Nonnull))failResult {
    
    [self AFNetMonitor];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    requestSerializer.timeoutInterval = 30.0;
    manager.requestSerializer = requestSerializer;

    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", @"text/json", @"text/javascript" ,nil];
    manager.responseSerializer = responseSerializer;
    //完整的地址
    NSString *CompleteURL = @"";
    if (kStringIsEmpty(URLProfix_baseURL)) {
        CompleteURL = URL;
    }else {
        CompleteURL = [NSString stringWithFormat:@"%@%@",URLProfix_baseURL,URL];
    }

    NSMutableDictionary *header = [[NSMutableDictionary alloc]init];
    [header setValue:@"app" forKey:@"channel"];
    
    ///输出
    {
        NSLog(@"\n请求地址 == \n%@",CompleteURL);
        NSLog(@"\n参数 == \n%@",params);
        NSLog(@"\nheader == \n%@",header);
    }
    
    [manager POST:CompleteURL parameters:params headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = responseObject;
        successResult(resultDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failResult(error);
    }];
}
+ (void)XPNetworkingGetMethodWithURLPrefix_baseURL:(NSString *)URLProfix_baseURL URL:(NSString *)URL header:(NSDictionary<NSString *,NSString *> *)headerDic params:(NSMutableDictionary *)params successResult:(void (^)(id _Nonnull))successResult failResult:(void (^)(NSError * _Nonnull))failResult {
    [self AFNetMonitor];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    requestSerializer.timeoutInterval = 30.0;
    manager.requestSerializer = requestSerializer;

    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", @"text/json", @"text/javascript" ,nil];
    manager.responseSerializer = responseSerializer;
    //完整的地址
    NSString *CompleteURL = @"";
    if (kStringIsEmpty(URLProfix_baseURL)) {
        CompleteURL = URL;
    }else {
        CompleteURL = [NSString stringWithFormat:@"%@%@",URLProfix_baseURL,URL];
    }
    ///输出
    {
        NSLog(@"\n请求地址 == \n%@",CompleteURL);
        NSLog(@"\n参数 == \n%@",params);
        NSLog(@"\nheader == \n%@",headerDic);
    }
    [manager GET:CompleteURL parameters:params headers:headerDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = responseObject;
        successResult(resultDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failResult(error);
    }];
}

//获取网络状态
+(void) AFNetMonitor{
    //启动网络状态监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //监听网络状态
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"网络不可用");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi网络可用");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"移动网络可用");
                break;
            default:
                break;
        }
    }];
}

+ (void)printResultWithResult:(NSDictionary *)responseObject {
    // json数据或者NSDictionary转为NSData，responseObject为json数据或者NSDictionary
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    // NSData转为NSString
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"\r获取的json数据是:%@",jsonStr);
}

@end
