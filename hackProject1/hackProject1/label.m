#import "label.h"

@implementation label
@end

@implementation kc1
+ (id)keyChar1 {
    label *newLabel = nil;
    if ((newLabel = [[super alloc] initWithString:@"M" fontName:@"Avenir-Medium" fontSize:24.0])) {
        newLabel.labelid = 0;
        newLabel.horizontalAlignment = kCTCenterTextAlignment;
        newLabel.labelzorder = -56;
        
        newLabel.labelposX = -99;
        newLabel.labelposY = 71;
        
        newLabel.vrLabel = 1;
    }
    return newLabel;
}
@end

@implementation timer1
+ (id)timerLabel1 {
    label *newLabel = nil;
    if ((newLabel = [[super alloc] initWithString:@"00:00" fontName:@"Avenir-Medium" fontSize:26.0])) {
        newLabel.labelid = 1;
        newLabel.horizontalAlignment = kCTCenterTextAlignment;
        newLabel.labelzorder = -50;
        
        newLabel.labelposX = 0;
        newLabel.labelposY = 85;
        
        newLabel.vrLabel = 2;
    }
    return newLabel;
}
@end
