//
//  SettingManager.h
//  CST_Demo
//
//  Created by 春水堂 on 15/10/8.
//  Copyright © 2015年 zouao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingManager : NSObject

+ (id)standerManager;

/*
 * 版本检测与更新
 */
- (void)onUpdateVersion;

@end
