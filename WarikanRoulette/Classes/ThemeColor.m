//
//  ThemeColor.m
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/17.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "ThemeColor.h"

@implementation ThemeColor

+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)makeColor:(int)index type:(enum colorType)type
{
    NSArray *colorTable = @[
    //  @[@"BASE", @"VIEW", @"ROULETTE_BLACK", @"ROULETTE_RED", @"BUTTON", @"BUTTON_SHADOW"],
        @[@"F5F4E4", @"FBB963", @"65556E", @"F45673", @"51CDC8", @"34B7B1"],
        @[@"F3EFE6", @"747371", @"32313F", @"F06F4F", @"A9C5DA", @"85ADCB"],
        @[@"ECF0F1", @"2C3E50", @"2F2F2F", @"C0392B", @"2980B9", @"20638F"],
        @[@"F7F0D5", @"78A5A0", @"081E25", @"DD5137", @"48777B", @"35585B"],
        @[@"BFA687", @"3E201F", @"52A387", @"D8382B", @"EF4845", @"EB1A16"],
        @[@"FFFFDC", @"F2620F", @"143C8C", @"A62F14", @"F2AA2A", @"DC910D"],
        @[@"F0F3F4", @"50BAC3", @"282828", @"F37750", @"68CAD2", @"41BCC6"],
        @[@"F2CA99", @"BF6374", @"656573", @"A66073", @"788C69", @"5F6F53"],
        @[@"FFFFFF", @"C1A16E", @"333333", @"703542", @"6D99A7", @"557F8C"],
    ];
    
    static UIColor *color = nil;
    static NSString *hexString;
    
    hexString = [[colorTable objectAtIndex:index] objectAtIndex:type];
    color = [self colorFromHexCode:hexString];
    
    return color;
}

+ (NSString *)titleWithIndex:(int)index
{
    NSArray *title = @[@"Meet me halfway",
                       @"Peter Rabbit",
                       @"midnight blue",
                       @"lonelyhills",
                       @"vintage pop",
                       @"Orange Soda",
                       @"AssetAvenue  Anke",
                       @"Vintage Grandma",
                       @"Backsplash Ideas Site"];
    return [title objectAtIndex:index];
}

+ (UIColor *)colorWithType:(enum colorType)type
{
    return [self makeColor:[self getIndex] type:type];
}

+ (void)setIndex:(int)index
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:index forKey:@"ColorIndex"];
}

+ (int)getIndex
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return (int)[ud integerForKey:@"ColorIndex"];
}

@end
