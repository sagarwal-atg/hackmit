#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface HelloWorldLayer : CCScene
{
    bool vrModeOn;
    int vrModeOnRefresh;
    
    float score1;
    float score2;
    int scoretoggle;
    
    int levelTypeHWL;
    
    int playerIDHWL; //distinguished between biker and shooter
    
    NSMutableArray *currentTouchesX;
    NSMutableArray *currentTouchesY;
}

- (void)getPrimaryInstanceSyncData:(NSMutableArray *)uniqueIDs :(NSMutableArray *)physicalProperties :(NSMutableArray *)playerPosition;
- (void)getMotionScore:(float)score :(int)instance;
- (void)restartWithVRMode:(int)mode;
- (void)createObjectInOtherInstance:(NSMutableArray *)objectParams;
- (void)moveOnToNextLevel;

- (instancetype)init;

@end
