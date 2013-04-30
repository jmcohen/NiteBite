//
//  Place.m
//  NiteBite
//
//  Created by Jeremy Cohen on 3/21/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "Place.h"
#import "WeekTime.h"

@implementation Place

@synthesize name, isOpen, placeId, lat, lng, reference, hasDetails;

- (id) initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]){
        name = [dictionary objectForKey:@"name"];
        lat = [[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"];
        lng = [[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"];
        placeId = [dictionary objectForKey:@"id"];
        reference = [dictionary objectForKey:@"reference"];
        
        hasDetails = NO;

        priceLevel = -1;
        isOpen = [[[dictionary objectForKey:@"opening_hours"] objectForKey:@"open_now"] boolValue];
        closingTime = nil;
    }
    return self;
}


- (void) digestDetails:(NSDictionary *)details{
    self.hasDetails = YES;
    
    // Get price level.
    if ([details objectForKey:@"price_level"])
        priceLevel = [[details objectForKey:@"price_level"] integerValue];
    
    // Get time until closing.
    isOpen = [[[details objectForKey:@"opening_hours"] objectForKey:@"open_now"] boolValue];
    NSArray *periods = [[details objectForKey:@"opening_hours"] objectForKey:@"periods"];
    NSLog(@"name: %@; isOpen: %d", self.name, isOpen);
    // Find the current period.
    if (periods && isOpen){
        NSDate *now = [NSDate date];
        WeekTime *currentWeekTime = [[WeekTime alloc] initWithDate: now];
        NSDictionary *mostRecentPeriod = nil;
        NSTimeInterval mostRecentPeriodTime = MAXFLOAT;
        for (NSDictionary *period in periods){
            WeekTime *openWeekTime = [[WeekTime alloc] initWithTimeDictionary:[period objectForKey:@"open"]];
            NSTimeInterval openTime = [currentWeekTime timeIntervalSinceWeekTime:openWeekTime];
            if (openTime < mostRecentPeriodTime) {
                mostRecentPeriod = period;
                mostRecentPeriodTime = openTime;
            }
        }
                
        NSDictionary *closeDictionary = [mostRecentPeriod objectForKey:@"close"];
        if (closeDictionary){
            WeekTime *closeWeekTime = [[WeekTime alloc] initWithTimeDictionary:closeDictionary];
            NSTimeInterval timeIntervalUntilClose = [currentWeekTime timeIntervalUntilWeekTime:closeWeekTime];
            if (timeIntervalUntilClose > 24 * 60 * 60){ // There's something wrong...
                isOpen = NO;
            } else {
                closingTime = [[NSDate alloc] initWithTimeInterval:timeIntervalUntilClose sinceDate:now];
            }
        } else { // 24 hour restaurant
            closingTime = [NSDate distantFuture];
        }
    }
}

- (NSString *) priceLevel{
    if (priceLevel == -1)
        return nil;
    return [@"" stringByPaddingToLength:priceLevel withString:@"$" startingAtIndex:0];
}

- (NSString *) timeUntilClosing{
    if (!closingTime)
        return nil;
    if (closingTime == [NSDate distantFuture])
        return @"never closes";
    NSTimeInterval interval = [closingTime timeIntervalSinceNow];
    NSInteger hours = interval / (60 * 60);
    NSInteger minutes = (interval / 60) - (hours * 60);
    return [NSString stringWithFormat:@"closes in %02d:%02d", hours, minutes];
}

@end
