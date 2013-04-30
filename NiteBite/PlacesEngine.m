//
//  PlacesEngine.m
//  NiteBite
//
//  Created by Jeremy Cohen on 2/1/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "PlacesEngine.h"
#import "MKNetworkKit/Categories/NSString+MKNetworkKitAdditions.h"

@implementation PlacesEngine

- (MKNetworkOperation *) getPlacesForCoordinate:(CLLocationCoordinate2D) coordinate radius:(int)radius  onSuccess:(PlacesBlock)showPlaces {
    NSString *key = @"AIzaSyCvGXBycjMdz-2DAsmXiWWZl6vQgBJFjJo";
    NSString *types = @"bakery|bar|cafe|convenience_store|liquor_store|meal_delivery|meal_takeaway|night_club|restaurant";
    NSString *location = [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
    NSString *radiusString = [NSString stringWithFormat: @"%d", radius];
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"maps/api/place/nearbysearch/json"]
                                              params:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      types, @"types",
                                                      location, @"location",
                                                      radiusString, @"radius",
                                                      @"true", @"sensor",
                                                      key, @"key",
                                                      nil]
                                          httpMethod:@"GET" ssl:YES];

   
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSArray *places = [completedOperation.responseJSON objectForKey:@"results"];
        showPlaces(places);
    } onError:^(NSError *error) {
        NSLog(@"Error in getting places: %@", error);
    }];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *) getDetailsForPlace: (NSString *) reference onSuccess:(PlaceDetailsBlock)showPlaceDetails {
    NSString *key = @"AIzaSyCvGXBycjMdz-2DAsmXiWWZl6vQgBJFjJo";
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"maps/api/place/details/json"]
                                              params:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      key, @"key",
                                                      reference, @"reference",
                                                      @"true", @"sensor",
                                                      nil]
                                          httpMethod:@"GET" ssl:YES];
    
    
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSDictionary *details = [completedOperation.responseJSON objectForKey:@"result"];
        showPlaceDetails(details);
    } onError:^(NSError *error) {
        NSLog(@"Error in getting places: %@", error);
    }];
    [self enqueueOperation:op];
    return op;
}

@end
