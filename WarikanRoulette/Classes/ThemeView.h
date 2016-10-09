//
//  ThemeView.h
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/17.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThemeView;

@protocol ThemeViewDelegate
- (void)ThemeViewDidTouched;
@end

@interface ThemeView : UIView

@property (weak, nonatomic) id <ThemeViewDelegate> delegate;
@property (nonatomic) int index;

- (void)initIndex;

@end
