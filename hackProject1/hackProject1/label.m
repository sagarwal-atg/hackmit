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