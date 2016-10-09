//
//  RouletteView.h
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/01.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZLayer : CAShapeLayer

@property (nonatomic) UIColor *originColor;
@property (nonatomic) int payment;

@end

@class RouletteView;

@protocol RouletteViewDelegate
- (void)rotateRouletteDidStopped:(SZLayer*)layer;
- (void)rotateRouletteDidFinished:(SZLayer*)layer;
@end

@interface RouletteView : UIView

@property (weak, nonatomic) id <RouletteViewDelegate> delegate;
@property (nonatomic) int payment;
@property (nonatomic) int persons;
@property (nonatomic) int round;
@property (nonatomic) BOOL onFraction;
@property (nonatomic) BOOL onHighPrice;
@property (nonatomic) int percent;

- (void)drawRoulette;
- (BOOL)startRoulette;
- (void)stopRoulette;
- (void)cancelRoulette;
- (BOOL)readyRoulette;
- (void)removeFareLabel;
- (void)getLastLayer;

@end


@interface ArcView : UIView

@property (nonatomic, assign) float startAngle;
@property (nonatomic, assign) float endAngle;
@property (nonatomic, strong) UIColor *fillColor;

- (void)changeFillColor;

@end
