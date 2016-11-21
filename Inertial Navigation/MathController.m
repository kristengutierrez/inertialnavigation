#import "MathController.h"



static float const metersInMile = 1609.344;

@implementation MathController


+ (NSString *)stringifyDistance:(float)meters
{
	float unitDivier = metersInMile;
	NSString *unitName = @"mi";

	
	return [NSString stringWithFormat:@"%.2f%@", (meters / unitDivier), unitName];
}

+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat
{ int remainingSeconds = seconds;
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
  @end

