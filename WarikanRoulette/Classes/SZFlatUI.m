//
//  SZFlatUI.m
//  WatchDogTimer
//
//  Created by Takuya Suenaga on 2014/06/02.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "SZFlatUI.h"
#import "ThemeColor.h"

#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SZFlatUI ()

@end

@implementation SZFlatUI

+ (void)makeNormalButton:(FUIButton*)fButton WithTitle:(NSString*)title
{
    [self makeButton:fButton WithTitle:title buttonColor:[UIColor turquoiseColor] shadowColor:[UIColor greenSeaColor]];
}

+ (void)makeGoButton:(FUIButton*)fButton
{
    [self makeButton:fButton WithTitle:@"GO !" buttonColor:[self buttonColor] shadowColor:[self buttonShadowColor]];
}

+ (void)makeReadyButton:(FUIButton*)fButton
{
    [self makeButton:fButton WithTitle:@"READY" buttonColor:[UIColor carrotColor] shadowColor:[UIColor pumpkinColor]];
}

+ (void)makeStartButton:(FUIButton*)fButton
{
    [self makeButton:fButton WithTitle:@"START" buttonColor:[self buttonColor] shadowColor:[self buttonShadowColor]];
}

+ (void)makeStopButton:(FUIButton*)fButton
{
    [self makeButton:fButton WithTitle:@"STOP" buttonColor:[UIColor alizarinColor] shadowColor:[UIColor pomegranateColor]];
}

+ (void)makeFinishButton:(FUIButton*)fButton
{
    [self makeButton:fButton WithTitle:@"FINISH" buttonColor:[UIColor concreteColor] shadowColor:[UIColor asbestosColor]];
}

+ (void)makeBackButton:(FUIButton*)fButton
{
    [fButton setTitle:@"もどる" forState:UIControlStateNormal];
    fButton.buttonColor = [self buttonColor];
    fButton.shadowColor = [self buttonShadowColor];
    fButton.shadowHeight = 3.0f;
    fButton.cornerRadius = 6.0f;
    fButton.titleLabel.font = [UIFont fontWithName:@"mplus-1c-regular" size:16];
    [fButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

+ (void)makeCancelButton:(FUIButton*)fButton WithTitle:(NSString*)title
{
    [self makeButton:fButton WithTitle:title buttonColor:[UIColor alizarinColor] shadowColor:[UIColor pomegranateColor]];
}

+ (void)makeButton:(FUIButton*)fButton WithTitle:(NSString*)title buttonColor:(UIColor*)buttonColor shadowColor:(UIColor*)shadowColor
{
    [fButton setTitle:title forState:UIControlStateNormal];
    fButton.buttonColor = buttonColor;
    fButton.shadowColor = shadowColor;
    fButton.shadowHeight = 3.0f;
    fButton.cornerRadius = 6.0f;
    fButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [fButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [fButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

+ (void)makeCancelButton:(FUIButton*)fButton WithImage:(NSString*)imageName
{
    [fButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    fButton.buttonColor = [UIColor alizarinColor];
    fButton.shadowColor = [UIColor pomegranateColor];
    fButton.shadowHeight = 3.0f;
    fButton.cornerRadius = 6.0f;
    fButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [fButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [fButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

+ (FUISwitch *)makeSwitch
{
    FUISwitch *fSwitch = [[FUISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    fSwitch.onColor = [UIColor turquoiseColor];
    fSwitch.offColor = [UIColor cloudsColor];
    fSwitch.onBackgroundColor = [UIColor midnightBlueColor];
    fSwitch.offBackgroundColor = [UIColor silverColor];
    fSwitch.offLabel.font = [UIFont boldFlatFontOfSize:14];
    fSwitch.onLabel.font = [UIFont boldFlatFontOfSize:14];
    return fSwitch;
}

+ (FUISwitch *)makeSwitch:(FUISwitch*)fSwitch
{
    fSwitch.onColor = [UIColor cloudsColor];
    fSwitch.offColor = [UIColor cloudsColor];
    fSwitch.onBackgroundColor = [self viewColor];
    fSwitch.offBackgroundColor = [UIColor silverColor];
    fSwitch.offLabel.font = [UIFont boldFlatFontOfSize:14];
    fSwitch.onLabel.font = [UIFont boldFlatFontOfSize:14];
    return fSwitch;
}

+ (void)makeNavigationBar:(UINavigationBar*)navigationBar
{
    [navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
}

+ (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message
{
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:title
                                                          message:message
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil, nil];
    [self makeAlertView:alertView];
    [alertView show];
}

+ (void)makeAlertView:(FUIAlertView*)alertView
{
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont fontWithName:@"mplus-1c-regular" size:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont fontWithName:@"mplus-1c-regular" size:20];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
}

+ (UILabel*)makeLabelWithFrame:(CGRect)rect text:(NSString*)text size:(CGFloat)size
{
    UILabel *fLabel = [[UILabel alloc] initWithFrame:rect];
    fLabel.font = [UIFont flatFontOfSize:size];
    fLabel.text = text;
    return fLabel;
}

+ (FUISegmentedControl*)makeSegmentedControl
{
    NSArray *items = @[@"˚C", @"˚F"];
    FUISegmentedControl *flatSegmentedControl = [[FUISegmentedControl alloc] initWithItems:items];
    [flatSegmentedControl setFrame:CGRectMake(0, 0, 70, 30)];
    flatSegmentedControl.selectedFont = [UIFont boldFlatFontOfSize:16];
    flatSegmentedControl.selectedFontColor = [UIColor cloudsColor];
    flatSegmentedControl.deselectedFont = [UIFont flatFontOfSize:16];
    flatSegmentedControl.deselectedFontColor = [UIColor cloudsColor];
    flatSegmentedControl.selectedColor = [UIColor midnightBlueColor];
    flatSegmentedControl.deselectedColor = [UIColor silverColor];
    flatSegmentedControl.disabledColor = [UIColor silverColor];
    flatSegmentedControl.dividerColor = [UIColor silverColor];
    flatSegmentedControl.cornerRadius = 5.0;
    
    return flatSegmentedControl;
}

+ (void)makeStepper:(UIStepper*)stepper
{
    [stepper configureFlatStepperWithColor:UIColorHex(0x51CDC8)
                          highlightedColor:UIColorHex(0x51CDC8)
                             disabledColor:UIColorHex(0x51CDC8)
                                 iconColor:UIColorHex(0x51CDC8)];
}

+ (UIColor *)baseColor
{
    return [ThemeColor colorWithType:COLOR_TYPE_BASE];
}

+ (UIColor *)viewColor
{
    return [ThemeColor colorWithType:COLOR_TYPE_VIEW];
}

+ (UIColor *)rouletteBlackColor
{
    return [ThemeColor colorWithType:COLOR_TYPE_ROULETTE_BLACK];
}

+ (UIColor *)rouletteRedColor
{
    return [ThemeColor colorWithType:COLOR_TYPE_ROULETTE_RED];
}

+ (UIColor *)buttonColor
{
    return [ThemeColor colorWithType:COLOR_TYPE_BUTTON];
}

+ (UIColor *)buttonShadowColor
{
    return [ThemeColor colorWithType:COLOR_TYPE_BUTTON_SHADOW];
}

+ (void)setColorIndex:(int)index
{
    [ThemeColor setIndex:index];
}

@end
