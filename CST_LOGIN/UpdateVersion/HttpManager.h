//
//  HttpManager.h
//  CSTMall
//
//  Created by cst on 14-8-11.
//  Copyright (c) 2014年 cst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
//#import "GifView.h"

@interface HttpManager : NSObject<MBProgressHUDDelegate>
typedef void(^Success)(id json);
typedef void(^Failure)(NSError* error);

typedef void(^MsgSuccess)(id json,NSIndexPath* index);
typedef void(^MsgFailure)(NSError* error,NSIndexPath* index);

+ (void)AFGetRequest:(NSString *)urlPath view:(UIView *)view success:(Success)success failure:(Failure)failure;

+ (void)AFPostRequest:(NSString *)urlPath parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

// 回复消息请求
+ (void)AFGetRequest:(NSString *)urlPath view:(UIView *)view row:(NSUInteger)row success:(MsgSuccess)success failure:(MsgFailure)failure;

+ (void)AFGetSecondRequest:(NSString *)urlPath success:(Success)success failure:(Failure)failure;

//取消之前请求
+ (void)cancelAllRequest;

@end
