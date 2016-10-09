//
//  PaymentScrollView.m
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/04.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "PaymentScrollView.h"
#import "SZAnimationView.h"
#import "SZFlatUI.h"
#import "SZLibrary.h"

@implementation PaymentScrollView

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
- (id)initPaymentScrollViewWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentsCount = 0;
    }
    return self;
}

+ (id)makePaymentScrollViewWithFrame:(CGRect)frame persons:(int)persons
{
    PaymentScrollView *view = [[PaymentScrollView alloc] initPaymentScrollViewWithFrame:frame];
    view.contentSize = CGSizeMake(frame.size.height * persons, frame.size.height);
    return view;
}

- (void)addContentViewWithColor:(UIColor*)color payment:(int)payment
{
    CGFloat side = self.contentSize.height;

    if (self.contentsCount > 6) {
        [self setContentOffset:CGPointMake(side * (self.contentsCount - 6), 0) animated:YES];
    }
    
    SZAnimationView *base = [[SZAnimationView alloc] initWithFrame:CGRectMake(side * self.contentsCount, 0, side, side)];
    base.backgroundColor = [UIColor clearColor];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, side, side)];
    [button setTitle:[NSString stringWithFormat:@"%d", payment] forState:UIControlStateNormal];
    if (button.titleLabel.text.length <= 5) {
        button.titleLabel.font = [UIFont boldFlatFontOfSize:12];
    } else {
        button.titleLabel.font = [UIFont boldFlatFontOfSize:10];
    }
    button.titleLabel.textColor = [UIColor whiteColor];
    [button setBackgroundColor:color];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 20.0f;
    button.layer.borderColor = UIColorHex(0xF5F4E4).CGColor;
    button.layer.borderWidth = 1.0;
    [button addTarget:self action:@selector(clickedContentView:) forControlEvents:UIControlEventTouchUpInside];
    
    [base addSubview:button];
    [self addSubview:base];
    [base startAnimationWithType:CSAnimationTypeFadeIn delay:0];
    
    self.contentsCount++;
}

- (IBAction)clickedContentView:(id)sender
{
    [SZLibrary playMoneySound];
    UIButton *button = (UIButton*)sender;
    [button setBackgroundColor:[UIColor concreteColor]];
}

@end
