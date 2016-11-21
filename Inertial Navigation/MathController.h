# import <Foundation/Foundation.h>

@interface MathController : NSObject

+ (NSString *)stringifyDistance:(float) meters;
+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(bool)longFormat;

@ end
