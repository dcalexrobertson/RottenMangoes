//
//  LocationManager.h
//  Rotten Mangoes
//
//  Created by Alex on 2015-11-10.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) CLLocation *currentLocation;

+ (LocationManager *)sharedLocationManager;

- (void)setUpLocationManager;
- (void)startLocationManager;
- (void)stopLocationManager;

@end
