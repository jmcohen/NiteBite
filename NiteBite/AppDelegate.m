//
//  AppDelegate.m
//  NiteBite
//
//  Created by Jeremy Cohen on 11/2/12.
//  Copyright (c) 2012 Jeremy Cohen. All rights reserved.
//

#import "AppDelegate.h"
#import "PlacesEngine.h"

@implementation AppDelegate

@synthesize settings, placesEngine, locationManager;

//enum {OPEN_TIME = 22, CLOSE_TIME = 6};
enum {OPEN_TIME = 6, CLOSE_TIME = 6};


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.settings = [[Settings alloc] init];
        
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = 50;
    [self.locationManager startUpdatingLocation];

    self.placesEngine = [[PlacesEngine alloc] initWithHostName:@"maps.googleapis.com" customHeaderFields:nil];
    
//    UIImage *buttonImage = [[UIImage imageNamed:@"button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 15, 25, 15)];
//    [[UIButton appearance] setBackgroundImage:buttonImage forState:UIControlStateNormal];

    UIColor *aqua = [UIColor colorWithRed:.1 green:.7 blue:.85 alpha:1];
    [[UILabel appearance] setTextColor:aqua];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    return YES;
}

- (void) showMainScreen{
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents = [gregorian components:NSHourCalendarUnit fromDate:now];
    NSInteger hour = weekdayComponents.hour;
    BOOL isOpen = hour > OPEN_TIME || hour < CLOSE_TIME;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier: isOpen? @"WelcomeViewController" : @"ClosedViewController"];
    [[storyboard instantiateViewControllerWithIdentifier:@"MapViewController"] view];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self showMainScreen];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self showMainScreen];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
