#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#include <CoreMotion/CoreMotion.h>
#import <CoreFoundation/CoreFoundation.h>
#import "Firebase.h"

@interface HelloWorldLayer2 : CCScene {
    NSMutableArray *objectArray;
    NSMutableArray *objectRemovalArray;
    NSMutableArray *objectTransitionArray;
    NSMutableArray *objectTransitionRemovalArray;
    
    NSMutableArray *statItemArray;
    NSMutableArray *statItemRemovalArray;
    NSMutableArray *labelArray;
    NSMutableArray *labelRemovalArray;
    
    NSMutableArray *allUniqueObjectIds; //essential to keep objects synced across instances of HelloWorldLayer2
    NSMutableArray *tempSyncUniqueIDs;
    NSMutableArray *tempSyncPhysicalProperties;
    NSMutableArray *startSyncUniqueIDs;
    NSMutableArray *startSyncPhysicalProperties;
    float motionScore; //used to compare between engine instances, syncs when not matching
    
    int iPadVarMain;
    float isiPhone6PlusCoeff;
    float playerHeight;
    float mininitialYpos;
    float minYpos;
    float minYposold;
    float minYpospotential;
    float momentumX;
    float momentumY;
    float momentumZ;
    float momentumX2; //can be independently controlled
    float momentumY2; //technically useless
    float momentumZ2; //can be independently controlled
    float momentumactualX;
    float momentumactualY;
    float momentumactualZ;
    float momentumrotationX;
    float momentumrotationY;
    float gravityBuffer1; //used for objects
    float gravityBuffer2; //used for player
    bool tapXon;
    bool tapYon;
    bool tapZon;
    bool tapRon;
    float positionXold;
    float positionYold;
    float positionZold;
    float positionvar1;
    float positionvar2;
    float positionvar3;
    float positionX; //left vs right
    float positionYactual;
    float positionY; //up vs down
    float positionZ; //forward vs backward
    
    float VRoffsetX;
    float VRoffsetY;
    float VRoffsetZ;
    float VReyeDistance;
    
    float P2aimAngle;
    int P2shootTimer;
    int MainGameTimer;
    bool gameState; //0=playing, 1=game done
    int playerCollisionExpirationSafety;
    FIRDatabaseReference *refHWL;
    bool startedListeners;
    int numOfFiredProjectiles;
    int nextProjNeedsIDOfAtLeast;
    float bikeRotationOffset;
    float bikeRotationPreOffset;
    float bikeRPMs;
    float bikeRPMstoUse;
    
    int playerID; //distinguished between biker & shooter
    
    float positionYanimoffset; //used for animations like floating/swimming
    float positionYanimoffsetPotential;
    bool onTopOfFloatingObjects;
    float positionYanimoffsettoggle;
    int positionYanimoffsettimer;
    bool playerInLiquid;
    float rotationX;
    float rotationY;
    float rotationYActual;
    float rotationdragX;
    float rotationdragY;
    float rotationdragsavedX;
    float rotationdragsavedY;
    float FOVvalueinitial;
    float FOVvalue;
    float FOVrotation;
    float FOVrotationrad; //dependent variable
    float FOVrotationvel1;
    bool FOVrotationtoggle;
    float FOVrotationscale;
    bool grabbedobject;
    int grabbedobjectrefresh;
    int grabbedObjectTimer;
    float grabobjectvar1;
    float grabobjectvar2;
    float grabobjectposx;
    float grabobjectposy;
    float grabobjectposz;
    float grabobjectsavedrotation;
    bool grabobjectdrag;
    bool sendMenuLayerLDGDinfo;
    bool playerDoingAction; //refers/controls player action button
    int playerRedoActionTimer;
    int playerFOVchangeTimer;
    int playPunchNoise;
    int playWalkNoiseTimer;
    int playWalkNoiseType;
    bool useWalkingAnimation;
    float walkingSpeed; //default = 1.0
    float baseWalkingSpeed; //default for dev = 1.0, for release = 0.65
    float shadeDistance;
    float targetShadeDistance;
    float targetShadeDistanceDelta;
    float currentViscosityOfLiquid;
    bool cutsceneActiveHWL;
    
    bool playerGravityEnabled;
    bool playerCollisionsEnabled;
    bool bordersEnabled;
    float borderX;
    float borderZ;
    float borderRadius;
    
    //collisions (new style)
    NSMutableArray *objectsPosX;
    NSMutableArray *objectsPosY;
    NSMutableArray *objectsPosZ;
    NSMutableArray *objectsPosXOLD;
    NSMutableArray *objectsPosYOLD;
    NSMutableArray *objectsPosZOLD;
    NSMutableArray *objectsIDs;
    NSMutableArray *objectsIDsOLD;
    NSMutableArray *objectsHeights;
    NSMutableArray *objectsHeightOffset;
    NSMutableArray *objectsHeightsOLD;
    NSMutableArray *objectsHeightOffsetOLD;
    NSMutableArray *objectsRadius;
    NSMutableArray *objectsRadiusOLD;
    NSMutableArray *objectsCollisionType;
    NSMutableArray *objectsCollisionTypeOLD;
    NSMutableArray *objectsGrabbed;
    NSMutableArray *objectsGrabbedOLD;
    
    //gyroscope movement
    bool gyroscopeControlsEnabled;
    CMMotionManager *motionManager;
    float gyroYawOffset;
    float gyroYawOffsetControl;
    float gyroPitchOffset;
    float gyroRollOffset;
    float gyroPREYawOffset;
    float gyroPREPitchOffset;
    float gyroPRERollOffset;
    float gyroVelXOffset;
    float gyroVelYOffset;
    float gyroVelZOffset;
    int gyroQuadrant;
    int gyroQuadrantRefresh;
    
    //vr
    int currentVRmenu;
    int currentVRmenuRefresh;
    bool vrEnabled;
    bool vrPrimaryInstance;
    int delayedSyncTimer;
    float vrGlobalYOffset;
    int btKeyboardConnectedTimer;
    
    //object selection in vr
    int vrosClosestObjectID;
    float vrosSelectionAnimX;
    bool bluetoothNotConnected;
    bool anObjectIsBeingSelected;
    bool anObjectIsBeingSelectedOLD;
    bool anObjectIsBeingSelectedOLDRefresh;
    
    //controls & settings menu in vr
    int vrCSItemSelected;
    float vrCSSelectionAnimX;
    int vrCSItemSelectedMAX;
    bool vrCSinputModeOn;
    float vrCSscrollY;
    int vrCSedVal;
    int vrCSedValRefresh;
    float vrCSedValXOffset;
    
    //polygons
    NSMutableArray *polygonArray;
    NSMutableArray *polygonRemovalArray;
    
    //hack
    int colorID;
    NSMutableArray *randNumberArray;
    int randPickIndex;
    NSMutableArray *randFishNumberArray;
    int randFishPickIndex;
    
    int numOfAsteroids;
    int numOfAsteroidsOld;
    int asteroidSpawnTimer;
    
    //quick load
    int quickLoadQueued;
}

@property (nonatomic, retain) CMMotionManager *motionManager;

- (void)moveXposition:(float)force;
- (void)moveZposition:(float)force;
- (void)navigateMenu:(NSString *)character;
- (void)lookDirection:(float)tapxdiff :(float)tapydiff;
- (void)lookStop;
- (void)setFOV:(float)value;

- (void)setEyeDistance:(float)dist;
- (void)setCutsceneActiveHWL:(int)val;

- (void)bluetoothConnectivityChange:(int)state;
- (void)toggleVRmenuInterface:(int)state;
- (void)applyPrimaryInstanceChanges:(NSMutableArray *)uniqueIDs :(NSMutableArray *)physicalProperties :(NSMutableArray *)playerPosition;
- (void)induceSync;

- (void)createObjectfromOtherInstance:(NSMutableArray *)objectParams;
- (void)resetWorldAndReload;

@end
