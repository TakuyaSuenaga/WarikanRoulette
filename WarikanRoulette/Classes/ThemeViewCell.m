//
//  ThemeViewCell.m
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/20.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "ThemeViewCell.h"
#import "SZFlatUI.h"

@implementation ThemeViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.inset = 15;
    self.backgroundColor = [SZFlatUI viewColor];
    self.titleLabel.font = [UIFont boldFlatFontOfSize:16];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += self.inset;
    frame.size.width -= 2 * self.inset;
    frame.origin.y += 2;
    frame.size.height -= 2 * 2;
    [self setClipsToBounds:YES];
    [[self layer] setCornerRadius:5.0f];

    [super setFrame:frame];
}

- (void)ThemeViewDidTouched
{
}

@end
