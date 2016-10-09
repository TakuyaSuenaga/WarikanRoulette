//
//  ThemeViewController.h
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/20.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZFlatUI.h"

@interface ThemeViewController : UIViewController

@property (weak, nonatomic) IBOutlet FUIButton *backButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)clickedBackButton:(id)sender;

@end
