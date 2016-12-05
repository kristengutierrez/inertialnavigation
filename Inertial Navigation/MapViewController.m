//
//  ViewController.m
//  Inertial Navigation
//
//  Created by Kristen Kozmary on 10/3/16.
//  Copyright © 2016 koz. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <CoreMotion/CoreMotion.h>
#import "MathController.h"
@import GoogleMaps;

@interface MapViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *viewForMap;
@property(strong,nonatomic) CMPedometer *pedometer;
@property(strong,nonatomic) NSMutableArray *stepCountLog;
@property (atomic, strong) CLLocationManager *locationManager;
@property (nonatomic, weak) IBOutlet UIButton *tracking;
@property (readonly, nonatomic) CLLocationDirection trueHeading;
- (IBAction)getCurrentLocation:(id)sender;
@property (strong, nonatomic) MathController *mathCon;

@property int seconds;
@property float distance;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) GMSMutablePath *path;
@property (nonatomic, strong) GMSPolyline *line;

@end

@implementation MapViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  
  self.locations = [[NSMutableArray alloc] init];
  
  
	self.pedometer = [[CMPedometer alloc] init];

  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:43.0386 longitude:-87.9309 zoom:15];
  self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];

  self.mapView.myLocationEnabled = YES;
  [self.viewForMap addSubview:self.mapView];
  self.mapView.delegate = self;
  
  _path = [GMSMutablePath path];

  _line = [GMSPolyline polylineWithPath:_path];

  _line.strokeWidth = 4.f;
  _line.strokeColor = [UIColor colorWithRed:14.0/255 green:122.0/255 blue:254.0/255 alpha:1.0];
  _line.map = _mapView;
  
  _locationManager = [[CLLocationManager alloc] init];
  _locationManager.delegate=self;
  _locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
  _locationManager.distanceFilter=1; //specified in meters

  if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
    [self.locationManager requestWhenInUseAuthorization];
  }

 }

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)startLocationUpdates
{
  // Create the location manager if this object does not
  // already have one.
//  if (self.locationManager == nil) {
//    self.locationManager = [[CLLocationManager alloc] init];
//  }
  self.locationManager = [[CLLocationManager alloc] init];
  self.locationManager.delegate = self;
  self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  self.locationManager.activityType = CLActivityTypeFitness;
  
  // Movement threshold for new events.
  self.locationManager.distanceFilter = 0; // meters
  [self.locationManager startUpdatingHeading];
  [self.locationManager startUpdatingLocation];
}

-(IBAction)didTapStopTracking:(id)sender {
  [self.locationManager stopUpdatingHeading];
  [self.locationManager stopUpdatingLocation];
}

-(IBAction)didTapStartTracking:(id)sender {
  
  
  [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData *pedometerData, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      
      NSLog(@"data:%@, error:%@", pedometerData, error);
    });
  }];
  self.seconds = 0;
  self.distance = 0;
  self.locations = [NSMutableArray array];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self
                                              selector:@selector(eachSecond) userInfo:nil repeats:YES];
  [self startLocationUpdates];
}


- (IBAction)getCurrentLocation:(id)sender {
    [self.locationManager startUpdatingLocation];
CLLocation *newLocation = [_locations lastObject];
  GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude zoom:15.0];
                                        [self.mapView animateToCameraPosition:cameraPosition];
  
  //[self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  NSLog(@"didFailWithError: %@", error);

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  CLLocation *newLocation = [locations lastObject];
 if (self.locations.count > 1) {
     CLLocation *oldLoc = ((CLLocation *)self.locations[self.locations.count - 1]);
   float distance = [newLocation distanceFromLocation:self.locations.lastObject];
   float radians = [self.mathCon DegreesToRadians:_trueHeading];
   CLLocation *newLocation = [self.mathCon calculateNewLatLon:oldLoc by:distance with:radians];
   //CLLocationCoordinate2D newLoc = newLocation.coordinate;
   CLLocationCoordinate2D newLoc = ((CLLocation *)self.locations.lastObject).coordinate;
    [_path addCoordinate:newLoc];
    [_line setPath:_path];

  }
  
[self.locations addObject:newLocation];
  
}



- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [self.timer invalidate];
}


- (void) eachSecond
{

  self.seconds++;

}
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
  if ([overlay isKindOfClass:[MKPolyline class]]) {
    MKPolyline *polyLine = (MKPolyline *)overlay;
    MKPolylineRenderer *aRenderer = [[MKPolylineRenderer alloc] initWithPolyline:polyLine];
    aRenderer.strokeColor = [UIColor blueColor];
    aRenderer.lineWidth = 3;
    return aRenderer;
  }
  return nil;
}


@end
