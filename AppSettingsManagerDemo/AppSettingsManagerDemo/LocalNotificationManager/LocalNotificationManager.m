//
//  LocalNotificationManager.m
//  AppSettingsManagerDemo
//
//  Created by laizhijian on 2019/2/2.
//  Copyright © 2019 laizhijian. All rights reserved.
//

#import "LocalNotificationManager.h"
#import <UIKit/UIKit.h>

@implementation LocalNotificationManager

+ (void)registerLocalNotificationWithInterval:(double)interval content:(NSString *)content key:(NSString *)key;
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:interval];
    notification.fireDate = fireDate;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.repeatInterval = 0;
    notification.alertBody =  content;
    notification.applicationIconBadgeNumber = 1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:content forKey:key];
    notification.userInfo = userDict;

    [self getRequestWithLocalNotificationSleep:notification];
}

+ (void)getRequestWithLocalNotificationSleep:(UILocalNotification *)notification {
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

+ (void)cancelLocalNotificationWithKey:(NSString *)key {
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    if (localNotifications) {
        for (UILocalNotification *notification in localNotifications) {
            NSDictionary *userInfo = notification.userInfo;
            if (userInfo) {
                NSString *info = userInfo[key];
                
                if ([info isEqualToString:key]) {
                    if (notification) {
                        [[UIApplication sharedApplication] cancelLocalNotification:notification];
                    }
                    break;
                }
            }
        }
    }
}

@end
