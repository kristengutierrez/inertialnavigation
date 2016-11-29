# import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MathController : NSObject

+ (NSString *)stringifyDistance:(float) meters;
+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(bool)longFormat;

@property double latitude;
@property double longitude;
@property float	heading;
@property float distance;

-(CLLocation*) calculateNewLatLon:(CLLocation*) pt by:(float)distance with:(float) heading;

-(float) DegreesToRadians:(float) degrees;

-(float) RadiansToDegrees:(float) radians;

@ end
