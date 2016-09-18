#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AppDelegate : CCAppDelegate {
    NSString *currentchar;
    UITextField *tf;
    float windowWidth;
    float windowHeight;
    bool vrModeOnAD;
}

- (void)addVRComponents;
- (void)startTextInput;
- (void)removeVRComponents;
-(void)updateVRModeAD:(int)mode;

@end