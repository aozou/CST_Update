//
//  HttpManager.m
//  CSTMall
//
//  Created by cst on 14-8-11.
//  Copyright (c) 2014年 cst. All rights reserved.
//

#import "HttpManager.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@implementation HttpManager
+ (void)AFGetRequest:(NSString *)urlPath view:(UIView *)view success:(Success)success failure:(Failure)failure
{
    NSString *encodingString = [urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *pathStr = encodingString;

    if ([view isKindOfClass:[view class]])
    {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    AFHTTPRequestOperationManager *httpClient = [AFHTTPRequestOperationManager manager];
    httpClient.requestSerializer.timeoutInterval = 5;
    httpClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSLog(@"%@",pathStr);
    [httpClient GET:pathStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([view isKindOfClass:[view class]]) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        NSDictionary *dic = (NSDictionary *)responseObject;
        if (success) {
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([view isKindOfClass:[view class]]) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)AFPostRequest:(NSString *)urlPath parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    AFHTTPRequestOperationManager *aClient = [AFHTTPRequestOperationManager manager];
    aClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *path = urlPath;
    [aClient POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if (success) {
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 回复消息请求
+ (void)AFGetRequest:(NSString *)urlPath view:(UIView *)view row:(NSUInteger)row success:(MsgSuccess)success failure:(MsgFailure)failure
{
    NSString *encodingString = [urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *pathStr = encodingString;
    
    if ([view isKindOfClass:[view class]])
    {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:0];
    
    AFHTTPRequestOperationManager *httpClient = [AFHTTPRequestOperationManager manager];
    httpClient.requestSerializer.timeoutInterval = 15;
    httpClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [httpClient GET:pathStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([view isKindOfClass:[view class]]) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        NSDictionary *dic = (NSDictionary *)responseObject;
        if (success) {
            success(dic,index);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:view animated:YES];
        if (failure) {
            failure(error,index);
        }
    }];
}

+ (void)AFGetSecondRequest:(NSString *)urlPath success:(Success)success failure:(Failure)failure
{
    NSString *encodingString = [urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *pathStr = encodingString;
    
    AFHTTPRequestOperationManager *httpClient = [AFHTTPRequestOperationManager manager];
    httpClient.requestSerializer.timeoutInterval = 5;
    httpClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSLog(@"%@",pathStr);
    [httpClient GET:pathStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if (success) {
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)cancelAllRequest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue cancelAllOperations];
}

@end
