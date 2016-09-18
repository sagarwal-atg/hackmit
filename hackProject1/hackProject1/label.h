#import "CCLabelTTF.h"

@interface label : CCLabelTTF {
    int _labelid;
    int _labelsubid;
    float _labelposX;
    float _labelposY;
    float _labelopacity;
    int _labelzorder;
    bool _vrLabel;
    bool _deleteLabel;
    bool _labelAdjusted;
}

@property (nonatomic, assign) int labelid;
@property (nonatomic, assign) int labelsubid;
@property (nonatomic, assign) float labelposX;
@property (nonatomic, assign) float labelposY;
@property (nonatomic, assign) float labelopacity;
@property (nonatomic, assign) int labelzorder;
@property (nonatomic, assign) bool vrLabel;
@property (nonatomic, assign) bool deleteLabel;
@property (nonatomic, assign) bool labelAdjusted;

@end

@interface kc1 : label {
}
+(id)keyChar1;
@end

@interface timer1 : label {
}
+(id)timerLabel1;
@end
