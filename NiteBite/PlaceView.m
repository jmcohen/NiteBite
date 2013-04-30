//
//  PlaceView.m
//  NiteBite
//
//  Created by Jeremy Cohen on 2/2/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "PlaceView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "PlacesEngine.h"
#import "Place.h"

@implementation PlaceView

@synthesize place;

+ (CGRect) makeCircle:(int) radius{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    return CGRectMake(screenWidth/2 - radius, screenHeight/2 - radius, 2 * radius, 2 * radius);
}

- (id)init {
    self = [super initWithFrame:[PlaceView makeCircle:160]];
    if (self) {
        self.layer.cornerRadius = 160;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:.1 green:.7 blue:.85 alpha:1];
    }
    return self;
}

- (int) widthForDepth: (int) depth{
    int screenWidth = 320;
    int radius = screenWidth / 2;
    int y = radius - depth;
    int x = sqrt(radius * radius - y * y);
    return 2 * x;
}

// Returns the char index (corresponding to a space) at which the string should be split onto a new line
- (int) shortenString: (NSString *) string withFont: (UIFont *) font toWidth: (int) width {
    int index = 0;
    for (int i = 0; i < [string length]; i++){
        char c = [string characterAtIndex:i];
        if (c == ' ' || c == '\n'){
            int widthSoFar = [[string substringToIndex:i] sizeWithFont:font].width;
            if (widthSoFar > width)
                return index;
            index = i;
        }
        if (c == '\n'){
            return i;
        }
    }
    int totalWidth = [string sizeWithFont:font].width;
    if (totalWidth > width)
        return index;
    return [string length];
}

- (int) depthForPhrase: (NSString *) phrase atDepth: (int) depth withFont: (UIFont *) font {
    int availableWidth = [self widthForDepth:depth];
    int index = [self shortenString:phrase withFont:font toWidth:availableWidth];
    if (index == 0){
        if (depth < 320)
            return [self depthForPhrase:phrase atDepth:depth + 1 withFont:font];
        else {
            return -1;
        }
    }
    NSString *currentLine = [phrase substringToIndex:index];
    NSString *nextLine = index == [phrase length] ? nil : [phrase substringFromIndex:index + 1];
    CGSize size = [currentLine sizeWithFont:font];
    if (nextLine){
        return [self depthForPhrase:nextLine atDepth:depth + size.height withFont:font];
    }
    return depth + size.height;
}

- (int) drawPhrase: (NSString *) phrase atDepth: (int) depth withFont: (UIFont *) font {
    int screenWidth = 320, radius = screenWidth / 2;    
    int availableWidth = [self widthForDepth:depth];
    int index = [self shortenString:phrase withFont:font toWidth:availableWidth];
    if (index == 0){
        if (depth < 2 * radius)
            return [self drawPhrase:phrase atDepth:depth + 1 withFont:font];
        else {
            return -1;
        }
    }
    NSString *currentLine = [phrase substringToIndex:index];
    NSString *nextLine = index == [phrase length] ? nil : [phrase substringFromIndex:index + 1];
    CGSize size = [currentLine sizeWithFont:font];
    [currentLine drawAtPoint:CGPointMake(radius - size.width/2, depth) withFont:font];
    if (nextLine){
        return [self drawPhrase:nextLine atDepth:depth + size.height withFont:font];
    }
    
    return depth + size.height;
}

- (void) drawRect:(CGRect)rect{
    if (self.place.hasDetails){
        NSMutableString *text = [[NSMutableString alloc] init];
        [text appendString:place.name];
        if ([place priceLevel]){
            [text appendFormat: @"\n%@", [place priceLevel]];
        }
        if ([place timeUntilClosing]){
            [text appendFormat: @"\n%@", [place timeUntilClosing]];
        }
        
        UIFont *font = [UIFont fontWithName:@"MavenProLight300-Regular" size:30];
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 0, 0, 0, 1);

        int depth = 0;
        while (true){
            int top = depth;
            int bottom = [self depthForPhrase: text atDepth: top withFont: font];
            int middle = (bottom + top) / 2;
            if (middle >= 160 || bottom > 260)
                break;
            depth++;
        }
        depth = [self drawPhrase: text atDepth: depth withFont: font];
        
        // Draw the instructions
        font = [UIFont fontWithName:@"MavenProLight300-Regular" size:13];
        depth = 260;
        depth = [self drawPhrase:@"[tap to return to map]" atDepth:depth withFont:font];
        depth = [self drawPhrase:@"[tap twice to get directions]" atDepth:depth withFont:font];
    }
    [super drawRect:rect];
}

- (void) setPlace:(Place *)newPlace{
    place = newPlace;
    [self setNeedsDisplay];
    [((AppDelegate *) [UIApplication sharedApplication].delegate).placesEngine getDetailsForPlace:place.reference onSuccess:^(NSDictionary *details) {
        [place digestDetails:details];
        [self setNeedsDisplay];
    }];
}

@end
