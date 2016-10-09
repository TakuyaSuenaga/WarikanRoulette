//
//  SZFlatUI.h
//  WatchDogTimer
//
//  Created by Takuya Suenaga on 2014/06/02.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlatUIKit.h"

@interface SZFlatUI : NSObject

+ (void)makeNormalButton:(FUIButton*)fButton WithTitle:(NSString*)title;
+ (void)makeGoButton:(FUIButton*)fButton;
+ (void)makeReadyButton:(FUIButton*)fButton;
+ (void)makeStartButton:(FUIButton*)fButton;
+ (void)makeStopButton:(FUIButton*)fButton;
+ (void)makeFinishButton:(FUIButton*)fButton;
+ (void)makeBackButton:(FUIButton*)fButton;
+ (void)makeCancelButton:(FUIButton*)fButton WithTitle:(NSString*)title;
+ (void)makeCancelButton:(FUIButton*)fButton WithImage:(NSString*)imageName;
+ (FUISwitch *)makeSwitch;
+ (FUISwitch *)makeSwitch:(FUISwitch*)fSwitch;
+ (void)makeNavigationBar:(UINavigationBar*)navigationBar;
+ (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message;
+ (void)makeAlertView:(FUIAlertView*)alertView;
+ (UILabel*)makeLabelWithFrame:(CGRect)rect text:(NSString*)text size:(CGFloat)size;
+ (FUISegmentedControl*)makeSegmentedControl;
+ (void)makeStepper:(UIStepper*)stepper;

+ (UIColor *)baseColor;
+ (UIColor *)viewColor;
+ (UIColor *)rouletteBlackColor;
+ (UIColor *)rouletteRedColor;
+ (UIColor *)buttonColor;
+ (UIColor *)buttonShadowColor;
+ (void)setColorIndex:(int)index;

@end
