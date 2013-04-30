//
//  WelcomeViewController.h
//  NiteBite
//
//  Created by Jeremy Cohen on 1/31/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController {
    UILabel *titleLabel;
    UILabel *subtitleLabel;
    UIButton *startButton;
}

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, strong) IBOutlet UIButton *startButton;

@end
