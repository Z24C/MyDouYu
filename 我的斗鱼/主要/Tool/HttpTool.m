//
//  HttpTool.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/28.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

@implementation HttpTool
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
