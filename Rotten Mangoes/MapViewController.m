//
//  MapViewController.m
//  Rotten Mangoes
//
//  Created by Alex on 2015-11-10.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "MapViewController.h"
#import "LocationManager.h"
#import <MapKit/MapKit.h>
#import "Movie.h"
#import "Theatre.h"

@interface MapViewController () <MKMapViewDelegate>

@property (strong,nonatomic) LocationManager *locationManager;

@property (nonatomic) BOOL mapLoadedWithTheatres;

@property (nonatomic) NSString *postalCode;
@property (nonatomic) NSArray *theatres;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    NSLog(@"%@", self.mapView.userLocation.title);
    
    //location manager
    self.locationManager = [LocationManager sharedLocationManager];
    [self.locationManager startLocationManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheatresIfNeeded) name:@"Location Updated" object:nil];
}

- (void)updateTheatresIfNeeded {
    
    if (!self.mapLoadedWithTheatres) {
        [self updateTheatres];
    }
}

- (void)updateTheatres {
    
    NSMutableArray *tempTheatreArray = [NSMutableArray new];
    
    NSLog(@"Notification recieved!");
    
    //get postal code by reverse geocoding
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.locationManager.locationManager.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            CLPlacemark *currentPlacemark = placemarks[placemarks.count - 1];
            self.postalCode = currentPlacemark.postalCode;
            
        } else {
            NSLog(@"Error, yo");
        }
    }];
    
    //format movie title for url
    
    NSString *movieString = [self.movie.title stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    if (!self.postalCode) {
        self.postalCode = @"V6B1E6";
    }
    
    //get json
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=%@&movie=%@", self.postalCode, movieString]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            NSLog(@"Running datatask");
            NSError *jsonError = nil;
            
            NSDictionary *theatreDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            NSArray *theatres = theatreDict[@"theatres"];
            
            for (NSDictionary *theatre in theatres) {
                
                if (!self.theatres) {
                    self.theatres = [NSMutableArray new];
                }
                
                NSString *name = theatre[@"name"];
                NSString *address = theatre[@"address"];
                NSNumber *lat = theatre[@"lat"];
                NSNumber *longitude = theatre[@"lng"];
                
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([lat doubleValue], [longitude doubleValue]);
                
                Theatre *newTheatre = [[Theatre alloc] initWithCoordinate:coordinate andTitle:name andSubtitle:address];
                
                [tempTheatreArray addObject:newTheatre];
                
            }
            
            self.theatres = [NSArray arrayWithArray:tempTheatreArray];
            self.mapLoadedWithTheatres = YES;
            
            NSLog(@"Theatres array: %@", self.theatres);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                for (Theatre *theatre in self.theatres) {
                    
                    [self.mapView addAnnotation:theatre];
                }
                
            });
        }
        
    }];
    
    [dataTask resume];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] init];
    
    annotationView.canShowCallout = YES;
    annotationView.pinTintColor = [UIColor redColor];
    
    return annotationView;
}

@end
