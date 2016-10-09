//
//  SliderView.m
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/01.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "SliderView.h"
#import "SZFlatUI.h"
#import "SZLibrary.h"

@implementation SliderView
{
    UILabel *markerLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, 15, 280, 10)];
    bar.backgroundColor = [UIColor concreteColor];
    [self addSubview:bar];
    
    markerLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 40, 40)];
    markerLabel.text = [NSString stringWithFormat:@"%d", self.percent];
    markerLabel.font = [UIFont boldFlatFontOfSize:20];
    markerLabel.textAlignment = 1;
    markerLabel.textColor = [UIColor whiteColor];
    markerLabel.layer.cornerRadius = 20;
    markerLabel.layer.backgroundColor = [SZFlatUI buttonColor].CGColor;
    [self addSubview:markerLabel];
    
    markerLabel.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slide:)];
    [markerLabel addGestureRecognizer:pan];
}

- (void)slide:(UIPanGestureRecognizer*)gr
{
    CGPoint p = [gr locationInView:gr.view.superview];
    UILabel *marker = (UILabel*)gr.view;
    if (p.x < 20) {
        p.x = 20;
    } else if (p.x > 260) {
        p.x = 260;
    }
    marker.center = CGPointMake(p.x, marker.center.y);
    
    self.percent = 100 * (p.x - 20) / 240;
    marker.text = [NSString stringWithFormat:@"%d", self.percent];
    
    [self.delegate SliderDidChange];
}

@end
