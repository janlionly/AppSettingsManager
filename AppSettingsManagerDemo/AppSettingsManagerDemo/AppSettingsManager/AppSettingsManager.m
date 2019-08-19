//
//  AppSettingsManager.m
//  JLUIKit
//
//  Created by laizhijian on 2019/1/11.
//  Copyright © 2019 janlionly. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/PHPhotoLibrary.h>
#import "UIWindow+visibleViewController.h"
#import "AppSettingsManager.h"

@implementation AppSettingsManager

+ (void)presentAlertWithMessage:(NSString *)message {
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Need to Authorized", @"title for authorized") message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertCtrl addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Go", @"jump to app settings") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }]];
    [alertCtrl addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"do nothing") style:UIAlertActionStyleCancel handler:nil]];
    [[UIApplication sharedApplication].keyWindow.visibleViewController presentViewController:alertCtrl animated:YES completion:nil];
}

+ (void)jumpAppSettings {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

+ (BOOL)requestNotificationAccessWithTitle:(NSString *)title shouldAlert:(BOOL)shouldAlert completion:(void(^)(void))completion {
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIRemoteNotificationTypeNone) {
        if (shouldAlert) {
            [self presentAlertWithMessage:NSLocalizedString(title, @"open notification alert title")];
        }
        return YES;
    }
    if (completion) { completion(); }
    return NO;
}

+ (BOOL)requestCameraAccessWithTitle:(NSString *)title completion:(void(^)(void))completion {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusAuthorized:
            if (completion) completion();
            return YES;
        case AVAuthorizationStatusDenied:
            [self presentAlertWithMessage:NSLocalizedString(title, @"open camera alert title")];
            return NO;
        case AVAuthorizationStatusRestricted:
            return NO;
        case AVAuthorizationStatusNotDetermined:
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted && completion) completion();
            }];
            return YES;
    }
}

+ (BOOL)requestPhotoAlbumAccessWithTitle:(NSString *)title completion:(void(^)(void))completion {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusAuthorized:
            if (completion) completion();
            return YES;
        case PHAuthorizationStatusDenied:
            [self presentAlertWithMessage:NSLocalizedString(title, @"open photo album alert title")];
            return NO;
        case PHAuthorizationStatusRestricted:
            return NO;
        case PHAuthorizationStatusNotDetermined:
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized && completion) {
                    completion();
                }
            }];
            return YES;
    }
}

+ (BOOL)requestMicrophoneAccessWithTitle:(NSString *)title completion:(void (^)(void))completion {
    __block BOOL isOpen = NO;
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (granted) {
            if (completion) { completion(); }
            isOpen = YES;
        }
        else {
            [self presentAlertWithMessage:NSLocalizedString(title, @"open microphone alert title")];
            isOpen = NO;
        }
    }];
    return isOpen;
}

@end
