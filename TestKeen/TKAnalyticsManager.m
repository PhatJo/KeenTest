//
//  TKAnalyticsManager.m
//  TestKeen
//
//  Created by Kiptoo Magutt on 8/21/14.
//  Copyright (c) 2014 Kiptoo Magutt. All rights reserved.
//

#import "TKAnalyticsManager.h"
#import <CoreLocation/CoreLocation.h>
#import "KeenClient.h"
#import "KeenProperties.h"

@interface TKAnalyticsManager ()
@property (strong, nonatomic) NSDictionary *locationDict;
@end

@implementation TKAnalyticsManager
- (id)init {
    if (self = [super init]) {
        // initialize w/ api keys
    }
    
    return self;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t pred;
    static TKAnalyticsManager *sharedManager = nil;
    dispatch_once(&pred, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (NSDictionary *) getKeenAnalyticsGlobals
{
    // user id
    NSString *uuid = @"my-user-id";
    CLLocation *currentLoc = [[KeenClient sharedClient] currentLocation];
    [self setLocationDictionary:currentLoc];
    NSString *timestamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    NSLog(@"user location: %@", currentLoc);
    
    
    NSDictionary *keenGlobals = [NSDictionary dictionaryWithObjectsAndKeys: timestamp, @"timestamp",
                   uuid, @"uuid",
                   self.locationDict ? self.locationDict : @"-1", @"current_location",
                   nil];
    // attempt to convert coordinates to coarse location: locationDict = {neighbourhood, city, state, country}.
    // problem: by the time reverseGeocodeLocation returns, keenGlobals will have been set and
    // self.locationDict will be null :(
    /*__block NSDictionary *keenGlobals;
     [[NSNotificationCenter defaultCenter] addObserverForName:@"TKUpdateLocationNotification"
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *note) {
                 self.location = note.userInfo;
                 keenGlobals = [NSDictionary dictionaryWithObjectsAndKeys: timestamp, @"timestamp",
                 uuid, @"uuid",
                 self.location ? self.location : @"-1", @"current_location",
                 nil];
     }];*/
    
    return keenGlobals;
}

- (void) setLocationDictionary: (CLLocation *) location
{
    // register observer for location update
    /*[[NSNotificationCenter defaultCenter] addObserverForName:@"TKUpdateLocationNotification"
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *note) {
     self.location = note.userInfo;
     }];*/
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        CLPlacemark *placeMark = [placemarks objectAtIndex:0];
        NSDictionary *location = [NSDictionary dictionaryWithObjectsAndKeys:
                                  placeMark.subLocality, @"sublocality",
                                  placeMark.locality, @"city",
                                  placeMark.administrativeArea, @"state",
                                  placeMark.country, @"country", nil];
        NSLog(@"location found: %@", [location description]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TKUpdateLocationNotification"
                                                            object:nil
                                                          userInfo:location];
    }];
}

@end
