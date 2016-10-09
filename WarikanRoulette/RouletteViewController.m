//
//  RouletteViewController.m
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/06/30.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "RouletteViewController.h"
#import "SZLibrary.h"
#import "PaymentScrollView.h"
#import "AdManager.h"

@interface RouletteViewController () <SliderViewDelegate, RouletteViewDelegate>

@end

@implementation RouletteViewController
{
    int rouletteState;
    SZLayer *selectedLayer;
    PaymentScrollView *paymentScrollView;
    int rouletteIsFinished;
}

@synthesize payment, persons, round, onFraction, onHighPrice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [SZLibrary readySound];
    self.view.backgroundColor = [SZFlatUI baseColor];
    rouletteState = 0;
    rouletteIsFinished = 0;
    self.paymentLabel.text = [SZLibrary getPaymentText:payment];
    self.paymentLabel.font = [UIFont flatFontOfSize:20];
    self.personsLabel.text = [NSString stringWithFormat:@"%d", persons];
    self.personsLabel.font = [UIFont flatFontOfSize:20];
    self.sliderView.delegate  = self;
    self.sliderView.percent   = 50;
    self.roulette.delegate    = self;
    self.roulette.payment     = payment;
    self.roulette.persons     = persons;
    self.roulette.round       = round;
    self.roulette.onFraction  = onFraction;
    self.roulette.onHighPrice = onHighPrice;
    paymentScrollView = [PaymentScrollView makePaymentScrollViewWithFrame:self.sliderView.frame persons:persons];

    self.paymentView.backgroundColor = [SZFlatUI viewColor];
    self.personsView.backgroundColor = [SZFlatUI viewColor];
    
    [SZFlatUI makeBackButton:self.settingButton];
    [SZFlatUI makeReadyButton:self.rouletteButton];
    
    [self reloadRoulette];
}

- (void)reloadRoulette
{
    self.roulette.percent = self.sliderView.percent;
    
    [self.roulette drawRoulette];
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

    [self.paymentView        startAnimationWithType:CSAnimationTypeBounceDown delay:.1f];
    [self.personsView        startAnimationWithType:CSAnimationTypeBounceDown delay:.2f];
    [self.settingButtonView  startAnimationWithType:CSAnimationTypeBounceDown delay:.3f];
    [self.rouletteButtonView startAnimationWithType:CSAnimationTypeBounceUp   delay:.4f];
    [self.rouletteView       startAnimationWithType:CSAnimationTypeZoomOut    delay:.5f];
    [self.assistView         startAnimationWithType:CSAnimationTypeZoomOut    delay:.6f];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (IBAction)clickedSettingButton:(id)sender
{
    [SZLibrary playButtonSound];
    [self.roulette cancelRoulette];
    
    [paymentScrollView removeFromSuperview];
    
    [self.paymentView        startAnimationWithType:CSAnimationTypeFadeOut delay:.1f];
    [self.personsView        startAnimationWithType:CSAnimationTypeFadeOut delay:.2f];
    [self.settingButtonView  startAnimationWithType:CSAnimationTypeFadeOut delay:.3f];
    [self.rouletteButtonView startAnimationWithType:CSAnimationTypeFadeOut delay:.4f];
    [self.rouletteView       startAnimationWithType:CSAnimationTypeFadeOut delay:.5f];
    [self.assistView         startAnimationWithType:CSAnimationTypeFadeOut delay:.6f];
    
    [SZLibrary wait:1.2f];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)clickedRouletteButton:(id)sender
{
    [SZLibrary playButtonSound];
    
    switch (rouletteState) {
        case 0:
            if (self.sliderView) {
                [self.roulette removeFareLabel];
                [self.sliderView removeFromSuperview];
                self.sliderView = nil;
                [self.assistView addSubview:paymentScrollView];
            } else {
                [self startReadyAnimation];
                self.rouletteButton.enabled = NO;
                 if ([self.roulette readyRoulette] == FALSE) {
                    [SZFlatUI makeFinishButton:self.rouletteButton];
                    rouletteIsFinished = 2;
                    break;
                }
            }
            [SZFlatUI makeStartButton:self.rouletteButton];
            rouletteState = 1;
            break;
        case 1:
            if ([self.roulette startRoulette] == FALSE) {
                self.rouletteButton.enabled = NO;
            } else {
                [SZFlatUI makeStopButton:self.rouletteButton];
                rouletteState = 2;
            }
            break;
        case 2:
            self.rouletteButton.enabled = NO;
            [self.roulette stopRoulette];
            break;
    }
}

- (void)SliderDidChange
{
    [self reloadRoulette];
}

- (void)rotateRouletteDidStopped:(SZLayer *)layer
{
    selectedLayer = layer;
    [SZFlatUI makeReadyButton:self.rouletteButton];
    rouletteState = 0;
    self.rouletteButton.enabled = YES;
}

- (void)rotateRouletteDidFinished:(SZLayer *)layer
{
    selectedLayer = layer;
    [self startReadyAnimation];
}

- (void)startReadyAnimation
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        CAAnimation* animation = [selectedLayer animationForKey:@"myAnimation"];
        if (animation) {
            [paymentScrollView addContentViewWithColor:selectedLayer.originColor payment:selectedLayer.payment];
            [selectedLayer removeAnimationForKey:@"myAnimation"];   // 後始末
            [selectedLayer removeFromSuperlayer];
            if (rouletteIsFinished == 2) {
                [self.roulette getLastLayer];
                rouletteIsFinished--;
            } else if (rouletteIsFinished == 1) {
                
            } else {
                self.rouletteButton.enabled = YES;
            }
        }
    }];
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.duration = 0.3;
    animation.byValue = [NSNumber numberWithDouble:300.0];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [selectedLayer addAnimation:animation forKey:@"myAnimation"];
    
    [CATransaction commit];
}

@end
