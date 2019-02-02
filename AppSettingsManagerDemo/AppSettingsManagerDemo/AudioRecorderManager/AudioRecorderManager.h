//
//  AudioRecorderManager.h
//  AppSettingsManagerDemo
//
//  Created by laizhijian on 2019/2/2.
//  Copyright © 2019 laizhijian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioRecorderManager : NSObject

+ (instancetype)sharedInstance;
- (void)setupAudioRecorder;
- (void)startRecording;
- (void)play;
- (void)pause;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
