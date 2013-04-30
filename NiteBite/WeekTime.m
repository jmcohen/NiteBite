//
//  WeekTime.m
//  NiteBite
//
//  Created by Jeremy Cohen on 3/21/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "WeekTime.h"

@implementation WeekTime

- (id) initWithSeconds:(NSTimeInterval)theSeconds{
    if (self = [super init]){
        seconds = theSeconds;
    }
    return self;
}

- (id) initWithDay:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute{
    return [self initWithSeconds: (day * 24 * 60 * 60) + (hour * 60 * 60) + (minute * 60)];
}

- (id) initWithDate:(NSDate *)date{
    if (self = [super init]){
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *weekdayComponents = [gregorian components:(NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit) fromDate:date];
        NSInteger iOSWeekday = weekdayComponents.weekday;
        NSInteger day = iOSWeekday - 1; // iOS says Sunday is 1, NiteBite says Sunday is 0
        NSInteger hour = weekdayComponents.hour;
        NSInteger minute = weekdayComponents.minute;
        return [self initWithDay:day hour:hour minute:minute];
    }
    return self;
}

- (id) initWithDay:(NSInteger)day time:(NSString *)time{
    if (self = [super init]){
        NSInteger hour = [[time substringToIndex:2] integerValue];
        NSInteger minute = [[time substringFromIndex:2] integerValue];
        return [self initWithDay:day hour:hour minute:minute];
    }
    return self;
}

- (id) initWithTimeDictionary:(NSDictionary *)dictionary{
    return [self initWithDay: [[dictionary objectForKey:@"day"] integerValue]
                        time: [dictionary objectForKey:@"time"]];
    
}

- (NSTimeInterval) seconds{
    return seconds;
}

- (NSTimeInterval) timeIntervalSinceWeekTime:(WeekTime *)other{
    NSTimeInterval difference = seconds - [other seconds];
    NSTimeInterval secondsPerWeek = 7 * 24 * 60 * 60;
    return difference > 0 ? difference : secondsPerWeek + difference;
    
}

- (NSTimeInterval) timeIntervalUntilWeekTime:(WeekTime *)other{
    NSTimeInterval difference = [other seconds] - seconds;
    NSTimeInterval secondsPerWeek = 7 * 24 * 60 * 60;
    return difference > 0 ? difference : secondsPerWeek + difference;
}

- (NSString *) description{
    return [NSString stringWithFormat: @"%f", [self seconds]];
}

@end
