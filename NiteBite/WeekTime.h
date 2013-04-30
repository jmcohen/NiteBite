//
//  WeekTime.h
//  NiteBite
//
//  Created by Jeremy Cohen on 3/21/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeekTime : NSObject {
    NSTimeInterval seconds; // The number of seconds since Sunday at midnight
}

- (id) initWithSeconds: (NSTimeInterval) seconds;
- (id) initWithDay: (NSInteger) day hour: (NSInteger) hour minute: (NSInteger) minute;
- (id) initWithDate: (NSDate *) date;
- (id) initWithDay: (NSInteger) day time: (NSString *) time;
- (id) initWithTimeDictionary: (NSDictionary *) dictionary;
- (NSTimeInterval) seconds;
- (NSTimeInterval) timeIntervalSinceWeekTime: (WeekTime *) other;
- (NSTimeInterval) timeIntervalUntilWeekTime: (WeekTime *) other;

@end
