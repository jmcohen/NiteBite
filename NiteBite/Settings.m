//
//  Settings.m
//  NiteBite
//
//  Created by Jeremy Cohen on 1/31/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "Settings.h"

@implementation Settings
@synthesize travelTime, travelMode;

- (id) init {
    if (self == [super init]){
        self.travelTime = 10;
        self.travelMode = kCar;
    }
    return self;
}

@end
