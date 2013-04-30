//
//  UIGestureRecognizer+Cancel.m
//  NiteBite
//
//  Created by Jeremy Cohen on 11/11/12.
//  Copyright (c) 2012 Jeremy Cohen. All rights reserved.
//

#import "UIGestureRecognizer+Cancel.h"

@implementation UIGestureRecognizer (Cancel)

- (void)cancel{
    self.enabled = NO;
    self.enabled = YES;
}

@end
