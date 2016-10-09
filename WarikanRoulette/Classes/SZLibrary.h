//
//  SZLibrary.h
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/01.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SZLibrary : NSObject

+ (NSString*)getPaymentText:(int)payment;
+ (int)getPaymentValue:(NSString*)text;
+ (void)wait:(float)time;
+ (void)readySound;
+ (void)playSound:(NSString*)file;
+ (void)playMoveSound;
+ (void)playButtonSound;
+ (void)playRotateSound;
+ (void)playHitSound;
+ (void)playValueSound;
+ (void)playSwitchSound;
+ (void)playMoneySound;

@end

@interface MyScreen : UIScreen

+ (BOOL)is3_5inch;

@end
