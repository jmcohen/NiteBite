//
//  TravelTimeViewController.m
//  NiteBite
//
//  Created by Jeremy Cohen on 1/31/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "TravelTimeViewController.h"
#import "AppDelegate.h"
#import "Settings.h"

@interface TravelTimeViewController ()

@end

@implementation TravelTimeViewController
@synthesize timeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) refreshTimeLabel {
    Settings *settings =  ((AppDelegate *) [UIApplication sharedApplication].delegate).settings;
    self.timeLabel.text = [NSString stringWithFormat:@"%d minutes", settings.travelTime];
}

- (void)viewDidLoad
{
    [self refreshTimeLabel];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)increment:(id)sender{
    Settings *settings =  ((AppDelegate *) [UIApplication sharedApplication].delegate).settings;
    settings.travelTime += 5;
    [self refreshTimeLabel];
}

- (IBAction)decrement:(id)sender{
    Settings *settings =  ((AppDelegate *) [UIApplication sharedApplication].delegate).settings;
    if (settings.travelTime > 5)
        settings.travelTime -= 5;
    [self refreshTimeLabel];
}

@end
