//
//  TravelModeViewController.m
//  NiteBite
//
//  Created by Jeremy Cohen on 1/31/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "TravelModeViewController.h"
#import "AppDelegate.h"
#import "Settings.h"

@interface TravelModeViewController ()

@end

@implementation TravelModeViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)carPressed:(id)sender{
    ((AppDelegate *) [UIApplication sharedApplication].delegate).settings.travelMode = kCar;
    [self performSegueWithIdentifier:@"next" sender:self];
}

- (IBAction)footPressed:(id)sender{
    ((AppDelegate *) [UIApplication sharedApplication].delegate).settings.travelMode = kFoot;
    [self performSegueWithIdentifier:@"next" sender:self];

}

@end
