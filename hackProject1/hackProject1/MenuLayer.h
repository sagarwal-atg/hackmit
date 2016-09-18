#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface MenuLayer : CCNode {
    NSMutableArray *menuItemArray;
    NSMutableArray *menuItemRemovalArray;
    NSMutableArray *iovArray;
    NSMutableArray *iovRemovalArray;
    
    NSMutableArray *currentTouchesX_ML;
    NSMutableArray *currentTouchesY_ML;
    
    int touchStateJoystick;
    int touchStateJump;
    int touchStateVRButton;
    int touchStateAction;
    int touchLDGDMain; //see 3denginegrabobject.png graph
    float touchLDGDtapxorigin;
    float touchLDGDtapx;
    float touchLDGDtapyorigin;
    float touchLDGDtapy;

    float savedrotationX;
    float savedrotationY;
    float currentrotationX;
    float currentrotationY;
    float joystickPosX;
    float joystickPosY;
    float joystickTouchPosX;
    float joystickTouchPosY;
    float joystickRadius;
    int joystickTouchIndex;
    int iPadVar;
    int iPhone5Var;
    
    int jumpTouchIndex;
    float jumpPosX;
    float jumpPosY;
    float jumpButtonRadius;
    
    int vrButtonTouchIndex;
    float vrButtonTouchPosX;
    float vrButtonTouchPosY;
    float vrButtonRadius;
    
    int actionTouchIndex;
    float actionPosX;
    float actionPosY;
    float actionButtonRadius;
    float actionButtonBGRadius;
    
    int LDGDTouchIndex;
    
    bool inventoryMode; //none, active
    float inventorySliderPosX;
    float inventorySliderPosY;
    float inventoryPREAngle;
    float inventoryAngle;
    float inventoryAngleSaved;
    float inventoryAngleOffset;
    int currentInventorySlot;
    int objectsInInventory;
    
    bool dialogVisible;
    CCLabelTTF *dialogText1;
    bool dialogText1present;
    float dialogText1y;
    NSString *savedDialogText;
    
    //cutscenes
    int cutSceneTimer; //runs indefinetly until cutscene ends
    bool cutSceneActive;
    bool cutSceneActiveRefresh;
    CCSprite *cinemaBar1;
    bool cinemaBar1exists;
    bool cinemaBar2exists;
    CCSprite *cinemaBar2;
    float cinemaBar1posy;
    float cinemaBar2posy;
    float cutSceneOpacityCoefficient;

    bool objectBeingHighlightedML;
    bool grabbedObjectML;
    
    float currentTargetDistance;
    float currentPlayerPosY;
    
    float iPhone6PlusScaleOffset;
}

- (void)getGrabbableObjectPossibility:(int)possible; //not possible, possible, already grabbed object
- (void)reciprocatePlayerAction;
- (void)setDialogText:(NSString *)textString;

- (void)getObjectBeingHighlighted:(bool)val;
- (void)getObjectGrabbed:(bool)val;

- (void)touchBeganCustom:(NSMutableArray *)activeTouchesX :(NSMutableArray *)activeTouchesY :(int)touchIndex;
- (void)touchMovedCustom:(NSMutableArray *)activeTouchesX :(NSMutableArray *)activeTouchesY :(int)touchIndex;
- (void)touchEndedCustom:(NSMutableArray *)activeTouchesX :(NSMutableArray *)activeTouchesY :(int)touchIndex;

@end