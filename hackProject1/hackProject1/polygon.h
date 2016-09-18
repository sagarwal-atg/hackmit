#import "CCDrawNode.h"

@interface polygon : CCDrawNode {
    int _polygonid;
    int _polygontype;
    int _polygonzorder;
    bool _polyremoval;
    float _polycolorRed;
    float _polycolorGreen;
    float _polycolorBlue;
    float _polycolorAlpha;
    float _polygonBorderWidth;
    NSMutableArray *pointsOfPolygonX;
    NSMutableArray *pointsOfPolygonY;
}

@property (nonatomic, assign) int polygonid;
@property (nonatomic, assign) int polygontype; //line
@property (nonatomic, assign) int polygonzorder;
@property (nonatomic, assign) bool polyremoval;
@property (nonatomic, assign) float polycolorRed;
@property (nonatomic, assign) float polycolorGreen;
@property (nonatomic, assign) float polycolorBlue;
@property (nonatomic, assign) float polycolorAlpha;
@property (nonatomic, assign) float polygonBorderWidth;
@property (nonatomic, retain) NSMutableArray *pointsOfPolygonX;
@property (nonatomic, retain) NSMutableArray *pointsOfPolygonY;

@end

@interface line1 : polygon {
}
+(id)polygonline;
@end

@interface rect1 : polygon {
}
+(id)polygonsquare;
@end