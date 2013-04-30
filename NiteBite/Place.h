//
//  Place.h
//  NiteBite
//
//  Created by Jeremy Cohen on 3/21/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject {
    NSString *name;
    NSString *lat, *lng;
    NSString *placeId;
    NSString *reference;
    BOOL isOpen;
    
    BOOL hasDetails; // Whether this Place's details have been downloaded yet
    
    int priceLevel;
    NSDate *closingTime;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic) BOOL isOpen;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, strong) NSString *reference;
@property (nonatomic) BOOL hasDetails;

- (id) initWithDictionary: (NSDictionary *) dictionary;
- (void) digestDetails: (NSDictionary *) details;

- (NSString *) priceLevel;
- (NSString *) timeUntilClosing;

@end
