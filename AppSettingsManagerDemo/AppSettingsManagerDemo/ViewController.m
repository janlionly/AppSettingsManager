//
//  ViewController.m
//  AppSettingsManagerDemo
//
//  Created by laizhijian on 2019/2/2.
//  Copyright © 2019 laizhijian. All rights reserved.
//

#import "ViewController.h"
#import "AppSettingsManager.h"
#import "LocalNotificationManager.h"
#import "AudioRecorderManager.h"

typedef NS_ENUM(NSInteger, TableViewRow) {
    TableViewRowNotification,
    TableViewRowPhotoAlbum,
    TableViewRowCamera,
    TableViewRowMicrophone
};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Access to privacy", @"");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == TableViewRowNotification) {
        [AppSettingsManager requestNotificationAccessWithTitle:@"My app want to visit your notification" shouldAlert:YES completion:^{
            // click and then let this app enter background to receive local notification
            [LocalNotificationManager registerLocalNotificationWithInterval:5 content:@"Time for Bed" key:@"LocalNotificationKey"];
        }];
    } else if (indexPath.row == TableViewRowPhotoAlbum) {
        [AppSettingsManager requestPhotoAlbumAccessWithTitle:@"My app want to visit your photo album" completion:^{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }];
        
    } else if (indexPath.row == TableViewRowCamera) {
        [AppSettingsManager requestCameraAccessWithTitle:@"My app want to visit your camera" completion:^{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }];
    } else if (indexPath.row == TableViewRowMicrophone) {
        [AppSettingsManager requestMicrophoneAccessWithTitle:@"My app want to visit your microphone" completion:^{
            AudioRecorderManager *manager = [AudioRecorderManager sharedInstance];
            [manager setupAudioRecorder];
            [manager startRecording];
        }];
    }
}

- (IBAction)playButtonTapped:(id)sender {
    [[AudioRecorderManager sharedInstance] play];
}

- (IBAction)pauseButtonTapped:(id)sender {
    [[AudioRecorderManager sharedInstance] pause];
}

- (IBAction)stopButtonTapped:(id)sender {
    [[AudioRecorderManager sharedInstance] stop];
}
@end
