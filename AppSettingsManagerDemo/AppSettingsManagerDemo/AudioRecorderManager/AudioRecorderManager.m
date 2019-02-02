//
//  AudioRecorderManager.m
//  AppSettingsManagerDemo
//
//  Created by laizhijian on 2019/2/2.
//  Copyright © 2019 laizhijian. All rights reserved.
//

#import "AudioRecorderManager.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioRecorderManager ()<AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

@end

@implementation AudioRecorderManager

+ (instancetype)sharedInstance {
    static AudioRecorderManager *instance = nil;
    if (!instance) {
        instance = [[AudioRecorderManager alloc] init];
    }
    return instance;
}

- (void)setupAudioRecorder {
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
    
    NSArray *availableInputs = [[AVAudioSession sharedInstance] availableInputs];
    AVAudioSessionPortDescription *port = [availableInputs objectAtIndex:0];  //built in mic for your case
    NSError *portErr = nil;
    [session setPreferredInput:port error:&portErr];
    if (portErr) {
        NSLog(@"Error: %@", portErr);
    }
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
}

- (void)startRecording {
    if (player.playing) {
        [player stop];
    }
    if (!recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [recorder record];
    }
}

- (void)pause {
    if (player.playing) {
        [player stop];
    }
    
    if (recorder.recording) {
        [recorder pause];
    }
}

- (void)play {
    if (!recorder.recording) {
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        player.volume = 1;
        [player play];
    }
}

- (void)stop {
    [recorder stop];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

@end
