//
//  NextSegue.m
//  NiteBite
//
//  Created by Jeremy Cohen on 1/31/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "NextSegue.h"

@implementation NextSegue

- (void) perform{
    [[self.sourceViewController navigationController] pushViewController:self.destinationViewController animated:YES];
}

@end
