//
//  TKAnalyticsManager.h
//  TestKeen
//
//  Created by Kiptoo Magutt on 8/21/14.
//  Copyright (c) 2014 Kiptoo Magutt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TKAnalyticsManager : NSObject<CLLocationManagerDelegate>

+ (id)sharedInstance;
- (NSDictionary *) getKeenAnalyticsGlobals;

@end
