//
//  LocalNotificationManager.h
//  AppSettingsManagerDemo
//
//  Created by laizhijian on 2019/2/2.
//  Copyright © 2019 laizhijian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalNotificationManager : NSObject

/**
 *
 *   @param   interval      future interval for notification
 *   @param   content       noti for content
 *   @param   key           register's key
 */
+ (void)registerLocalNotificationWithInterval:(double)interval content:(NSString *)content key:(NSString *)key;

/**
 *
 *  @param   key   cancel noti according to register's key
 *
 */
+ (void)cancelLocalNotificationWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
