//
//  SZLibrary.m
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/01.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "SZLibrary.h"
#import <AVFoundation/AVFoundation.h>

@implementation SZLibrary

AVAudioPlayer *audio;
AVAudioPlayer *audioMove;
AVAudioPlayer *audioButton;
AVAudioPlayer *audioRotate;
AVAudioPlayer *audioHit;
AVAudioPlayer *audioValue;
AVAudioPlayer *audioSwitch;
AVAudioPlayer *audioMoney;

+ (NSString*)getPaymentText:(int)payment
{
    NSNumber *number = [NSNumber numberWithInt:payment];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@",###"];
    
    NSString *numberStr = [formatter stringForObjectValue:number];
    return numberStr;
}

+ (int)getPaymentValue:(NSString*)text
{
    NSString *valueText = [text stringByReplacingOccurrencesOfString:@"," withString:@""];
    return [valueText intValue];
}

+ (void)wait:(float)time
{
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

+ (void)readySound
{
    audioMove   = [self initAudio:@"se_move"];
    audioButton = [self initAudio:@"se_button"];
    audioRotate = [self initAudio:@"se_rotate"];
    audioHit    = [self initAudio:@"se_hit"];
    audioValue  = [self initAudio:@"se_value"];
    audioSwitch = [self initAudio:@"se_switch"];
    audioMoney  = [self initAudio:@"se_money"];

    [audioMove   prepareToPlay];
    [audioButton prepareToPlay];
    [audioRotate prepareToPlay];
    [audioHit    prepareToPlay];
    [audioValue  prepareToPlay];
    [audioSwitch prepareToPlay];
    [audioMoney  prepareToPlay];
}

+ (void)playSound:(NSString*)file
{
    audio = [self initAudio:file];
    [audio play];
}

+ (AVAudioPlayer*)initAudio:(NSString*)file
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:file ofType:@"mp3"];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSError *error = nil;
    return [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
}

+ (void)playMoveSound
{
    audioMove.currentTime = 0;
    [audioMove play];
}

+ (void)playButtonSound
{
    audioButton.currentTime = 0;
    [audioButton play];
}

+ (void)playRotateSound
{
    audioRotate.currentTime = 0;
    [audioRotate play];
}

+ (void)playHitSound
{
    audioHit.currentTime = 0;
    [audioHit play];
}

+ (void)playValueSound
{
    audioValue.currentTime = 0;
    [audioValue play];
}

+ (void)playSwitchSound
{
    audioSwitch.currentTime = 0;
    [audioSwitch play];
}

+ (void)playMoneySound
{
    audioMoney.currentTime = 0;
    [audioMoney play];
}

@end

#pragma mark - Judge iPhone Size

@implementation MyScreen

+ (BOOL)is3_5inch
{
    CGRect screenSize = [self mainScreen].bounds;
    if (screenSize.size.height <= 480) {
        return TRUE;
    } else {
        return FALSE;
    }
}

@end

