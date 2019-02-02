//
//  AppSettingsManager.h
//  JLUIKit
//
//  Created by laizhijian on 2019/1/11.
//  Copyright © 2019 janlionly. All rights reserved.
//
// This tool use to the app close the notification, photolib, camera, will alert user to open the privacy switch

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#warning your app's Info.plist must add Privacy key with string values explaining to the user how the app uses this data, see this app info.plist

@interface AppSettingsManager : NSObject

+ (BOOL)requestNotificationAccessWithTitle:(NSString *)title shouldAlert:(BOOL)shouldAlert completion:(void(^)(void))completion; // app settings for local or remote notification closed
+ (BOOL)requestPhotoAlbumAccessWithTitle:(NSString *)title completion:(void(^)(void))completion; // app settings for photo album closed
+ (BOOL)requestCameraAccessWithTitle:(NSString *)title completion:(void(^)(void))completion; // app setttings for camera closed
+ (BOOL)requestMicrophoneAccessWithTitle:(NSString *)title completion:(void(^)(void))completion; // app settings for microphone closed
+ (void)jumpAppSettings; // jump to app settings

@end

NS_ASSUME_NONNULL_END
