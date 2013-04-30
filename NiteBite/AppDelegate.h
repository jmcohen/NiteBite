//
//  AppDelegate.h
//  NiteBite
//
//  Created by Jeremy Cohen on 11/2/12.
//  Copyright (c) 2012 Jeremy Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import <CoreLocation/CoreLocation.h>
@class PlacesEngine;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    Settings *settings;
    PlacesEngine *placesEngine;
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Settings *settings;
@property (strong, nonatomic) PlacesEngine *placesEngine;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
