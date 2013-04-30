//
//  NBMapView.h
//  NiteBite
//
//  Created by Jeremy Cohen on 2/1/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class NBMapView;

@protocol NBMapViewDelegate <NSObject>

- (void) mapViewDidFinishLoad:(NBMapView *) mapView;
- (void) placeDidTap: (NSString *) placeId;

@end


@interface NBMapView : UIWebView <UIWebViewDelegate>

@property (nonatomic) id<NBMapViewDelegate> mapDelegate;

- (id) init;
- (void) addPlace: (NSString *) placeId lat: (NSString *) lat lng: (NSString *) lng;
- (void) setCoordinates: (CLLocationCoordinate2D) coordinates;

@end
