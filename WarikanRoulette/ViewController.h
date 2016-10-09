//
//  ViewController.h
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/06/30.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZAnimationView.h"
#import "SZFlatUI.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet SZAnimationView *paymentView;
@property (weak, nonatomic) IBOutlet UITextField *paymentTextField;

@property (weak, nonatomic) IBOutlet SZAnimationView *personsView;
@property (weak, nonatomic) IBOutlet UILabel *personsLabel;
@property (weak, nonatomic) IBOutlet UIStepper *personsStepper;

@property (weak, nonatomic) IBOutlet SZAnimationView *roundView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *roundSegment;

@property (weak, nonatomic) IBOutlet SZAnimationView *fractionView;
@property (weak, nonatomic) IBOutlet UILabel *fractionLabel;
@property (weak, nonatomic) IBOutlet FUISwitch *fractionSwitch;

@property (weak, nonatomic) IBOutlet SZAnimationView *highpriceView;
@property (weak, nonatomic) IBOutlet UILabel *highpriceLabel;
@property (weak, nonatomic) IBOutlet FUISwitch *highpriceSwitch;

@property (weak, nonatomic) IBOutlet SZAnimationView *themeView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;

@property (weak, nonatomic) IBOutlet SZAnimationView *goButtonView;
@property (weak, nonatomic) IBOutlet FUIButton *goButton;

- (IBAction)clickedGoButton:(id)sender;
- (IBAction)clickedPersonsStepper:(id)sender;
- (IBAction)clickedRoundSegment:(id)sender;

@end
