//
//  ThemeColor.h
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/17.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NUMBER_OF_COLORSET 9

enum colorType {
    COLOR_TYPE_BASE = 0,
    COLOR_TYPE_VIEW,
    COLOR_TYPE_ROULETTE_BLACK,
    COLOR_TYPE_ROULETTE_RED,
    COLOR_TYPE_BUTTON,
    COLOR_TYPE_BUTTON_SHADOW,
};

@interface ThemeColor : UIColor

+ (UIColor *)makeColor:(int)index type:(enum colorType)type;
+ (NSString *)titleWithIndex:(int)index;
+ (UIColor *)colorWithType:(enum colorType)type;
+ (void)setIndex:(int)index;
+ (int)getIndex;

@end
