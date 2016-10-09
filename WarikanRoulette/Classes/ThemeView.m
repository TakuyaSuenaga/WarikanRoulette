//
//  ThemeView.m
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/17.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "ThemeView.h"
#import "ThemeColor.h"
#import "SZFlatUI.h"

@implementation ThemeView

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
    int palletWidth = rect.size.width / 5;
    int palletHeight = rect.size.height;

    for (int i = 0; i < 5; i++) {
        UIView *pallet = [[UIView alloc] initWithFrame:CGRectMake(palletWidth * i, 0, palletWidth, palletHeight)];
        pallet.backgroundColor = [ThemeColor makeColor:self.index type:i];
        [self addSubview:pallet];
    }
    
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, rect.size.width-10, rect.size.height)];
//    title.backgroundColor = [UIColor clearColor];
//    title.font = [UIFont boldFlatFontOfSize:palletHeight/2];
//    title.textColor = [UIColor whiteColor];
//    title.text = [ThemeColor titleWithIndex:self.index];
//    [self addSubview:title];
    
    [self setClipsToBounds:YES];
    [[self layer] setCornerRadius:3.0f];
    [[self layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    [[self layer] setBorderWidth:2.0f];
}

- (void)initIndex
{
    self.index = [ThemeColor getIndex];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate ThemeViewDidTouched];
}

@end
