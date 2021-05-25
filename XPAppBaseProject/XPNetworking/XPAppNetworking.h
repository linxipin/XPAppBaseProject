//
//  XPAppNetworking.h
//  XPAppBaseProject
//
//  Created by LinXipin on 2021/5/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPAppNetworking : NSObject

/// post网络请求
/// @param URLProfix_baseURL baseURL 如果没有baseURL 这个不用传 把详细的地址传到URL
/// @param URL 详细的地址
/// @param headerDic 请求头部
/// @param params 请求参数
/// @param successResult 请求成功回调
/// @param failResult 请求失败回调
+ (void)XPNetworkingPostMethodWithURLPrefix_baseURL:(nullable NSString *)URLProfix_baseURL URL:(nullable NSString *)URL header:(nullable NSDictionary <NSString *, NSString *> *)headerDic params:(nullable NSMutableDictionary *)params successResult:(nullable void (^)(id responseObj))successResult failResult:(nullable void (^)(NSError *error))failResult;

/// 获取网络状态
+(void) AFNetMonitor;

@end

NS_ASSUME_NONNULL_END
