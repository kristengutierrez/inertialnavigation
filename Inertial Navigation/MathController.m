#import "MathController.h"

@interface MathController ()

@end


@implementation MathController

static float const metersInMile = 1609.344;

+ (NSString *)stringifyDistance:(float)meters {
	float unitDivier = metersInMile;
	NSString *unitName = @"mi";
	return [NSString stringWithFormat:@"%.2f%@", (meters / unitDivier), unitName];
}

+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat {
  int remainingSeconds = seconds;
  int hours = remainingSeconds/3600;
  remainingSeconds = remainingSeconds - hours * 3600;
  int minutes = remainingSeconds / 60;
  remainingSeconds = remainingSeconds - minutes * 60;
  
	if (hours > 0) {
		return [NSString stringWithFormat: @"%ihr %imin %isec", hours, minutes, remainingSeconds];
	} else if (minutes > 0) {
		return [NSString stringWithFormat: @"%imin %isec", minutes, remainingSeconds];
	} else {
		return [NSString stringWithFormat: @"%isec", remainingSeconds];
	}
}

-(CLLocation*) calculateNewLatLon:(CLLocation*) pt by:(float)distance with:(float) heading {
  _latitude = asin(sin(pt.coordinate.latitude)*cos(distance)+cos(pt.coordinate.longitude)*sin(distance)*cos(heading));
  _longitude = fmod(pt.coordinate.latitude-asin(sin(heading)*sin(distance)/cos(pt.coordinate.longitude)) + M_PI, 2*M_PI) - M_PI;
  CLLocation *newLoc = [[CLLocation alloc] initWithLatitude:_latitude longitude:_longitude];
  return(newLoc);
}

-(float) DegreesToRadians:(float) degrees {
  return degrees* M_PI / 180;
}

-(float) RadiansToDegrees:(float) radians {
  return radians * 180 / M_PI;
}

  @end

