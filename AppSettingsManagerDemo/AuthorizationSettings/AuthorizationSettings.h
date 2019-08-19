//
//  AuthorizationSettings.h
//  AuthorizationSettings
//
//  Created by janlionly<jan_ron@qq.com> on 2019/8/19.
//  Copyright © 2019 laizhijian. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for AuthorizationSettings.
FOUNDATION_EXPORT double AuthorizationSettingsVersionNumber;

//! Project version string for AuthorizationSettings.
FOUNDATION_EXPORT const unsigned char AuthorizationSettingsVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <AuthorizationSettings/PublicHeader.h>
#if __has_include("AudioRecorderManager.h")
#import <AuthorizationSettings/AudioRecorderManager.h>
#endif

#if __has_include("LocalNotificationManager.h")
#import <AuthorizationSettings/LocalNotificationManager.h>
#endif

#if __has_include("AppSettingsManager.h")
#import <AuthorizationSettings/AppSettingsManager.h>
#endif

