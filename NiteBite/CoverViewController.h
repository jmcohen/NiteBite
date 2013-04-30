//
//  CoverViewController.h
//  NiteBite
//
//  Created by Jeremy Cohen on 11/10/12.
//  Copyright (c) 2012 Jeremy Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kActiveAreaTop 80
#define kActiveAreaBottom 40

@interface CoverViewController : UIViewController {
    UIViewController *topViewController;
    UIViewController *bottomViewController;
    BOOL isDown;
}

@end
