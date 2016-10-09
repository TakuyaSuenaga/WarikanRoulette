//
//  ViewController.m
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/06/30.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "ViewController.h"
#import "RouletteViewController.h"
#import "SZLibrary.h"
#import "AdManager.h"
#import "ThemeView.h"

@interface ViewController () <UITextFieldDelegate, ThemeViewDelegate>

@end

@implementation ViewController
{
    ThemeView *theme;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [SZLibrary readySound];

    self.paymentTextField.font = [UIFont flatFontOfSize:40];
    self.personsLabel.font = [UIFont flatFontOfSize:40];
    self.roundSegment.selectedSegmentIndex = 1;
    [self.roundSegment  setTitleTextAttributes:
            [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"mplus-1c-regular" size:15]
                                        forKey:NSFontAttributeName]
                                      forState:UIControlStateNormal];
    [SZFlatUI makeSwitch:self.fractionSwitch];
    self.fractionSwitch.on = YES;
    [self.fractionSwitch addTarget:self action:@selector(clickedSwitch:) forControlEvents:UIControlEventValueChanged];
    [SZFlatUI makeSwitch:self.highpriceSwitch];
    self.highpriceSwitch.on = NO;
    [self.highpriceSwitch addTarget:self action:@selector(clickedSwitch:) forControlEvents:UIControlEventValueChanged];
    [SZFlatUI makeNormalButton:self.goButton WithTitle:@"GO !"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view addSubview:[AdManager shardAdBannerView]];

    self.view.backgroundColor = [SZFlatUI baseColor];
    self.paymentView.backgroundColor = [SZFlatUI viewColor];
    self.personsView.backgroundColor = [SZFlatUI viewColor];
    self.roundSegment.tintColor = [SZFlatUI viewColor];
    self.fractionLabel.textColor = [SZFlatUI viewColor];
    self.highpriceLabel.textColor = [SZFlatUI viewColor];
    self.themeLabel.textColor = [SZFlatUI viewColor];
    [SZFlatUI makeSwitch:self.fractionSwitch];
    [SZFlatUI makeSwitch:self.highpriceSwitch];
    [SZFlatUI makeGoButton:self.goButton];
   
    
    [theme removeFromSuperview];
    theme = [[ThemeView alloc] initWithFrame:CGRectMake(80, 5, 150, 30)];
    [theme initIndex];
    theme.delegate = self;
    [self.themeView addSubview:theme];
    
    self.paymentView.alpha   = 1.0f;
    self.personsView.alpha   = 1.0f;
    self.roundView.alpha     = 1.0f;
    self.fractionView.alpha  = 1.0f;
    self.highpriceView.alpha = 1.0f;
    self.themeView.alpha     = 1.0f;
    self.goButtonView.alpha  = 1.0f;
    
    [self.paymentView   startAnimationWithType:CSAnimationTypeBounceLeft delay:.1f];
    [self.personsView   startAnimationWithType:CSAnimationTypeBounceLeft delay:.2f];
    [self.roundView     startAnimationWithType:CSAnimationTypeBounceLeft delay:.3f];
    [self.fractionView  startAnimationWithType:CSAnimationTypeBounceLeft delay:.4f];
    [self.highpriceView startAnimationWithType:CSAnimationTypeBounceLeft delay:.5f];
    [self.themeView     startAnimationWithType:CSAnimationTypeBounceLeft delay:.6f];
    [self.goButtonView  startAnimationWithType:CSAnimationTypeBounceUp   delay:.7f];
}

- (IBAction)clickedGoButton:(id)sender
{
    [SZLibrary playButtonSound];
    
    if ([SZLibrary getPaymentValue:self.paymentTextField.text] < [self.personsLabel.text intValue] * [self getRoundValue]) {
        [SZFlatUI showAlertViewWithTitle:@"" message:@"金額・人数・まるめを\n確認してください"];
        return;
    }
    
    [self.paymentView   startAnimationWithType:CSAnimationTypeFadeOut delay:.1f];
    [self.personsView   startAnimationWithType:CSAnimationTypeFadeOut delay:.2f];
    [self.roundView     startAnimationWithType:CSAnimationTypeFadeOut delay:.3f];
    [self.fractionView  startAnimationWithType:CSAnimationTypeFadeOut delay:.4f];
    [self.highpriceView startAnimationWithType:CSAnimationTypeFadeOut delay:.5f];
    [self.themeView     startAnimationWithType:CSAnimationTypeFadeOut delay:.6f];
    [self.goButtonView  startAnimationWithType:CSAnimationTypeFadeOut delay:.7f];

    [SZLibrary wait:1.2f];
    [self performSegueWithIdentifier:@"showRouletteView" sender:self];
}

- (void)ThemeViewDidTouched
{
    [SZLibrary playButtonSound];
    
    [self.paymentView   startAnimationWithType:CSAnimationTypeFadeOut delay:.1f];
    [self.personsView   startAnimationWithType:CSAnimationTypeFadeOut delay:.2f];
    [self.roundView     startAnimationWithType:CSAnimationTypeFadeOut delay:.3f];
    [self.fractionView  startAnimationWithType:CSAnimationTypeFadeOut delay:.4f];
    [self.highpriceView startAnimationWithType:CSAnimationTypeFadeOut delay:.5f];
    [self.themeView     startAnimationWithType:CSAnimationTypeFadeOut delay:.6f];
    [self.goButtonView  startAnimationWithType:CSAnimationTypeFadeOut delay:.7f];
    
    [SZLibrary wait:1.2f];
    [self performSegueWithIdentifier:@"showThemeView" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ( [[segue identifier] isEqualToString:@"showRouletteView"] ) {
        RouletteViewController *vc = [segue destinationViewController];
        vc.payment = [SZLibrary getPaymentValue:self.paymentTextField.text];
        vc.persons = [self.personsLabel.text intValue];
        vc.round   = [self getRoundValue];
        vc.onFraction = self.fractionSwitch.on;
        vc.onHighPrice = self.highpriceSwitch.on;
    }
}

- (IBAction)clickedPersonsStepper:(id)sender
{
    [SZLibrary playValueSound];
    self.personsLabel.text = [NSString stringWithFormat:@"%d", (int)self.personsStepper.value];
}

- (IBAction)clickedRoundSegment:(id)sender {
    [SZLibrary playValueSound];
}

- (IBAction)clickedSwitch:(id)sender
{
    [SZLibrary playSwitchSound];
}

- (int)getRoundValue
{
    NSArray *roundArray = @[@100, @1000, @10000];
    return [[roundArray objectAtIndex:self.roundSegment.selectedSegmentIndex] intValue];
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [SZLibrary playValueSound];
    self.paymentTextField.text = @"";
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *str = [textField.text mutableCopy];
    [str replaceCharactersInRange:range withString:string];
    int maxInputLength = 6;
    if ([str length] > maxInputLength) {
        return NO;
    }

    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField*)textField
{
    NSMutableString *str = [textField.text mutableCopy];
    textField.text = [SZLibrary getPaymentText:[str intValue]];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.paymentTextField resignFirstResponder];
}

@end
