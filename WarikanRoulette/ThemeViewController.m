//
//  ThemeViewController.m
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/20.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeColor.h"
#import "ThemeViewCell.h"
#import "SZLibrary.h"

@interface ThemeViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ThemeViewController

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
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [SZFlatUI baseColor];
    [SZFlatUI makeBackButton:self.backButton];
}

- (IBAction)clickedBackButton:(id)sender {
    [SZLibrary playButtonSound];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NUMBER_OF_COLORSET;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThemeViewCell *cell = (ThemeViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.themeView.index = (int)indexPath.row;
    cell.titleLabel.text = [ThemeColor titleWithIndex:(int)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SZLibrary playButtonSound];
    [SZFlatUI setColorIndex:(int)indexPath.row];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
