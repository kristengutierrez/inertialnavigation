//@import CoreMotion;
#import <CoreMotion/CoreMotion.h>
#import "PedometerViewController.h"

@interface PedoemeterViewController()

@property(strong,nonatomic) CMPedometer *pedometer;
@property(strong,nonatomic) NSMutableArray *stepCountLog;

@end

@implementation PedoemeterViewController

-(void) viewDidLoad {
	[super viewDidLoad];
	
	self.pedometer = [[CMPedometer alloc] init];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
  [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData *pedometerData, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      NSLog(@"data:%@, error:%@", pedometerData, error);
    });
  }];
}

-(void) didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

-(void) stopQueryingPedometer {
	[self.pedometer stopPedometerUpdates];
	[self.stepCountLog removeAllObjects];
}
	
@end
