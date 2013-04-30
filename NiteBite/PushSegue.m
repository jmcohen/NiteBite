//
//  PushSegue.m
//  NiteBite
//
//  Created by Jeremy Cohen on 1/31/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "PushSegue.h"
#import <QuartzCore/QuartzCore.h>

@implementation PushSegue

- (void)perform
{    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    [sourceViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [sourceViewController.navigationController pushViewController:destinationController animated:NO];
}

@end
