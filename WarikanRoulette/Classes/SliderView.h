//
//  SliderView.h
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/01.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SliderView;

@protocol SliderViewDelegate
- (void)SliderDidChange;
@end

@interface SliderView : UIView

@property (weak, nonatomic) id <SliderViewDelegate> delegate;

@property (nonatomic) int percent;

@end
