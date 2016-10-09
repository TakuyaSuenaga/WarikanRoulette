//
//  SZAnimationView.m
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/06/30.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "SZAnimationView.h"
#import "SZLibrary.h"

@implementation SZAnimationView

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
    [self setClipsToBounds:YES];
    [[self layer] setCornerRadius:5.0f];
}

- (void)startAnimationWithType:(CSAnimationType)type delay:(NSTimeInterval)delay
{
    self.duration = .5f;
    self.delay    = delay;
    self.type     = type;
    
    // Add your subviews into animationView
    // [animationView addSubview:<#(UIView *)#>]
    
    // Kick start the animation immediately
    [self startCanvasAnimation];
    
//    if (type == CSAnimationTypeFadeOut) {
//        
//    } else {
//        [self playSoundWithDelay:delay];
//    }
}

- (void)playSoundWithDelay:(float)delay
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SZLibrary wait:0.1f];
        [SZLibrary playSound:@"se_move"];
    });
}

@end
