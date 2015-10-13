//
//  SettingManager.m
//  CST_Demo
//
//  Created by 春水堂 on 15/10/8.
//  Copyright © 2015年 zouao. All rights reserved.
//

#import "SettingManager.h"
#import "HttpManager.h"

static SettingManager *manager = nil;
@interface SettingManager () {
    //update version
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIAlertView                     *alertView;
#pragma clang diagnostic pop
    NSURL                           *url;
    NSString                        *Type;//判断是否强制更新
}

@end

@implementation SettingManager

+ (id)standerManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}


- (id)init
{
    self = [super init];
    if (self) {
     
    }
    return self;
}


- (void)onUpdateVersion
{
    NSString *_DLPath = @"http://api.iball.cc/exercise/checkVersion/?";
    [HttpManager cancelAllRequest];
    
    NSDictionary *dict = @{@"mobileType":@"2",@"productName":@"iball",@"area":@"1"};
    NSData *dataJson = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
    NSString *jsonStr = [[NSString alloc]initWithData:dataJson encoding:NSUTF8StringEncoding];
    NSString *jsonData = [NSString stringWithFormat:@"%@jsonData=%@",_DLPath,jsonStr];
    
    [HttpManager AFGetRequest:jsonData view:nil success:^(id json) {
        if ([json[@"reCode"] integerValue] > 0) {
            
            NSString *VersionStringURL = [json[@"arrayData"][@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
            
            NSString *VersionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            NSString *VersionStringURL2 = [VersionString stringByReplacingOccurrencesOfString:@"." withString:@""];
            
            //当前设备的版本号小于后台版本号，就提示下载更新
            if ([VersionStringURL2 integerValue] < [VersionStringURL integerValue]) {
                
                Type = [[NSString alloc]initWithString:json[@"arrayData"][@"isup"]];
                url = [[NSURL alloc]initWithString:json[@"arrayData"][@"downloadPath"]];
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                alertView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"温馨提示",@"") message:NSLocalizedString(@"有新版本是否更新？",@"") delegate:self cancelButtonTitle:NSLocalizedString(@"取消",@"") otherButtonTitles:NSLocalizedString(@"确定",@""), nil];
#pragma clang diagnostic pop
                [alertView show];
                
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [[UIApplication sharedApplication]openURL:url];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            exit(0);
        });
        
    }else{
        
        if ([Type isEqualToString:@"1"]) {
            exit(0);
        }else{
            NSLog(@"不强制更新");
        }
        
    }
}

@end
