#import "polygon.h"

@implementation polygon
@end

@implementation line1
+ (id)polygonline {
    polygon *currentPolygon = nil;
    if ((currentPolygon = [[super alloc] init])) {
        currentPolygon.polygonid = 0;
        currentPolygon.polygontype = 0; //line
    }
    return currentPolygon;
}
@end

@implementation rect1
+ (id)polygonsquare {
    polygon *currentPolygon = nil;
    if ((currentPolygon = [[super alloc] init])) {
        currentPolygon.polygonid = 1;
        currentPolygon.polygontype = 1; //line
    }
    return currentPolygon;
}
@end
