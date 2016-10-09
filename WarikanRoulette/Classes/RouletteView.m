//
//  RouletteView.m
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/01.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "RouletteView.h"
#import "SZLibrary.h"
#import "SZFlatUI.h"
#import <QuartzCore/QuartzCore.h>

@implementation RouletteView
{
    BOOL isDrawing;
    UIView *chart;
    NSMutableArray *slArray;
    NSMutableArray *fareLabelArray;
    UILabel *maskLabel;
}

@synthesize payment, persons, round, onFraction, onHighPrice, percent;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawRoulette
{
    if (isDrawing == YES) {
        return;
    }
    isDrawing = YES;
    
    [chart removeFromSuperview];
    chart = [[UIView alloc] initWithFrame:self.frame];
    chart.backgroundColor = [UIColor blackColor];
    chart.layer.cornerRadius = self.frame.size.width / 2;
    [[chart layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    [[chart layer] setBorderWidth:2.0f];
    [self addSubview:chart];
    
    NSMutableArray *labelRatios = [[NSMutableArray alloc] init];
    float total = 0;
    int range = (percent - 50) * 2;
    for (int i = 0; i < persons - onFraction; i++) {
        float ratio = abs(percent - ((range / (persons - onFraction)) * i));
        [labelRatios addObject:[NSNumber numberWithFloat:ratio]];
        total = total + ratio;
    }
    
    int remainder = payment % round;
    
    if (payment < round * (persons - onFraction)) {
        isDrawing = NO;
        return;
    }
    
    int eachTotal = 0;
    NSMutableArray *eachAmounts = [[NSMutableArray alloc] init];
    if (onHighPrice == YES) {
        int most = 0;
        for (int i = 1; ; i++) {
            if ((persons - onFraction) * round * i > payment) {
                break;
            }
            most = i;
        }
        int equality = most * percent / 100;
        if (equality == 0) {
            equality = 1;
        }
        for (int i = 0; i < labelRatios.count; i++) {
            if (i == 0) {
                [eachAmounts addObject:[NSNumber numberWithInt:payment - remainder - (int)(round * equality * (labelRatios.count-1))]];
            } else {
                [eachAmounts addObject:[NSNumber numberWithInt:round * equality]];
            }
        }
    } else {
        for (NSNumber *num in labelRatios) {
            float ratio = [num floatValue];
            ratio = ratio / total * (payment - remainder);
            int eachAmount;
            if (ratio < round) {
                eachAmount = round;
            } else {
                eachAmount = (int)(ratio / round) * round;
            }
            [eachAmounts addObject:[NSNumber numberWithInt:eachAmount]];
            eachTotal = eachTotal + eachAmount;
        }
        while (eachTotal < payment - remainder) {
            int i = (percent < 50)? (int)labelRatios.count - 1 : 0;
            for (NSNumber *num in labelRatios) {
                float ratio = [num floatValue];
                ratio = [[labelRatios objectAtIndex:i] floatValue];
                ratio = ratio / total * (payment - eachTotal - remainder);
                int eachAmount;
                if (ratio < round) {
                    eachAmount = round;
                } else {
                    eachAmount = (int)(ratio / round) * round;
                }
                [eachAmounts replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:[[eachAmounts objectAtIndex:i] intValue] + eachAmount]];
                eachTotal = eachTotal + eachAmount;
                if (eachTotal >= payment - remainder) {
                    break;
                }
                (percent < 50)? i--:i++;
            }
        }
        if (eachTotal > payment - remainder) {
            int index = (percent < 50)? (int)eachAmounts.count - 1:0;
            [eachAmounts replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:[[eachAmounts objectAtIndex:index] intValue] - (eachTotal - payment) - remainder]];
        }
    }
    if (onFraction) {
        [eachAmounts addObject:[NSNumber numberWithInt:remainder]];
    } else {
        int index = (percent < 50)? (int)eachAmounts.count - 1:0;
        [eachAmounts replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:[[eachAmounts objectAtIndex:index] intValue] + remainder]];
    }
    
    NSMutableArray *chartRatios = [[NSMutableArray alloc] init];
    for (NSNumber *num in eachAmounts) {
        float ratio = [num intValue];
        if (payment != 0) {
            ratio = ratio / payment * 2 * M_PI;
        } else {
            ratio = M_PI_2;
        }
        [chartRatios addObject:[NSNumber numberWithFloat:ratio]];
    }
    
    float start = 0;
    int i = 0;
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    slArray = [[NSMutableArray alloc] init];
    for (NSNumber *num in chartRatios) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        float end = start + [num floatValue];
        [path moveToPoint:center];
        [path addArcWithCenter:center radius:center.x startAngle:start - M_PI_2 endAngle:end - M_PI_2 clockwise:YES];
        SZLayer *sl = [[SZLayer alloc] init];
        sl.path = path.CGPath;
        sl.originColor = (i % 2)? [SZFlatUI rouletteRedColor] : [SZFlatUI rouletteBlackColor];
        sl.payment = [[eachAmounts objectAtIndex:i] intValue];
        sl.fillColor = sl.originColor.CGColor;
        sl.strokeColor = [UIColor whiteColor].CGColor;
        sl.lineWidth = 2;
        sl.shouldRasterize = YES;
        [slArray addObject:sl];
        [chart.layer addSublayer:sl];
        
        start = end;
        i++;
    }
    
    start = 0;
    i = 0;
    fareLabelArray = [NSMutableArray new];
    for (NSNumber *num in chartRatios) {
        float end = start + [num floatValue];
        UILabel *fareLabel = [[UILabel alloc] init];
        NSNumber *ratio = [eachAmounts objectAtIndex:i];
        fareLabel.text = [NSString stringWithFormat:@"%d", [ratio intValue]];
        fareLabel.font = [UIFont boldFlatFontOfSize:14];
        fareLabel.textColor = [UIColor whiteColor];
        fareLabel.backgroundColor = [UIColor clearColor];
        [fareLabel sizeToFit];
        float th = start + (end - start)/2 - M_PI_2;
        int radios = (i % 2)? center.x - 30 : center.x - 30;
        fareLabel.center = CGPointMake(center.x + radios * cos(th), center.y + radios * sin(th));
        [chart addSubview:fareLabel];
        [fareLabelArray addObject:fareLabel];
        
        start = end;
        i++;
    }
    
    maskLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, center.x * 1.2, center.y * 1.2)];
    maskLabel.clipsToBounds = YES;
    maskLabel.layer.cornerRadius = center.x * 0.6;
    [[maskLabel layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    [[maskLabel layer] setBorderWidth:2.0f];
    maskLabel.center = center;
    maskLabel.backgroundColor = [SZFlatUI baseColor];
    maskLabel.font = [UIFont boldFlatFontOfSize:25];
    maskLabel.textAlignment = NSTextAlignmentCenter;
    [chart addSubview:maskLabel];
        
    isDrawing = NO;
}

int lightPosition;
int rotate;

- (BOOL)startRoulette
{
    if (slArray.count < 2) {
        return FALSE;
    }
    
    lightPosition = -1;
    rotate = 0;
    [self rotateRoulette];

    return TRUE;
}

- (void)stopRoulette
{
    rotate = 1;
}

- (void)cancelRoulette
{
    rotate = 2;
}

- (BOOL)readyRoulette
{
    maskLabel.text = @"";
    
    if (slArray.count < 2) {
        return FALSE;
    }
    
    for (SZLayer *sl in slArray) {
        sl.fillColor = sl.originColor.CGColor;
    }
    
    return TRUE;
}

- (void)removeFareLabel
{
    if (fareLabelArray) {
        for (UILabel *label in fareLabelArray) {
            [label removeFromSuperview];
        }
        fareLabelArray = nil;
    }
}

- (void)getLastLayer
{
    [self.delegate rotateRouletteDidFinished:[slArray lastObject]];
}

- (void)rotateRoulette
{
    dispatch_async(dispatch_get_main_queue(), ^{
        while ( 1 ) {
            [self moveLight:1];
            [SZLibrary wait:0.1];
            if (rotate == 1) {
                int count = arc4random() % persons + persons * 2;
                [self moveLight:1];
                while (count > 0) {
                    [SZLibrary wait:(float)0.7/count+0.1];
                    count--;
                    [self moveLight:count];
                    if (rotate == 2) {
                        break;
                    }
                }
                if (rotate == 2) {
                    break;
                }
                SZLayer *sl = [slArray objectAtIndex:lightPosition];
                for (int i = 0; i < 10; i++) {
                    sl.fillColor = (i % 2)? sl.originColor.CGColor : [UIColor concreteColor].CGColor;
                    [SZLibrary playHitSound];
                    [SZLibrary wait:0.05];
                }
                [slArray removeObjectAtIndex:lightPosition];
                [self.delegate rotateRouletteDidStopped:sl];
                break;
            }
            if (rotate == 2) {
                break;
            }
        }
    });
}

- (void)moveLight:(int)onSound
{
    lightPosition++;
    if (lightPosition >= slArray.count)
    {
        lightPosition = 0;
    }
    int i = 0;
    for (SZLayer *sl in slArray) {
        if (i == lightPosition) {
            sl.fillColor = sl.originColor.CGColor;
            maskLabel.text = [NSString stringWithFormat:@"%d", sl.payment];
            maskLabel.textColor = sl.originColor;
        } else {
            sl.fillColor = [UIColor concreteColor].CGColor;
        }
        i++;
    }
    if (onSound) {
        [SZLibrary playRotateSound];
    }
}

@end


@implementation ArcView

@synthesize startAngle, endAngle, fillColor;

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [fillColor setFill];
    
    CGPoint origin = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGContextMoveToPoint(context, origin.x, origin.y);
    CGContextAddArc(context, origin.x, origin.y, origin.x, startAngle, endAngle, NO);
    CGContextDrawPath(context, kCGPathFill);
}

- (void)changeFillColor
{
    self.fillColor = fillColor;
}

@end


@implementation SZLayer

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
