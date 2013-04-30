//
//  WelcomeViewController.m
//  NiteBite
//
//  Created by Jeremy Cohen on 1/31/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

@synthesize titleLabel, subtitleLabel, startButton;

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
    titleLabel.font = [UIFont fontWithName:@"MavenProLight300-Regular" size:30];
    subtitleLabel.font = [UIFont fontWithName:@"MavenProLight300-Regular" size:20];
    startButton.titleLabel.font = [UIFont fontWithName:@"MavenProLight300-Regular" size:20];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
