//
//  PlacesEngine.h
//  NiteBite
//
//  Created by Jeremy Cohen on 2/1/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "MKNetworkEngine.h"
#import <CoreLocation/CoreLocation.h>

@interface PlacesEngine : MKNetworkEngine

typedef void (^PlacesBlock)(NSArray *places);
typedef void (^PlaceDetailsBlock) (NSDictionary *details);

- (MKNetworkOperation *) getPlacesForCoordinate: (CLLocationCoordinate2D) coordinate radius: (int) radius onSuccess: (PlacesBlock) showPlaces;

- (MKNetworkOperation *) getDetailsForPlace: (NSString *) reference onSuccess: (PlaceDetailsBlock) showPlaceDetails;

@end
