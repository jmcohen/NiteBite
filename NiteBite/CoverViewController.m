//
//  CoverViewController.m
//  NiteBite
//
//  Created by Jeremy Cohen on 11/10/12.
//  Copyright (c) 2012 Jeremy Cohen. All rights reserved.
//

#import "CoverViewController.h"
#import "UIGestureRecognizer+Cancel.h"

@interface CoverViewController ()

@end

@implementation CoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
    bottomViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
    [self addChildViewController:bottomViewController];
    [self addChildViewController:topViewController];
    
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    topViewController.view.frame = frame;
    bottomViewController.view.frame = frame;
    
    isDown = YES;
    
    [self.view addSubview:bottomViewController.view];
    [self.view addSubview:topViewController.view];
    
    [self.view addGestureRecognizer:panRecognizer];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handlePan: (UIPanGestureRecognizer *) sender
{
    if (sender.state == UIGestureRecognizerStateBegan){
        if ((isDown && [sender locationInView:self.view].y < self.view.frame.size.height - kActiveAreaBottom) ||
            (!isDown && [sender locationInView:self.view].y > kActiveAreaTop))
            [sender cancel];
        
    } else if (sender.state == UIGestureRecognizerStateChanged){
        float translation = [sender translationInView:self.view].y;
        if (isDown && translation < 0){
            CGRect topFrame = topViewController.view.frame;
            topFrame.origin.y = translation;
            topViewController.view.frame = topFrame;
        }
        if (!isDown && translation > 0){
            CGRect topFrame = topViewController.view.frame;
            topFrame.origin.y = -topFrame.size.height + translation;
            topViewController.view.frame = topFrame;
        }
        }
    else if (sender.state == UIGestureRecognizerStateEnded){
        CGPoint velocity = [sender velocityInView:self.view];
        if (velocity.y < 0){
            [UIView animateWithDuration:.5
                             animations:^{
                             CGRect frame = topViewController.view.frame;
                             frame.origin.y = -frame.size.height;
                             topViewController.view.frame = frame;
                         } completion:^(BOOL finished) {
                             isDown = NO;
                         }];
        } else {
            [UIView animateWithDuration:.5
                             animations:^{
                                 CGRect frame = topViewController.view.frame;
                                 frame.origin.y = 0;
                                 topViewController.view.frame = frame;
                             } completion:^(BOOL finished) {
                                 isDown = YES;
                             }];
        }
    }
}

@end
