//
//  LocationManager.m
//  Rotten Mangoes
//
//  Created by Alex on 2015-11-10.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>

@implementation LocationManager

+ (LocationManager *)sharedLocationManager {
    static LocationManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

-(void)setUpLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
}

-(void)startLocationManager {
    
    if (!self.locationManager) {
        [self setUpLocationManager];
        [self.locationManager startUpdatingLocation];
        [self checkStatus];
    }
}

-(void)stopLocationManager {
    [self.locationManager stopUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *loc = locations[locations.count - 1];
    
    NSLog(@"Time %@, latitude %+.6f, longitude %+.6f currentLocation accuracy %1.2f loc accuracy %1.2f timeinterval %f",[NSDate date],loc.coordinate.latitude, loc.coordinate.longitude, loc.horizontalAccuracy, loc.horizontalAccuracy, fabs([loc.timestamp timeIntervalSinceNow]));
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Location Updated" object:nil];
    
}

-(void)checkStatus{
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status==kCLAuthorizationStatusNotDetermined) {
        NSLog(@"Not Determined");
    }
    
    if (status==kCLAuthorizationStatusDenied) {
        NSLog(@"Denied");
    }
    
    if (status==kCLAuthorizationStatusRestricted) {
        NSLog(@"Restricted");
    }
    
    if (status==kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"Always Allowed");
    }
    
    if (status==kCLAuthorizationStatusAuthorizedWhenInUse) {
        NSLog(@"When In Use Allowed");
    }
    
}

@end
