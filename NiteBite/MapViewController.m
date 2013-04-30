//
//  ViewController.m
//  NiteBite
//
//  Created by Jeremy Cohen on 11/2/12.
//  Copyright (c) 2012 Jeremy Cohen. All rights reserved.
//

#import "MapViewController.h"
#import "NBMapView.h"
#import <QuartzCore/QuartzCore.h>
#import "PlacesEngine.h"
#import "AppDelegate.h"
#import "PlaceView.h"
#import "Settings.h"
#import <MapKit/MapKit.h>
#import "Place.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize webview, placeView, places;


//- (void) animateWebviewRadius: (int) radius {
//    CGPoint initialPosition = CGPointMake(160, 284);
//    CGPoint finalPosition = CGPointMake(160 - radius, 284 - radius);
//    
//    self.webview.clipsToBounds = YES;
//    
//    CABasicAnimation *animationRadius = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
//    animationRadius.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    animationRadius.fromValue = [NSNumber numberWithFloat:0];
//    animationRadius.toValue = [NSNumber numberWithFloat:radius];
//    animationRadius.duration = 1.0;
//    [self.webview.layer addAnimation:animationRadius forKey:@"cornerRadius"];
//    self.webview.layer.cornerRadius = radius;
//    
//    CABasicAnimation *animationPosition = [CABasicAnimation animationWithKeyPath:@"position"];
//    animationPosition.fromValue = [NSValue valueWithCGPoint:initialPosition];
//    animationPosition.toValue = [NSValue valueWithCGPoint:finalPosition];
//    animationPosition.duration = 1.0;
//    self.webview.layer.position = finalPosition;
//    [self.webview.layer addAnimation:animationPosition forKey:@"position"];
//    
//    
//    // Prepare the animation from the old size to the new size
//    CGRect initialBounds = self.webview.layer.bounds;
//    CGRect finalBounds = initialBounds;
//    finalBounds.size = CGSizeMake(radius * 2, radius * 2);
//    CABasicAnimation *animationBounds = [CABasicAnimation animationWithKeyPath:@"bounds"];
//    animationBounds.fromValue = [NSValue valueWithCGRect:initialBounds];
//    animationBounds.toValue = [NSValue valueWithCGRect:finalBounds];
//    animationBounds.duration = 1.0;
//    self.webview.layer.bounds = finalBounds;
//    [self.webview.layer addAnimation:animationBounds forKey:@"bounds"];
//}



- (void)viewDidLoad {
    self.places = [[NSMutableArray alloc] init];
    
    self.webview = [[NBMapView alloc] init];
    self.webview.mapDelegate = self;
    [self.view addSubview:self.webview];
    
    self.placeView = [[PlaceView alloc] init];
    
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    [singleTapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
    
    [self.placeView addGestureRecognizer:singleTapRecognizer];
    [self.placeView addGestureRecognizer:doubleTapRecognizer];

    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://nitebiteapp.com"]]];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) mapViewDidFinishLoad:(NBMapView *) mapView {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    CLLocationCoordinate2D coordinate = [delegate.locationManager location].coordinate;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(40.714, -74);
    [self.webview setCoordinates:coordinate];
    
    [delegate.placesEngine getPlacesForCoordinate:coordinate radius:1000 onSuccess:^(NSArray *newPlaceDictionaries) {
        for (NSDictionary *placeDict in newPlaceDictionaries){
            Place *place = [[Place alloc] initWithDictionary:placeDict];
            [self.places addObject:place];
            if (place.isOpen){
                [self.webview addPlace: place.placeId lat: place.lat lng: place.lng];
            }
        }
    }];
}

- (void) placeDidTap:(NSString *) placeId {
    [UIView transitionFromView:self.webview
                        toView:self.placeView
                      duration:1.0
                       options: UIViewAnimationOptionTransitionFlipFromRight
                    completion:nil
     ];
    // TODO better data structure
    for (Place *place in self.places)
        if ([place.placeId isEqualToString: placeId])
            [self.placeView setPlace:place];
}

- (void) doubleTap {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.placeView.place.lat doubleValue] , [self.placeView.place.lng doubleValue]);

    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
{
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:@"Pikesville"];
    
        int travelMode = ((AppDelegate *)[UIApplication sharedApplication].delegate).settings.travelMode;
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : travelMode == kCar? MKLaunchOptionsDirectionsModeDriving : MKLaunchOptionsDirectionsModeWalking};
        
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem] launchOptions:launchOptions];
    } else {
        CLLocationCoordinate2D currentCoordinate = ((AppDelegate *)[UIApplication sharedApplication].delegate).locationManager.location.coordinate;
        NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f", currentCoordinate.latitude, currentCoordinate.longitude, coordinate.latitude, coordinate.longitude];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
}

- (void) singleTap {
    [UIView transitionFromView:self.placeView
                        toView:self.webview
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:nil
     ];
}

@end
