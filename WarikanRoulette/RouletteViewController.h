//
//  RouletteViewController.h
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/06/30.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZAnimationView.h"
#import "SZFlatUI.h"
#import "RouletteView.h"
#import "SliderView.h"

@interface RouletteViewController : UIViewController

@property (nonatomic) int payment;
@property (nonatomic) int persons;
@property (nonatomic) int round;
@property (nonatomic) BOOL onFraction;
@property (nonatomic) BOOL onHighPrice;

@property (weak, nonatomic) IBOutlet SZAnimationView *paymentView;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet SZAnimationView *personsView;
@property (weak, nonatomic) IBOutlet UILabel *personsLabel;
@property (weak, nonatomic) IBOutlet SZAnimationView *settingButtonView;
@property (weak, nonatomic) IBOutlet FUIButton *settingButton;
@property (weak, nonatomic) IBOutlet SZAnimationView *rouletteView;
@property (weak, nonatomic) IBOutlet RouletteView *roulette;
@property (weak, nonatomic) IBOutlet SZAnimationView *assistView;
@property (weak, nonatomic) IBOutlet SliderView *sliderView;
@property (weak, nonatomic) IBOutlet SZAnimationView *rouletteButtonView;
@property (weak, nonatomic) IBOutlet FUIButton *rouletteButton;

- (IBAction)clickedSettingButton:(id)sender;
- (IBAction)clickedRouletteButton:(id)sender;

@end
