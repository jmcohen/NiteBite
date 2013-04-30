//
//  NBMapView.m
//  NiteBite
//
//  Created by Jeremy Cohen on 2/1/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import "NBMapView.h"
#import <QuartzCore/CALayer.h>
#import "NSObject+SEWebviewJSListener.m"

@implementation NBMapView

@synthesize mapDelegate;


- (id) init {
    self = [super initWithFrame:[NBMapView makeCircle: 160]];
    if (self){
        self.layer.cornerRadius = 160;
        self.clipsToBounds = YES;
        
        self.scrollView.bounces = NO;
        self.multipleTouchEnabled = NO;
        self.scalesPageToFit = NO;
        self.delegate = self;
    }
    return self;
}

- (void) addPlace:(NSString *)placeId lat:(NSString *)lat lng:(NSString *)lng{
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addMarker('%@', '%@', '%@')", placeId, lat, lng]];
}

- (void) setCoordinates:(CLLocationCoordinate2D)coordinates{
    NSString *script = [NSString stringWithFormat:@"setCoordinates(%f, %f)", coordinates.latitude, coordinates.longitude];
    [self stringByEvaluatingJavaScriptFromString:script];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.mapDelegate mapViewDidFinishLoad:self];
}

- (void) webviewMessageKey:(NSString *)key value:(NSString *)val{
   if ([key isEqualToString:@"tap"])
       [self.mapDelegate placeDidTap:val];
}

+ (CGRect) makeCircle:(int) radius{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    return CGRectMake(screenWidth/2 - radius, screenHeight/2 - radius, 2 * radius, 2 * radius);
}

@end
