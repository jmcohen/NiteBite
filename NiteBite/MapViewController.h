//
//  ViewController.h
//  NiteBite
//
//  Created by Jeremy Cohen on 11/2/12.
//  Copyright (c) 2012 Jeremy Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NBMapView.h"

@class PlaceView;

@interface MapViewController : UIViewController <NBMapViewDelegate> {
    NBMapView *webview;
    PlaceView *placeView;
    NSMutableArray *places;
}

@property (nonatomic, strong) NBMapView *webview;
@property (nonatomic, strong) PlaceView *placeView;
@property (nonatomic, strong) NSMutableArray *places;

- (void) singleTap;
- (void) doubleTap;

@end
