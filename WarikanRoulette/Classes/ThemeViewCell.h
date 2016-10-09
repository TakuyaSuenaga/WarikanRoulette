//
//  ThemeViewCell.h
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/20.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeView.h"

@interface ThemeViewCell : UITableViewCell <ThemeViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet ThemeView *themeView;

@property (nonatomic) CGFloat inset;
@property (nonatomic) int index;
@property (nonatomic, copy) NSString *title;

@end
