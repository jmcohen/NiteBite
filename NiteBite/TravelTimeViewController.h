//
//  TravelTimeViewController.h
//  NiteBite
//
//  Created by Jeremy Cohen on 1/31/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelTimeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

- (IBAction)increment:(id)sender;
- (IBAction)decrement:(id)sender;

@end
