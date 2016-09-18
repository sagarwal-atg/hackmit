#import "HelloWorldLayer.h"
#import "HelloWorldLayer2.h"
#import "MenuLayer.h"
#import "AppDelegate.h"
#import "statItem.h"
#import "polygon.h"
#import "object.h"
#import "OALSimpleAudio.h"
#import "CCCropNode.h"
#import "label.h"

@implementation HelloWorldLayer2
@synthesize motionManager;

- (void)resetWorldAndReload {
    printf("RESET WORLD & RELOAD: %i\n",vrPrimaryInstance);
    
    //reset part
    
    for (CCSprite *sprite in objectArray) {
        [self removeChild:sprite cleanup:YES];
    }
    objectArray = nil;
    for (CCSprite *sprite in objectTransitionArray) {
        [self removeChild:sprite cleanup:YES];
    }
    objectTransitionArray = nil;
    for (CCSprite *sprite in statItemArray) {
        [self removeChild:sprite cleanup:YES];
    }
    statItemArray = nil;
    for (CCLabelTTF *sprite in labelArray) {
        [self removeChild:sprite cleanup:YES];
    }
    labelArray = nil;
    
    objectArray = [[NSMutableArray alloc]init ];
    objectTransitionArray = [[NSMutableArray alloc]init ];
    allUniqueObjectIds = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0], nil]; //prevents any object from having 0 as a unique ID
    polygonArray = [[NSMutableArray alloc]init ];
    statItemArray = [[NSMutableArray alloc]init ];
    labelArray = [[NSMutableArray alloc]init ];
    
    tempSyncUniqueIDs = [[NSMutableArray alloc] init];
    tempSyncPhysicalProperties = [[NSMutableArray alloc] init];
    startSyncUniqueIDs = [[NSMutableArray alloc] init];
    startSyncPhysicalProperties = [[NSMutableArray alloc] init];
    
    positionX = 0;
    positionY = minYpos;
    positionZ = 0;
    
    //player offsets
    playerID = 1;
    if (playerID == 0) {
        positionZ = 0;
        positionY = minYpos;
    } else {
        positionY = 55;
        positionZ = 0;
    }
    
    rotationX = 0.01;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        FOVvalue = 4.2;
    } else {
        FOVvalue = 2.18;
    }
    FOVvalueinitial = FOVvalue;
    FOVrotation = 0;
    useWalkingAnimation = 1;
    
    //reload part
    levelTypeHWL2 = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"levelType"];
    
    bordersEnabled = 0;
    borderX = 1000;
    borderZ = 1000;
    useWalkingAnimation = 0;
    
    allUniqueObjectIds = [[NSMutableArray alloc] init];
    
    //loading generated objects
    NSMutableArray *generatedObjects = [[NSUserDefaults standardUserDefaults] objectForKey:@"generatedObjects"];
    for (int int1 = 0; int1 < generatedObjects.count; int1++) {
        NSMutableArray *objectComponents = [generatedObjects objectAtIndex:int1];
        NSString *objectName = [objectComponents objectAtIndex:0];
        object *objectNum1 = nil;
        
        //setting up classes
        if ([objectName isEqualToString:@"pool1"]) {
            objectNum1 = [pool1 pool1test];
        } else if ([objectName isEqualToString:@"pool2"]) {
            objectNum1 = [pool2 pool2test];
        } else if ([objectName isEqualToString:@"pool3"]) {
            objectNum1 = [pool3 pool3test];
        } else if ([objectName isEqualToString:@"spaceEnv1"]) {
            objectNum1 = [spaceEnv1 spaceShine];
        } else if ([objectName isEqualToString:@"rock3"]) {
            objectNum1 = [rock3 rockAsteroid1];
        } else if ([objectName isEqualToString:@"rock4"]) {
            objectNum1 = [rock4 rockAsteroid2];
        } else if ([objectName isEqualToString:@"star1"]) {
            objectNum1 = [star1 star1White];
        } else if ([objectName isEqualToString:@"spaceEnv2"]) {
            objectNum1 = [spaceEnv2 spaceShine2];
        } else if ([objectName isEqualToString:@"star2"]) {
            objectNum1 = [star2 star2Planet];
        } else if ([objectName isEqualToString:@"star2ring"]) {
            objectNum1 = [star2ring star2PlanetRing];
        } else if ([objectName isEqualToString:@"rock5"]) {
            objectNum1 = [rock5 rockAsteroid3];
        } else if ([objectName isEqualToString:@"rock6"]) {
            objectNum1 = [rock6 rockAsteroid4];
        } else if ([objectName isEqualToString:@"chair1"]) {
            objectNum1 = [chair1 chairRed1];
        } else if ([objectName isEqualToString:@"wheel1"]) {
            objectNum1 = [wheel1 wheelDriver1];
        }
        
        //separating sub-object systems with regular objects
        if ([objectName isEqualToString:@"tree1"] || [objectName isEqualToString:@"tree2"] || [objectName isEqualToString:@"rcoral1"] || [objectName isEqualToString:@"fcoral2"]) {
            objectNum1.posX = [[objectComponents objectAtIndex:1] intValue];
            objectNum1.posZ = [[objectComponents objectAtIndex:2] intValue];
            objectNum1.subObjectComponents = [[NSMutableArray alloc] initWithArray:[objectComponents objectAtIndex:3]];
            objectNum1.randomflipped = [[objectComponents objectAtIndex:4] boolValue];
            
            if ([objectName isEqualToString:@"fcoral2"]) {
                objectNum1.colorExposeID = [[objectComponents objectAtIndex:5] intValue];
                objectNum1.standardScale = [[objectComponents objectAtIndex:6] floatValue]; //stores relative size value
            }
        } else if ([objectName isEqualToString:@"seaweed1"]) {
            objectNum1.posX = [[objectComponents objectAtIndex:1] intValue];
            if ([[objectComponents objectAtIndex:4] floatValue] != 0) {
                objectNum1.posY = [[objectComponents objectAtIndex:4] floatValue] + objectNum1.minyposition;
            } else {
                objectNum1.posY = objectNum1.minyposition;
            }
            objectNum1.posZ = [[objectComponents objectAtIndex:2] intValue];
            objectNum1.pospreXoffset = objectNum1.posX;
            objectNum1.pospreZoffset = objectNum1.posZ;
            objectNum1.randomflipped = [[objectComponents objectAtIndex:3] boolValue];
            objectNum1.standardScale = [[objectComponents objectAtIndex:5] floatValue];
            objectNum1.audiolengthcount = [[objectComponents objectAtIndex:6] boolValue];
            objectNum1.particleDilationRate = [[objectComponents objectAtIndex:7] floatValue];
        } else if ([objectName isEqualToString:@"fcoral1"]) {
            objectNum1.posX = [[objectComponents objectAtIndex:1] intValue];
            objectNum1.posY = [[objectComponents objectAtIndex:4] floatValue];
            objectNum1.posZ = [[objectComponents objectAtIndex:2] intValue];
            objectNum1.polygonRadius = [[objectComponents objectAtIndex:5] floatValue];
            objectNum1.polygonSides = [[objectComponents objectAtIndex:6] intValue];
            objectNum1.colorExposeID = [[objectComponents objectAtIndex:7] intValue];
        } else if ([objectName isEqualToString:@"spaceEnv1"]) {
            objectNum1.pospreXoffset = [[objectComponents objectAtIndex:1] floatValue];
            objectNum1.pospreYoffset = [[objectComponents objectAtIndex:4] floatValue];
            objectNum1.pospreZoffset = [[objectComponents objectAtIndex:2] floatValue];
            objectNum1.standardScale = [[objectComponents objectAtIndex:5] floatValue];
            objectNum1.customOpacity = objectNum1.customOpacity*((80.0-[[objectComponents objectAtIndex:5] floatValue])/80.0);
            objectNum1.colorExposeID = [[objectComponents objectAtIndex:6] intValue];
        } else if ([objectName isEqualToString:@"spaceEnv2"]) {
            objectNum1.posX = [[objectComponents objectAtIndex:1] floatValue];
            objectNum1.posY = [[objectComponents objectAtIndex:4] floatValue];
            objectNum1.posZ = [[objectComponents objectAtIndex:2] floatValue];
            objectNum1.standardScale = [[objectComponents objectAtIndex:5] floatValue];
            objectNum1.customOpacity = objectNum1.customOpacity*((80.0-[[objectComponents objectAtIndex:5] floatValue])/80.0);
            objectNum1.colorExposeID = [[objectComponents objectAtIndex:6] intValue];
        } else if ([objectName isEqualToString:@"rock3"] || [objectName isEqualToString:@"rock4"] || [objectName isEqualToString:@"rock5"] || [objectName isEqualToString:@"rock6"]) {
            objectNum1.posX = [[objectComponents objectAtIndex:1] floatValue];
            objectNum1.posY = [[objectComponents objectAtIndex:4] floatValue];
            objectNum1.posZ = [[objectComponents objectAtIndex:2] floatValue];
            objectNum1.randomflipped = [[objectComponents objectAtIndex:3] boolValue];
            objectNum1.polygonColorRed = [[objectComponents objectAtIndex:6] floatValue];
            
            float scaleCoeff = [[objectComponents objectAtIndex:5] floatValue];
            objectNum1.standardScale = 0.4+(scaleCoeff*1.4);
            objectNum1.objecttoplayerradius = objectNum1.objecttoplayerradius*objectNum1.standardScale;
            objectNum1.objecttoobjectradius = objectNum1.objecttoobjectradius*objectNum1.standardScale;
        } else if ([objectName isEqualToString:@"star1"]) {
            objectNum1.pospreXoffset = [[objectComponents objectAtIndex:1] floatValue];
            objectNum1.pospreYoffset = [[objectComponents objectAtIndex:4] floatValue];
            objectNum1.pospreZoffset = [[objectComponents objectAtIndex:2] floatValue];
            objectNum1.standardScale = [[objectComponents objectAtIndex:5] floatValue];
            objectNum1.customOpacity = [[objectComponents objectAtIndex:7] floatValue];
            
            objectNum1.particleDilationRate = [[objectComponents objectAtIndex:6] floatValue];
            if (objectNum1.particleDilationRate != 0) {
                objectNum1.audiolengthcount = 1; //indicates twinkling enabled
            }
        } else if ([objectName isEqualToString:@"star2"] || [objectName isEqualToString:@"star2ring"]) {
            objectNum1.posX = [[objectComponents objectAtIndex:1] floatValue];
            objectNum1.posY = [[objectComponents objectAtIndex:4] floatValue];
            objectNum1.posZ = [[objectComponents objectAtIndex:2] floatValue];
            objectNum1.standardScale = [[objectComponents objectAtIndex:5] floatValue];
            objectNum1.randomflipped = [[objectComponents objectAtIndex:3] boolValue];
            objectNum1.colorExposeID = [[objectComponents objectAtIndex:6] intValue];
        } else if ([objectName isEqualToString:@"pool1"] || [objectName isEqualToString:@"pool2"] || [objectName isEqualToString:@"pool3"]) {
            /*if (playerID == 0) {
                objectNum1.pospreXoffset = [[objectComponents objectAtIndex:1] intValue]+0.01;
                objectNum1.pospreYoffset = [[objectComponents objectAtIndex:4] intValue];
                objectNum1.pospreZoffset = 0;
            } else {
                objectNum1.pospreXoffset = [[objectComponents objectAtIndex:1] intValue]+0.01;
                objectNum1.pospreYoffset = -25;
                objectNum1.pospreZoffset = [[objectComponents objectAtIndex:2] intValue]+0.01;
            }*/
            objectNum1.pospreXoffset = [[objectComponents objectAtIndex:1] intValue];
            objectNum1.pospreYoffset = [[objectComponents objectAtIndex:4] intValue];
            objectNum1.pospreZoffset = [[objectComponents objectAtIndex:2] intValue];
            
            if (playerID == 1) {
                objectNum1.actual2DZorder = 80;
            }
        } else if ([objectName isEqualToString:@"wheel1"] || [objectName isEqualToString:@"chair1"]) {
            objectNum1.pospreXoffset = [[objectComponents objectAtIndex:1] intValue];
            objectNum1.pospreYoffset = [[objectComponents objectAtIndex:4] intValue];
            objectNum1.pospreZoffset = [[objectComponents objectAtIndex:2] intValue];
            
            if (playerID == 1) {
                objectNum1.actual2DZorder = 80;
            }
        } else {
            objectNum1.posX = [[objectComponents objectAtIndex:1] intValue];
            if ([[objectComponents objectAtIndex:4] intValue] != 0 || levelTypeHWL2 == 2) {
                objectNum1.posY = [[objectComponents objectAtIndex:4] intValue];
            } else {
                objectNum1.posY = objectNum1.minyposition;
            }
            if (levelTypeHWL2 == 2) {
                if ([objectName isEqualToString:@"colorup1"] || [objectName isEqualToString:@"colorup2"]) {
                    objectNum1.posY = 0;
                }
            }
            objectNum1.posZ = [[objectComponents objectAtIndex:2] intValue];
            objectNum1.randomflipped = [[objectComponents objectAtIndex:3] boolValue];
            if (objectNum1.objectid >= 33 && objectNum1.objectid <= 37) {
                objectNum1.FGOposXmomentum = objectNum1.posX;
                objectNum1.FGOposYmomentum = objectNum1.posY;
                objectNum1.FGOposZmomentum = objectNum1.posZ;
            }
        }
        objectNum1.opacity = 0;
        /*if (<#condition#>) { //only quick loads scenery components
         <#statements#>
         } else {
         
         }*/
        
        [self addChild:objectNum1];
        [objectTransitionArray addObject:objectNum1];
        
        objectName = nil;
        objectComponents = nil;
    }
    
    //initial non-randomized stage objects
    if (levelTypeHWL2 == 2) {
        shadeDistance = 200;
        targetShadeDistance = 50000;
        targetShadeDistanceDelta = 0;
        
        //ground & sky
        statItem *item2 = nil;
        item2 = [sky_3 skyItemSpace];
        item2.opacity = 0;
        [self addChild:item2];
        [statItemArray addObject:item2];
        
        statItem *item1 = nil;
        item1 = [ground_3 groundItemSpace];
        item1.opacity = 0;
        [self addChild:item1];
        [statItemArray addObject:item1];
        
        item1.scaleX = item1.scaleX*isiPhone6PlusCoeff;
        item2.scaleX = item2.scaleX*isiPhone6PlusCoeff;
        item1.scaleY = item1.scaleY*isiPhone6PlusCoeff;
        item2.scaleY = item2.scaleY*isiPhone6PlusCoeff;
        
        /*for (int int2 = 0; int2 <= 0; int2++) {
            if (vrPrimaryInstance == 1) {
                object *horizNum2 = nil;
                horizNum2 = [vr7 vrElement7];
                horizNum2.opacity = 0;
                [self addChild:horizNum2];
                [objectTransitionArray addObject:horizNum2];
            } else {
                object *horizNum2 = nil;
                horizNum2 = [vr7_2 vrElement7_2];
                horizNum2.opacity = 0;
                [self addChild:horizNum2];
                [objectTransitionArray addObject:horizNum2];
            }
        }*/
        
        if (playerID == 1) {
            for (int int2 = 0; int2 < 6; int2++) {
                object *objectNum1 = nil;
                objectNum1 = [gun1 gunPart1];
                objectNum1.pospreYoffset = -29.0-((float)int2*2.2);
                objectNum1.FGOposXmomentum = (((float)int2*14.0)+63.0);
                objectNum1.pospreXoffset = (cosf(P2aimAngle)*(((float)int2*13.0)+66.0));
                objectNum1.pospreZoffset = (sinf(P2aimAngle)*(((float)int2*13.0)+66.0));
                objectNum1.objecttag = int2;
                [self addChild:objectNum1];
                [objectTransitionArray addObject:objectNum1];
                
                object *horizNum2 = nil;
                horizNum2 = [vr2 vrElement2];
                [self addChild:horizNum2];
                [objectTransitionArray addObject:horizNum2];
            }
        }
    }
}

- (void)deviceOrientationDidChange {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        gyroQuadrant = 1;
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        gyroQuadrant = 2;
    }
}

- (void)createObjectfromOtherInstance:(NSMutableArray *)objectParams {
    NSString *objName = [objectParams objectAtIndex:0];
    
    if ([objName isEqualToString:@"part1"]) {
        object *newObject = nil;
        newObject = [part1 particleDistCloud];
        newObject.opacity = 0;
        newObject.posX = positionX;
        newObject.posY = newObject.mininitialyposition;
        newObject.posZ = positionZ;
        newObject.posXmomentum = [[objectParams objectAtIndex:1] floatValue];
        newObject.posYmomentum = [[objectParams objectAtIndex:2] floatValue];
        newObject.posZmomentum = [[objectParams objectAtIndex:3] floatValue];
        newObject.standardScale = [[objectParams objectAtIndex:4] floatValue];
        newObject.randomflipped = [[objectParams objectAtIndex:5] intValue];
        newObject.polygonRadius = [[objectParams objectAtIndex:6] floatValue];
        newObject.audiorange = [[objectParams objectAtIndex:7] floatValue];
        newObject.particleDilationRate = [[objectParams objectAtIndex:8] floatValue];
        [self addChild:newObject];
        [objectTransitionArray addObject:newObject];
    } else if ([objName isEqualToString:@"part2"]) {
        object *newObject = nil;
        newObject = [part2 particleWaterParticle];
        newObject.opacity = 0;
        newObject.posX = positionX;
        newObject.posY = newObject.mininitialyposition;
        newObject.posZ = positionZ;
        newObject.posXmomentum = [[objectParams objectAtIndex:1] floatValue];
        newObject.posYmomentum = [[objectParams objectAtIndex:2] floatValue];
        newObject.posZmomentum = [[objectParams objectAtIndex:3] floatValue];
        newObject.standardScale = [[objectParams objectAtIndex:4] floatValue];
        newObject.randomflipped = [[objectParams objectAtIndex:5] intValue];
        newObject.polygonRadius = [[objectParams objectAtIndex:6] floatValue];
        newObject.audiorange = [[objectParams objectAtIndex:7] floatValue];
        newObject.particleDilationRate = [[objectParams objectAtIndex:8] floatValue];
        [self addChild:newObject];
        [objectTransitionArray addObject:newObject];
    }
    
    objName = nil;
}

- (void)quickSaveVars{
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"quickLoad"];
    NSMutableArray *varsArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:positionX], [NSNumber numberWithFloat:positionY], [NSNumber numberWithFloat:positionZ], [NSNumber numberWithFloat:momentumX], [NSNumber numberWithFloat:momentumY], [NSNumber numberWithFloat:momentumZ], nil];
    [varsArray addObject:[NSNumber numberWithFloat:minYpos]]; //index = 6
    [varsArray addObject:[NSNumber numberWithFloat:positionYanimoffset]]; //index = 7
    [varsArray addObject:[NSNumber numberWithFloat:positionYanimoffsettoggle]]; //index = 8
    [varsArray addObject:[NSNumber numberWithBool:onTopOfFloatingObjects]]; //index = 9
    [varsArray addObject:[NSNumber numberWithBool:playerInLiquid]]; //index = 10
    [varsArray addObject:[NSNumber numberWithInt:positionYanimoffsettimer]]; //index = 11
    [varsArray addObject:[NSNumber numberWithBool:grabbedobject]]; //index = 12
    [varsArray addObject:[NSNumber numberWithInt:grabbedObjectTimer]]; //index = 13
    [varsArray addObject:[NSNumber numberWithBool:playerDoingAction]]; //index = 14
    [varsArray addObject:[NSNumber numberWithInt:playerRedoActionTimer]]; //index = 15
    [varsArray addObject:[NSNumber numberWithInt:playerFOVchangeTimer]]; //index = 16
    [varsArray addObject:[NSNumber numberWithInt:playPunchNoise]]; //index = 17
    [varsArray addObject:[NSNumber numberWithFloat:shadeDistance]]; //index = 18
    [varsArray addObject:[NSNumber numberWithFloat:targetShadeDistance]]; //index = 19
    [varsArray addObject:[NSNumber numberWithFloat:targetShadeDistanceDelta]]; //index = 20
    [varsArray addObject:[NSNumber numberWithFloat:hoverAnimX]]; //index = 21
    [varsArray addObject:[NSNumber numberWithInt:colorID]]; //index = 22
    [varsArray addObject:[NSNumber numberWithBool:collectingColorup]]; //index = 23
    [varsArray addObject:[NSNumber numberWithFloat:collectingColorupTrans]]; //index = 24
    [varsArray addObject:[NSNumber numberWithFloat:colorupHypo]]; //index = 25
    [varsArray addObject:[NSNumber numberWithBool:colorupFadeExists]]; //index = 26
    [varsArray addObject:[NSNumber numberWithFloat:rotationX]]; //index = 27
    [varsArray addObject:[NSNumber numberWithFloat:rotationY]]; //index = 28
    [varsArray addObject:[NSNumber numberWithFloat:mininitialYpos]]; //index = 29
    [varsArray addObject:[NSNumber numberWithFloat:minYposold]]; //index = 30
    [varsArray addObject:[NSNumber numberWithFloat:minYpospotential]]; //index = 31
    [[NSUserDefaults standardUserDefaults] setObject:varsArray forKey:@"varsArray"];
    varsArray = nil;
}

- (float)randomNumber {
    float randnumber = [[randNumberArray objectAtIndex:randPickIndex] floatValue];
    randPickIndex++;
    if (randPickIndex >= randNumberArray.count) {
        randPickIndex = 0;
    }
    
    return randnumber;
}

- (float)randomNumberFish {
    float randnumber = [[randFishNumberArray objectAtIndex:randFishPickIndex] floatValue];
    randFishPickIndex++;
    if (randFishPickIndex >= randFishNumberArray.count) {
        randFishPickIndex = 0;
    }
    
    return randnumber;
}

- (void)setCutsceneActiveHWL:(int)val {
    cutsceneActiveHWL = val;
}

- (void)induceSync {
    for (CCSprite *sprite in objectArray) {
        object *currentObject = (object *)sprite;
        if (currentObject.objectusescollisions == 1 && currentObject.objectonhorizon == 0 && currentObject.isasubobject == 0) {
            //queues object for sync
            if (vrPrimaryInstance == 1 && vrEnabled != 0) { //primary instance
                NSMutableArray *physicalProperties = [[NSMutableArray alloc] init];
                [physicalProperties addObject:[NSNumber numberWithFloat:currentObject.posX]];
                [physicalProperties addObject:[NSNumber numberWithFloat:currentObject.posY]];
                [physicalProperties addObject:[NSNumber numberWithFloat:currentObject.posZ]];
                [physicalProperties addObject:[NSNumber numberWithFloat:currentObject.posXmomentum]];
                [physicalProperties addObject:[NSNumber numberWithFloat:currentObject.posYmomentum]];
                [physicalProperties addObject:[NSNumber numberWithFloat:currentObject.posZmomentum]];
                [physicalProperties addObject:[NSNumber numberWithFloat:currentObject.rotationoffsetx2]];
                [startSyncPhysicalProperties addObject:physicalProperties];
                [startSyncUniqueIDs addObject:[NSNumber numberWithInt:currentObject.uniqueobjectid]];
            }
        }
    }
}

- (void)applyPrimaryInstanceChanges:(NSMutableArray *)uniqueIDs :(NSMutableArray *)physicalProperties :(NSMutableArray *)playerPosition { //this function should only run on non-primary instance of HelloWorldLayer2
    
    positionX = [[playerPosition objectAtIndex:0] floatValue];
    positionY = [[playerPosition objectAtIndex:1] floatValue];
    positionZ = [[playerPosition objectAtIndex:2] floatValue];
    rotationX = [[playerPosition objectAtIndex:3] floatValue];
    rotationY = [[playerPosition objectAtIndex:4] floatValue];
    colorID = [[playerPosition objectAtIndex:5] intValue];
    collectingColorup = [[playerPosition objectAtIndex:6] boolValue];
    collectingColorupTrans = [[playerPosition objectAtIndex:7] floatValue];
    
    tempSyncUniqueIDs = uniqueIDs;
    tempSyncPhysicalProperties = physicalProperties;
}

- (void)bluetoothConnectivityChange:(int)state {
    if (state == 1) { //keyboard not connected
        bluetoothNotConnected = 1;
    } else { //keyboard connected (or user taps screen)
        if (currentVRmenu == -2) {
            currentVRmenu = 0;
        }
        bluetoothNotConnected = 0;
    }
}

- (void)toggleVRmenuInterface:(int)state {
    if (vrEnabled == 1 && vrCSinputModeOn == 0) {
        if (currentVRmenu == -1) { //toggles help/controls menu
            currentVRmenu = 0;
        } else {
            currentVRmenu = state;
        }
    }
}

- (void)setEyeDistance:(float)dist {
    VReyeDistance = dist;
    if (VReyeDistance != 0) {
        vrEnabled = 1;
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        vrGlobalYOffset = winSize.height/2.0;
    }
    if (VReyeDistance <= 0) {
        vrPrimaryInstance = 1; //sets primary instance to be left eye
    }
    vrCSedVal = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"vrCSedVal"];
}

-(BOOL)iPhone6Plus{
    if ([UIScreen mainScreen].scale > 2.1) return YES; //iPhone 6+
    
    return NO;
}

- (void)navigateMenu:(NSString *)character {
    if (currentVRmenu == -1 && vrCSinputModeOn == 0) {
        if ([character isEqualToString:@"w"] || [character isEqualToString:@"W"]) { //up
            vrCSItemSelected--;
            if (vrCSItemSelected < 0) {
                vrCSItemSelected = vrCSItemSelectedMAX;
            }
        } else if ([character isEqualToString:@"s"] || [character isEqualToString:@"S"]) { //down
            vrCSItemSelected++;
            if (vrCSItemSelected > vrCSItemSelectedMAX) {
                vrCSItemSelected = 0;
            }
        } else if ([character isEqualToString:@"a"] || [character isEqualToString:@"A"]) { //left
            if (vrCSItemSelected == vrCSItemSelectedMAX-1) { //vr eye dist
                vrCSedVal--;
                if (vrCSedVal < -3) {
                    vrCSedVal = -3;
                }
            }
        } else if ([character isEqualToString:@"d"] || [character isEqualToString:@"D"]) { //right
            if (vrCSItemSelected == vrCSItemSelectedMAX-1) { //vr eye dist
                vrCSedVal++;
                if (vrCSedVal > 3) {
                    vrCSedVal = 3;
                }
            }
        } else if ([character isEqualToString:@"e"] || [character isEqualToString:@"E"]) { //select
            if (vrCSItemSelected < vrCSItemSelectedMAX-1) { //not vr eye distance thing
                vrCSinputModeOn = 1;
                
                //changes menu caption image
                for (CCSprite *sprite in objectArray) {
                    object *currentObject = (object *)sprite;
                    if (currentObject.vrUIelement == 1 && [currentObject isKindOfClass: [vr5 class]]) {
                        [currentObject setTexture:[CCTexture textureWithFile:@"title_instr2.png"]];
                    }
                }
            }else if (vrCSItemSelected == vrCSItemSelectedMAX) { //reset button
                vrCSItemSelected = 0;
                
                vrCSedVal = 0;
                
                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_closeopen_default"] forKey:@"key_closeopen"];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_pickupdrop_default"] forKey:@"key_pickupdrop"];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_throwinteract_default"] forKey:@"key_throwinteract"];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveforward_default"] forKey:@"key_moveforward"];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_movebackward_default"] forKey:@"key_movebackward"];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveleft_default"] forKey:@"key_moveleft"];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveright_default"] forKey:@"key_moveright"];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_jump_default"] forKey:@"key_jump"];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_rotateleft_default"] forKey:@"key_rotateleft"];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_rotateright_default"] forKey:@"key_rotateright"];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_exitvr_default"] forKey:@"key_exitvr"];
                
                for (CCLabelTTF *sprite in labelArray) {
                    label *currentLabel = (label *)sprite;
                    if (currentLabel.labelid == 0) {
                        if (currentLabel.labelsubid == 0) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_closeopen"]];
                        } else if (currentLabel.labelsubid == 1) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_pickupdrop"]];
                        } else if (currentLabel.labelsubid == 2) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_throwinteract"]];
                        } else if (currentLabel.labelsubid == 3) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveforward"]];
                        } else if (currentLabel.labelsubid == 4) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_movebackward"]];
                        } else if (currentLabel.labelsubid == 5) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveleft"]];
                        } else if (currentLabel.labelsubid == 6) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveright"]];
                        } else if (currentLabel.labelsubid == 7) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_jump"]];
                        } else if (currentLabel.labelsubid == 8) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_rotateleft"]];
                        } else if (currentLabel.labelsubid == 9) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_rotateright"]];
                        } else if (currentLabel.labelsubid == 10) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_exitvr"]];
                        }
                    }
                }
            }
        }
    } else if (currentVRmenu == -1 && vrCSinputModeOn != 0) { //inputting characters
        if (character != NULL) {
            vrCSinputModeOn = 0;
            
            //changes menu caption image
            for (CCSprite *sprite in objectArray) {
                object *currentObject = (object *)sprite;
                if (currentObject.vrUIelement == 1 && [currentObject isKindOfClass: [vr5 class]]) {
                    [currentObject setTexture:[CCTexture textureWithFile:@"title_instr1.png"]];
                }
            }
            
            //saves input preferences
            if (vrPrimaryInstance == 1) {
                if (vrCSItemSelected == 0) { //open/close
                    [[NSUserDefaults standardUserDefaults] setObject:character forKey:@"key_closeopen"];
                } else if (vrCSItemSelected == 1) {
                    [[NSUserDefaults standardUserDefaults] setObject:character forKey:@"key_pickupdrop"];
                } else if (vrCSItemSelected == 2) {
                    [[NSUserDefaults standardUserDefaults] setObject:character forKey:@"key_throwinteract"];
                } else if (vrCSItemSelected == 3) {
                    [[NSUserDefaults standardUserDefaults] setObject:character forKey:@"key_moveforward"];
                } else if (vrCSItemSelected == 4) {
                    [[NSUserDefaults standardUserDefaults] setObject:character forKey:@"key_movebackward"];
                } else if (vrCSItemSelected == 5) {
                    [[NSUserDefaults standardUserDefaults] setObject:character forKey:@"key_moveleft"];
                } else if (vrCSItemSelected == 6) {
                    [[NSUserDefaults standardUserDefaults] setObject:character forKey:@"key_moveright"];
                } else if (vrCSItemSelected == 7) {
                    [[NSUserDefaults standardUserDefaults] setObject:character forKey:@"key_jump"];
                } else if (vrCSItemSelected == 8) {
                    [[NSUserDefaults standardUserDefaults] setObject:character forKey:@"key_rotateleft"];
                } else if (vrCSItemSelected == 9) {
                    [[NSUserDefaults standardUserDefaults] setObject:character forKey:@"key_rotateright"];
                } else if (vrCSItemSelected == 10) {
                    [[NSUserDefaults standardUserDefaults] setObject:character forKey:@"key_exitvr"];
                }
            }
            
            //updates current character
            if (currentVRmenu == -1) {
                for (CCLabelTTF *sprite in labelArray) {
                    label *currentLabel = (label *)sprite;
                    if (currentLabel.labelsubid == vrCSItemSelected && currentLabel.labelid == 0) {
                        if (vrCSItemSelected == 0) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_closeopen"]];
                        } else if (vrCSItemSelected == 1) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_pickupdrop"]];
                        } else if (vrCSItemSelected == 2) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_throwinteract"]];
                        } else if (vrCSItemSelected == 3) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveforward"]];
                        } else if (vrCSItemSelected == 4) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_movebackward"]];
                        } else if (vrCSItemSelected == 5) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveleft"]];
                        } else if (vrCSItemSelected == 6) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveright"]];
                        } else if (vrCSItemSelected == 7) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_jump"]];
                        } else if (vrCSItemSelected == 8) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_rotateleft"]];
                        } else if (vrCSItemSelected == 9) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_rotateright"]];
                        } else if (vrCSItemSelected == 10) {
                            [currentLabel setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_exitvr"]];
                        }
                    }
                }
            }
        }
    } else if (currentVRmenu == 0 && playerID == 1) {
        if (character != NULL) {
            //shoot missile
            if (P2shootTimer <= 0) {
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *objectNum1 = nil;
                    objectNum1 = [gun2 gunMissile];
                    objectNum1.posY = positionY-46.5;
                    objectNum1.posX = positionX+(cosf(P2aimAngle)*130.0);
                    objectNum1.posZ = positionZ+(sinf(P2aimAngle)*130.0);
                    objectNum1.posXmomentum = (cosf(P2aimAngle)*130.0)*0.12;
                    objectNum1.posZmomentum = (sinf(P2aimAngle)*130.0)*0.12;
                    
                    int randCol1 = [self randomNumber]*125.0;
                    int randCol2 = [self randomNumber]*125.0;
                    int randCol3 = [self randomNumber]*125.0;
                    objectNum1.polygonColorRed = (float)randCol1+130.0;
                    objectNum1.polygonColorGreen = (float)randCol2+130.0;
                    objectNum1.polygonColorBlue = (float)randCol3+130.0;
                    
                    [self addChild:objectNum1];
                    [objectTransitionArray addObject:objectNum1];
                }
                P2shootTimer = 100;
            }
        }
    }
}

- (void)moveXposition:(float)force {
    if (currentVRmenu == 0 && collectingColorup == 0) {
        if (vrEnabled == 0) {
            if (force != 0) {
                if (levelTypeHWL2 == 1) {
                    momentumX = momentumX + (((force*baseWalkingSpeed) - momentumX)/20.0);
                } else {
                    momentumX = momentumX + (((force*baseWalkingSpeed) - momentumX)/9.0);
                }
                tapXon = 1;
            } else {
                tapXon = 0;
            }
        } else {
            momentumX = force*baseWalkingSpeed;
            if (momentumZ == 0) {
                momentumZ = 0.0001;
            }
        }
    }
}

- (void)moveYposition:(bool)force {
    if (currentVRmenu == 0 && collectingColorup == 0) {
        if (force != 0) { //up
            tapYon = 1;
            if (playerGravityEnabled == 1) {
                if (positionY <= (minYposold-momentumY) && positionY >= (minYposold-momentumY)) {
                    if (playerInLiquid == 1 && positionYanimoffset > -8.5 && positionYanimoffsettimer > 30) {
                        momentumY = 3.0;
                    } else if (playerInLiquid == 0) {
                        if (levelTypeHWL2 == 1) {
                            momentumY = 2.5;
                        } else if (levelTypeHWL2 != 2) {
                            momentumY = 4.0;
                        }
                    }
                }
            } else {
                momentumY = 3.5;
            }
            
            //vr safety
            if (vrEnabled != 0) {
                if (playerInLiquid != 0 && positionY <= minYpos+1.0 && onTopOfFloatingObjects == 0) {
                    jumpInLiquidQueued = 1;
                } else {
                    tapYon = 0;
                }
            }
        } else {
            tapYon = 0;
        }
    }
}

- (void)moveZposition:(float)force {
    if (currentVRmenu == 0 && collectingColorup == 0) {
        if (vrEnabled == 0) {
            if (force != 0) {
                if (levelTypeHWL2 == 1) {
                    momentumZ = momentumZ + (((force*baseWalkingSpeed) - momentumZ)/20.0);
                } else {
                    momentumZ = momentumZ + (((force*baseWalkingSpeed) - momentumZ)/9.0);
                }
                tapZon = 1;
            } else {
                tapZon = 0;
            }
        } else {
            momentumZ = force*baseWalkingSpeed;
            if (momentumX == 0) {
                momentumX = 0.0001;
            }
        }
    }
}

- (void)lookDirection:(float)tapxdiff :(float)tapydiff {
    if (currentVRmenu == 0 && collectingColorup == 0) {
        //printf("xdif: %f, ydif: %f\n",tapxdiff,tapydiff);
        if (rotationX > (rotationdragX+(tapxdiff*isiPhone6PlusCoeff)+0.05)) {
            momentumrotationX = momentumrotationX + ((-(tapxdiff*isiPhone6PlusCoeff*0.0014) - momentumrotationX)/2.2);
            tapRon = 1;
        } else if (rotationX < (rotationdragX+(tapxdiff)-0.05)) {
            momentumrotationX = momentumrotationX + ((-(tapxdiff*isiPhone6PlusCoeff*0.0014) - momentumrotationX)/2.2);
            tapRon = 1;
        }
        
        if (rotationY > (rotationdragY+(tapydiff)+0.05)) {
            momentumrotationY = momentumrotationY + ((-(tapydiff*isiPhone6PlusCoeff*0.0012) - momentumrotationY)/2.2);
            tapRon = 1;
        } else if (rotationY < (rotationdragY+(tapydiff)-0.05)) {
            momentumrotationY = momentumrotationY + ((-(tapydiff*isiPhone6PlusCoeff*0.0012) - momentumrotationY)/2.2);
            tapRon = 1;
        }
    }
}

- (void)lookStop {
    if (currentVRmenu == 0) {
        tapRon = 0;
    }
}

- (void)setFOV:(float)value {
    FOVvalue = value;
}

- (void)dropgrabObject:(float)tapx :(float)tapy {
    if (currentVRmenu == 0 && collectingColorup == 0) {
        if (grabbedobject == 0) {
            grabbedobject = 1;
            grabbedObjectTimer = 10;
            
            for (CCSprite *sprite in objectArray) {
                object *currentObject = (object *)sprite;
                if (currentObject.objectBeingHighlighted == 1 && currentObject.isasubobject == 0 && currentObject.playerusable == 1) {
                    currentObject.objectgrabbed = 1;
                }
            }
        } else {
            grabbedobject = 0;
            
            for (CCSprite *sprite in objectArray) {
                object *currentObject = (object *)sprite;
                if (currentObject.objectgrabbed == 1) {
                    currentObject.objectgrabbed = 0;
                }
            }
        }
    }
}

- (void)draggrabbedObject:(float)initialx :(float)tapx {
    if (grabbedobject == 1 && currentVRmenu == 0 && collectingColorup == 0) {
        for (CCSprite *sprite in objectArray) {
            object *currentObject = (object *)sprite;
            if (currentObject.objectgrabbed == 1 && currentObject.isasubobject == 0) {
                if (grabobjectdrag == 0) {
                    grabobjectsavedrotation = currentObject.rotationoffsetx2;
                    grabobjectdrag = 1;
                }
                currentObject.rotationtargetoffsetx2 = grabobjectsavedrotation + ((float)(tapx-initialx)*0.015);
                //printf("%f, %f\n",(tapx - initialx),currentObject.rotationoffsetx2);
            }
        }
    }
}

- (void)stopdraggrabbedObject {
    grabobjectdrag = 0;
}

- (void)doPlayerAction:(int)type {
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    if (currentVRmenu == 0) {
        printf("ACTION TYPE: %i\n",type);
        
        if (playerDoingAction == 0 && type == 0 && collectingColorup == 0) { //normal action
            playerDoingAction = 1;
            playerRedoActionTimer = 28;
            playerFOVchangeTimer = 24;
            
            //reciprocated player action
            if (vrPrimaryInstance == 1) {
                MenuLayer * mnLayer = (MenuLayer *)[self.parent getChildByName:@"mnLayer" recursively:1];
                [mnLayer reciprocatePlayerAction];
            }
            
            //throws grabbed object
            if (grabbedobject == 1) {
                for (CCSprite *sprite in objectArray) {
                    object *currentObject = (object *)sprite;
                    if (currentObject.objectgrabbed == 1 && currentObject.objectusemode == 0) { //throw object
                        currentObject.objectgrabbed = 0;
                        grabbedobject = 0;
                        if (levelTypeHWL2 == 1) {
                            currentObject.posYmomentum = (3.7-((rotationY+((90.0+(float)gyroRollOffset)*0.08))*0.66))*0.73*0.4;
                        } else if (levelTypeHWL2 == 2) {
                            currentObject.posYmomentum = (-(rotationY+((90.0+(float)gyroRollOffset)*0.08))*0.66)*0.73*0.4;
                        } else {
                            currentObject.posYmomentum = (3.7-((rotationY+((90.0+(float)gyroRollOffset)*0.08))*0.66))*0.73;
                        }
                        
                        //x&z momentum
                        //gets sin&cos (angle) to otherObject
                        float var1 = asinf((positionZ-currentObject.posZ)/(sqrtf(powf(positionX-currentObject.posX, 2) + powf((positionZ-currentObject.posZ), 2)))); //negative = down, positive = up
                        float var2 = asinf((positionX-currentObject.posX)/(sqrtf(powf(positionX-currentObject.posX, 2) + powf((positionZ-currentObject.posZ), 2)))); //negative = left, positive = right
                        float var3 = 0;
                        float var4 = 0;
                        //sets closest point to other object
                        if (var2 >= 0) {
                            if (currentObject.objectheavy == 0) {
                                var3 = -(cosf(var1)*7.0);
                                var4 = -(sinf(var1)*7.0);
                            } else {
                                var3 = -(cosf(var1)*4.0);
                                var4 = -(sinf(var1)*4.0);
                            }
                        } else if (var2 < 0) {
                            if (currentObject.objectheavy == 0) {
                                var3 = (cosf(var1)*7.0);
                                var4 = -(sinf(var1)*7.0);
                            } else {
                                var3 = (cosf(var1)*4.0);
                                var4 = -(sinf(var1)*4.0);
                            }
                        }
                        if (levelTypeHWL2 == 2) {
                            currentObject.posXmomentum = var3*0.73*0.25;
                            currentObject.posZmomentum = var4*0.73*0.25;
                        } else if (levelTypeHWL2 == 1) {
                            currentObject.posXmomentum = var3*0.73*0.35;
                            currentObject.posZmomentum = var4*0.73*0.35;
                        } else {
                            currentObject.posXmomentum = var3*0.73;
                            currentObject.posZmomentum = var4*0.73;
                        }
                    } else if (currentObject.objectgrabbed == 1 && currentObject.objectusemode == 1) { //usable object
                        currentObject.usableanimtoggle = 1;
                        for (CCSprite *sprite in objectArray) {
                            object *otherObject = (object *)sprite;
                            if (otherObject != currentObject && otherObject.objectgrabbed == 0 && otherObject.objectusescollisions == 1) {
                                if (otherObject.hypotenusetoplayer <= 100 && otherObject.hypotenusetoplayer > 0 && otherObject.postposZ > positionZ && otherObject.posY > (positionY-playerHeight)+1 && otherObject.posY < (positionY-playerHeight)+25 && otherObject.position.x > winSize.width*0.28 && otherObject.position.x < winSize.width*0.72) {
                                    //x&z momentum
                                    //gets sin&cos (angle) to otherObject
                                    float var1 = asinf((positionZ-otherObject.posZ)/(sqrtf(powf(positionX-otherObject.posX, 2) + powf((positionZ-otherObject.posZ), 2)))); //negative = down, positive = up
                                    float var2 = asinf((positionX-otherObject.posX)/(sqrtf(powf(positionX-otherObject.posX, 2) + powf((positionZ-otherObject.posZ), 2)))); //negative = left, positive = right
                                    float var3 = 0;
                                    float var4 = 0;
                                    //sets closest point to other object
                                    if (var2 >= 0) {
                                        if (otherObject.objectheavy == 0) {
                                            var3 = -(cosf(var1)*11.5);
                                            var4 = -(sinf(var1)*11.5);
                                        } else {
                                            var3 = -(cosf(var1)*6.0);
                                            var4 = -(sinf(var1)*6.0);
                                        }
                                    } else if (var2 < 0) {
                                        if (currentObject.objectheavy == 0) {
                                            var3 = (cosf(var1)*11.5);
                                            var4 = -(sinf(var1)*11.5);
                                        } else {
                                            var3 = (cosf(var1)*6.0);
                                            var4 = -(sinf(var1)*6.0);
                                        }
                                    }
                                    otherObject.posXmomentum = otherObject.posXmomentum+var3;
                                    otherObject.posZmomentum = otherObject.posZmomentum+var4;
                                    if (playPunchNoise <= 0) {
                                        playPunchNoise = 2;
                                    }
                                } else if (otherObject.hypotenusetoplayer <= 70 && otherObject.hypotenusetoplayer > 0 && otherObject.posY >= (positionY-playerHeight)+25) {
                                    otherObject.refreshminypos = 1;
                                }
                            }
                        }
                    }
                }
            } else { //no grabbed object
                for (CCSprite *sprite in objectArray) {
                    object *currentObject = (object *)sprite;
                    if (currentObject.hypotenusetoplayer <= 75 && currentObject.hypotenusetoplayer > 0 && currentObject.postposZ > positionZ && currentObject.posY > (positionY-playerHeight)+1 && currentObject.posY < (positionY-playerHeight)+25 && currentObject.position.x > winSize.width*0.28 && currentObject.position.x < winSize.width*0.72 && currentObject.objectusescollisions == 1 && currentObject.canbePickedUp == 0) {
                        //x momentum
                        //gets sin&cos (angle) to otherObject
                        float var1 = asinf((positionZ-currentObject.posZ)/(sqrtf(powf(positionX-currentObject.posX, 2) + powf((positionZ-currentObject.posZ), 2)))); //negative = down, positive = up
                        float var2 = asinf((positionX-currentObject.posX)/(sqrtf(powf(positionX-currentObject.posX, 2) + powf((positionZ-currentObject.posZ), 2)))); //negative = left, positive = right
                        float var3 = 0;
                        float var4 = 0;
                        //sets closest point to other object
                        if (var2 >= 0) {
                            if (currentObject.objectheavy == 0) {
                                var3 = -(cosf(var1)*5.0);
                                var4 = -(sinf(var1)*5.0);
                            } else {
                                var3 = -(cosf(var1)*2.5);
                                var4 = -(sinf(var1)*2.5);
                            }
                        } else if (var2 < 0) {
                            if (currentObject.objectheavy == 0) {
                                var3 = (cosf(var1)*5.0);
                                var4 = -(sinf(var1)*5.0);
                            } else {
                                var3 = (cosf(var1)*2.5);
                                var4 = -(sinf(var1)*2.5);
                            }
                        }
                        currentObject.posXmomentum = currentObject.posXmomentum+var3;
                        currentObject.posZmomentum = currentObject.posZmomentum+var4;
                        if (currentObject.objectheavy == 0) { //determines min amount of time for collision to be ignored
                            currentObject.exemptFromPlayerCollisionsTimer = 3;
                        } else {
                            currentObject.exemptFromPlayerCollisionsTimer = 0;
                        }
                        if (playPunchNoise <= 0) {
                            playPunchNoise = 2;
                        }
                    } else if (currentObject.hypotenusetoplayer <= 75 && currentObject.hypotenusetoplayer > 0 && currentObject.posY >= (positionY-playerHeight)+25) {
                        currentObject.refreshminypos = 1;
                    }
                }
            }
            
            //audio
            if (vrPrimaryInstance == 1) {
                [[OALSimpleAudio sharedInstance] playEffect:@"swoosh.wav"];
            }
            
            FOVvalue = FOVvalueinitial * 1.0333;
            FOVrotation = 0;
            FOVrotationscale = 0.9;
            int randnum1 = arc4random() % 2;
            if (randnum1 == 0 || vrEnabled != 0) {
                FOVrotationvel1 = 2.5;
                FOVrotationtoggle = 0;
            } else {
                FOVrotationvel1 = -2.5;
                FOVrotationtoggle = 1;
            }
        } else if (playerDoingAction == 0 && type == 6) { //toggle vr mode
            playerDoingAction = 1;
            playerRedoActionTimer = 28;
            playerFOVchangeTimer = 24;
            
            //reciprocated player action
            if (vrPrimaryInstance == 1) {
                [self quickSaveVars];
                CCScene *scene = [CCDirector sharedDirector].runningScene;
                HelloWorldLayer *mainScene = (HelloWorldLayer *)scene;
                [mainScene restartWithVRMode:1];
            }
        }
    }
}

- (void)act {
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    objectRemovalArray = [[NSMutableArray alloc] init];
    objectTransitionRemovalArray = [[NSMutableArray alloc] init];
    startSyncUniqueIDs = [[NSMutableArray alloc] init];
    startSyncPhysicalProperties = [[NSMutableArray alloc] init];
    polygonRemovalArray = [[NSMutableArray alloc] init];
    statItemRemovalArray = [[NSMutableArray alloc] init];
    labelRemovalArray = [[NSMutableArray alloc] init];
    
    //quick load
    if (quickLoadQueued == 1) {
        quickLoadQueued = 0;
        [[NSUserDefaults standardUserDefaults] setBool:0 forKey:@"quickLoad"];
        
        NSMutableArray *varsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"varsArray"];
        positionX = [[varsArray objectAtIndex:0] floatValue];
        positionY = [[varsArray objectAtIndex:1] floatValue];
        positionZ = [[varsArray objectAtIndex:2] floatValue];
        momentumX = [[varsArray objectAtIndex:3] floatValue];
        momentumY = [[varsArray objectAtIndex:4] floatValue];
        momentumZ = [[varsArray objectAtIndex:5] floatValue];
        minYpos = [[varsArray objectAtIndex:6] floatValue];
        positionYanimoffset = [[varsArray objectAtIndex:7] floatValue];
        positionYanimoffsettoggle = [[varsArray objectAtIndex:8] floatValue];
        onTopOfFloatingObjects = [[varsArray objectAtIndex:9] boolValue];
        playerInLiquid = [[varsArray objectAtIndex:10] boolValue];
        positionYanimoffsettimer = [[varsArray objectAtIndex:11] intValue];
        grabbedobject = [[varsArray objectAtIndex:12] boolValue];
        grabbedObjectTimer = [[varsArray objectAtIndex:13] intValue];
        playerDoingAction = [[varsArray objectAtIndex:14] boolValue];
        playerRedoActionTimer = [[varsArray objectAtIndex:15] intValue];
        playerFOVchangeTimer = [[varsArray objectAtIndex:16] intValue];
        playPunchNoise = [[varsArray objectAtIndex:17] intValue];
        shadeDistance = [[varsArray objectAtIndex:18] floatValue];
        targetShadeDistance = [[varsArray objectAtIndex:19] floatValue];
        targetShadeDistanceDelta = [[varsArray objectAtIndex:20] floatValue];
        hoverAnimX = [[varsArray objectAtIndex:21] floatValue];
        colorID = [[varsArray objectAtIndex:22] intValue];
        collectingColorup = [[varsArray objectAtIndex:23] boolValue];
        collectingColorupTrans = [[varsArray objectAtIndex:24] floatValue];
        colorupHypo = [[varsArray objectAtIndex:25] floatValue];
        colorupFadeExists = [[varsArray objectAtIndex:26] boolValue];
        if (vrEnabled == 0) {
            rotationX = [[varsArray objectAtIndex:27] floatValue];
            rotationY = [[varsArray objectAtIndex:28] floatValue];
        }
        mininitialYpos = [[varsArray objectAtIndex:29] floatValue];
        minYposold = [[varsArray objectAtIndex:30] floatValue];
        minYpospotential = [[varsArray objectAtIndex:31] floatValue];
        varsArray = nil;
        
        //loads other objects
        
    } else if (quickLoadQueued > 1) {
        quickLoadQueued--;
    }
    
    //shooting gun
    if (P2shootTimer > 0) {
        P2shootTimer--;
    }
    
    //vr menu management
    if (bluetoothNotConnected == 1) {
        if (currentVRmenu != -2) {
            currentVRmenu = -2;
        }
        
        if (btKeyboardConnectedTimer != 360) {
            btKeyboardConnectedTimer = 360;
        }
    }
    if (currentVRmenuRefresh != currentVRmenu) {
        currentVRmenuRefresh = currentVRmenu;
        
        //automatically deletes all vr elements currently being shown
        for (CCSprite *sprite in objectArray) {
            object *currentObject = (object *)sprite;
            if (currentObject.vrUIelement != 0) { //other ui elements
                currentObject.deleteObject = 1;
            }
        }
        for (CCLabelTTF *sprite in labelArray) {
            label *currentLabel = (label *)sprite;
            if (currentLabel.vrLabel != 0) {
                currentLabel.deleteLabel = 1;
            }
        }
        vrCSinputModeOn = 0;
        
        //element creation and crosshair management
        if (currentVRmenu == 0) {
            for (CCSprite *sprite in objectArray) {
                object *currentObject = (object *)sprite;
                if (currentObject.vrUIelement != 0 && currentObject.objectid == 18) { //crosshairs
                    currentObject.deleteObject = 0;
                }
            }
        } else if (currentVRmenu != 0) {
            if (currentVRmenu == -1) { //controls & settings
                //creates ui elements
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *horizNum2 = nil;
                    horizNum2 = [vr3 vrElement3];
                    horizNum2.opacity = 0;
                    [self addChild:horizNum2];
                    [objectTransitionArray addObject:horizNum2];
                }
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *horizNum2 = nil;
                    horizNum2 = [vr4 vrElement4];
                    horizNum2.opacity = 0;
                    [self addChild:horizNum2];
                    [objectTransitionArray addObject:horizNum2];
                }
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *horizNum2 = nil;
                    horizNum2 = [vr5 vrElement5];
                    horizNum2.opacity = 0;
                    [self addChild:horizNum2];
                    [objectTransitionArray addObject:horizNum2];
                }
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *horizNum2 = nil;
                    horizNum2 = [vr6 vrElement6];
                    horizNum2.opacity = 0;
                    [self addChild:horizNum2];
                    [objectTransitionArray addObject:horizNum2];
                }
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *horizNum2 = nil;
                    horizNum2 = [vr6_2 vrElement6_2];
                    horizNum2.opacity = 0;
                    [self addChild:horizNum2];
                    [objectTransitionArray addObject:horizNum2];
                }
                
                //individual entries
                for (int int0 = 0; int0 <= 10; int0++) {
                    for (int int2 = 0; int2 <= 0; int2++) {
                        object *horizNum2 = nil;
                        horizNum2 = [vr_k vrKey];
                        horizNum2.opacity = 0;
                        horizNum2.pospreYoffset -= (float)int0*65.0;
                        horizNum2.objectdistancetoggle = int0;
                        [self addChild:horizNum2];
                        [objectTransitionArray addObject:horizNum2];
                    }
                    
                    for (int int2 = 0; int2 <= 0; int2++) { //text blurb
                        object *horizNum2 = nil;
                        horizNum2 = [vr_kw1 vrKeyText1];
                        horizNum2.opacity = 0;
                        horizNum2.objectdistancetoggle = int0;
                        horizNum2.pospreYoffset -= (float)int0*65.0;
                        if (int0 == 1) {
                            [horizNum2 setTexture:[CCTexture textureWithFile:@"text_pickupdrop.png"]];
                        } else if (int0 == 2) {
                            [horizNum2 setTexture:[CCTexture textureWithFile:@"text_throwinteract.png"]];
                        } else if (int0 == 3) {
                            [horizNum2 setTexture:[CCTexture textureWithFile:@"text_moveforward.png"]];
                        } else if (int0 == 4) {
                            [horizNum2 setTexture:[CCTexture textureWithFile:@"text_movebackward.png"]];
                        } else if (int0 == 5) {
                            [horizNum2 setTexture:[CCTexture textureWithFile:@"text_moveleft.png"]];
                        } else if (int0 == 6) {
                            [horizNum2 setTexture:[CCTexture textureWithFile:@"text_moveright.png"]];
                        } else if (int0 == 7) {
                            [horizNum2 setTexture:[CCTexture textureWithFile:@"text_jump.png"]];
                        } else if (int0 == 8) {
                            [horizNum2 setTexture:[CCTexture textureWithFile:@"text_rotateleft.png"]];
                        } else if (int0 == 9) {
                            [horizNum2 setTexture:[CCTexture textureWithFile:@"text_rotateright.png"]];
                        } else if (int0 == 10) {
                            [horizNum2 setTexture:[CCTexture textureWithFile:@"text_exitvr.png"]];
                        }
                        [self addChild:horizNum2];
                        [objectTransitionArray addObject:horizNum2];
                    }
                    
                    for (int int2 = 0; int2 <= 0; int2++) { //key character
                        label *horizNum2 = nil;
                        horizNum2 = [kc1 keyChar1];
                        horizNum2.opacity = 0;
                        horizNum2.labelsubid = int0;
                        horizNum2.labelposY -= (float)int0*65.0;
                        if (int0 == 0) {
                            [horizNum2 setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_closeopen"]];
                        } else if (int0 == 1) {
                            [horizNum2 setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_pickupdrop"]];
                        } else if (int0 == 2) {
                            [horizNum2 setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_throwinteract"]];
                        } else if (int0 == 3) {
                            [horizNum2 setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveforward"]];
                        } else if (int0 == 4) {
                            [horizNum2 setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_movebackward"]];
                        } else if (int0 == 5) {
                            [horizNum2 setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveleft"]];
                        } else if (int0 == 6) {
                            [horizNum2 setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveright"]];
                        } else if (int0 == 7) {
                            [horizNum2 setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_jump"]];
                        } else if (int0 == 8) {
                            [horizNum2 setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_rotateleft"]];
                        } else if (int0 == 9) {
                            [horizNum2 setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_rotateright"]];
                        } else if (int0 == 10) {
                            [horizNum2 setString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_exitvr"]];
                        }
                        [self addChild:horizNum2];
                        [labelArray addObject:horizNum2];
                    }
                    if (vrCSItemSelectedMAX < int0+2) {
                        vrCSItemSelectedMAX = int0+2;
                    }
                }
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *horizNum2 = nil;
                    horizNum2 = [vr_kw3 vrEyeDist];
                    horizNum2.opacity = 0;
                    horizNum2.pospreYoffset -= ((float)vrCSItemSelectedMAX-1.0)*65.0;
                    horizNum2.objectdistancetoggle = vrCSItemSelectedMAX-1;
                    [self addChild:horizNum2];
                    [objectTransitionArray addObject:horizNum2];
                }
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *horizNum2 = nil;
                    horizNum2 = [vr_kw4 vrEyeDistBar];
                    horizNum2.opacity = 0;
                    horizNum2.pospreYoffset -= ((float)vrCSItemSelectedMAX-1.0)*65.0;
                    horizNum2.objectdistancetoggle = vrCSItemSelectedMAX-1;
                    [self addChild:horizNum2];
                    [objectTransitionArray addObject:horizNum2];
                }
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *horizNum2 = nil;
                    horizNum2 = [vr_kw5 vrEyeDistTicker];
                    horizNum2.opacity = 0;
                    horizNum2.pospreYoffset -= ((float)vrCSItemSelectedMAX-1.0)*65.0;
                    horizNum2.objectdistancetoggle = vrCSItemSelectedMAX-1;
                    [self addChild:horizNum2];
                    [objectTransitionArray addObject:horizNum2];
                }
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *horizNum2 = nil;
                    horizNum2 = [vr_kw2 vrKeyResetButton];
                    horizNum2.opacity = 0;
                    horizNum2.pospreYoffset -= (float)vrCSItemSelectedMAX*65.0;
                    horizNum2.objectdistancetoggle = vrCSItemSelectedMAX;
                    [self addChild:horizNum2];
                    [objectTransitionArray addObject:horizNum2];
                }
            } else if (currentVRmenu == -2) { //connect bluetooth keyboard
                //creates ui elements
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *horizNum2 = nil;
                    horizNum2 = [vr1 vrElement1];
                    horizNum2.opacity = 0;
                    [self addChild:horizNum2];
                    [objectTransitionArray addObject:horizNum2];
                }
                for (int int2 = 0; int2 <= 0; int2++) {
                    object *horizNum2 = nil;
                    horizNum2 = [vr1_1 vrElement1_1];
                    horizNum2.opacity = 0;
                    [self addChild:horizNum2];
                    [objectTransitionArray addObject:horizNum2];
                }
            }
        }
    }
    
    //vr helper arrow
    arrowAnimX = arrowAnimX + 0.25;
    if (arrowAnimX > 32*(3.1415926535897932*2.0)) {
        arrowAnimX = 0;
    }
    
    //virtual reality eye placement
    if (vrEnabled == 1) {
        float angleInRadians = (rotationX+(gyroYawOffset/16.5))*16.5*(3.1415926535897932/180.0);
        float angle2InRadians = (FOVrotation-gyroPitchOffset)*(3.1415926535897932/180.0);
        VRoffsetX = VReyeDistance*cosf(angleInRadians)*cosf(angle2InRadians);
        VRoffsetY = VReyeDistance*sinf(angle2InRadians);
        VRoffsetZ = VReyeDistance*sinf(angleInRadians)*cosf(angle2InRadians);
        
        //printf("ED: %.1f, STATS: %.1f, %.1f, %.1f\n",VReyeDistance,VRoffsetX,VRoffsetY,VRoffsetZ);
        
        //eye distance controls
        if (vrCSedValRefresh != vrCSedVal) {
            vrCSedValRefresh = vrCSedVal;
            
            if (vrPrimaryInstance != 0) {
                VReyeDistance = -5-((float)vrCSedVal*5*0.999/3);
            } else {
                VReyeDistance = 5+((float)vrCSedVal*5/3);
            }
            [[NSUserDefaults standardUserDefaults] setInteger:vrCSedVal forKey:@"vrCSedVal"];
        }
        vrCSedValXOffset = vrCSedValXOffset + ((((float)vrCSedVal*44.0) - vrCSedValXOffset)/4.0);
    }
    
    if (anObjectIsBeingSelected != 0) {
        if (cutsceneActiveHWL == 0) {
            vrosSelectionAnimX = vrosSelectionAnimX + 0.25;
            if (vrosSelectionAnimX > 32*(3.1415926535897932*2.0)) {
                vrosSelectionAnimX = 0;
            }
        } else {
            vrosSelectionAnimX = (3.1415926535897932/2.0);
        }
    }
    
    hoverAnimX = hoverAnimX + 0.06;
    if (hoverAnimX > 32*(3.1415926535897932*2.0)) {
        hoverAnimX = 0;
    }
    
    if (vrEnabled != 0 && currentVRmenu == -1) {
        if (vrCSinputModeOn == 0) { //selection animation
            vrCSSelectionAnimX = vrCSSelectionAnimX + 0.16;
        } else {
            vrCSSelectionAnimX = vrCSSelectionAnimX + 0.26;
        }
        if (vrCSSelectionAnimX > 32*(3.1415926535897932*2.0)) {
            vrCSSelectionAnimX = 0;
        }
        
        //scrolling animaiton/positioning
        if (vrCSItemSelected >= vrCSItemSelectedMAX) {
            vrCSscrollY = vrCSscrollY + (((((float)vrCSItemSelected*65.0)-196.0) - vrCSscrollY)/4.0);
        } else if (vrCSItemSelected >= 3) {
            vrCSscrollY = vrCSscrollY + (((((float)vrCSItemSelected*65.0)-138.0) - vrCSscrollY)/4.0);
        } else {
            vrCSscrollY = vrCSscrollY + ((0.0 - vrCSscrollY)/4.0);
        }
    }
    
    //gyroscope
    if (vrEnabled == 0 && gyroscopeControlsEnabled != 0) {
        gyroscopeControlsEnabled = 0;
    } else if (vrEnabled != 0 && gyroscopeControlsEnabled != 1) {
        gyroscopeControlsEnabled = 1;
    }
    if (gyroscopeControlsEnabled == 1) {
        CMDeviceMotion *currentDeviceMotion = motionManager.deviceMotion;
        CMAttitude *currentAttitude = currentDeviceMotion.attitude;
        
        float targetYaw = (float)(CC_RADIANS_TO_DEGREES(currentAttitude.yaw));
        float targetPitch = (float)(CC_RADIANS_TO_DEGREES(currentAttitude.pitch));
        float targetRoll = (float)(CC_RADIANS_TO_DEGREES(currentAttitude.roll));
        
        if (gyroQuadrantRefresh != gyroQuadrant) {
            gyroQuadrantRefresh = gyroQuadrant;
            
            if (gyroQuadrant == 2) { //changing from original quadrant
                rotationX = rotationX + (180.0/16.5);
            } else if (gyroQuadrant == 1) { //returning to original quadrant
                rotationX = rotationX - (180.0/16.5);
            }
        }
        if (gyroQuadrant == 2) {
            targetPitch = -targetPitch;
            targetYaw = targetYaw;
            targetRoll = -targetRoll;
        }
        
        //printf("QUAD: %i\n",gyroQuadrant);
        //printf("\nROTRATE: %.2f, %.2f, %.2f\n",currentDeviceMotion.rotationRate.x,currentDeviceMotion.rotationRate.y,currentDeviceMotion.rotationRate.z);
        //printf("ROTVARS: Y: %.2f, R: %.2f, P: %.2f\n",targetYaw,targetRoll,targetPitch); //dev
        
        if (targetPitch <= 50 && targetPitch >= -50) {
            gyroPitchOffset = targetPitch;
        } else if (targetPitch > 50) {
            gyroPitchOffset = 50;
        } else if (targetPitch < -50) {
            gyroPitchOffset = -50;
        }
        
        if (targetRoll <= -25 && targetRoll >= -155) {
            gyroRollOffset = targetRoll;
        } else if (targetRoll > -25) {
            gyroRollOffset = -25;
        } else if (targetRoll < -155) {
            gyroRollOffset = -155;
        }
        
        gyroYawOffset = targetYaw;
        
        /*if (currentDeviceMotion.userAcceleration.x < -0.5 || currentDeviceMotion.userAcceleration.x > 0.5) {
         printf("ACC X: %f, Z: %f\n",currentDeviceMotion.userAcceleration.x,currentDeviceMotion.userAcceleration.z);
         }
         if (currentDeviceMotion.userAcceleration.z < -0.5 || currentDeviceMotion.userAcceleration.z > 0.5) {
         printf("ACC X: %f, Z: %f\n",currentDeviceMotion.userAcceleration.x,currentDeviceMotion.userAcceleration.z);
         }*/
        //gyroVelXOffset = (gyroVelXOffset*0.94)+((float)currentDeviceMotion.userAcceleration.x/5.0);
        //gyroVelYOffset = /*((float)currentDeviceMotion.userAcceleration.y*2.0)*/0;
        //gyroVelZOffset = (gyroVelZOffset+((float)currentDeviceMotion.userAcceleration.z/4.0))*0.995;
    } else if (gyroscopeControlsEnabled == 0) {
        if (gyroRollOffset != -90) {
            gyroRollOffset = -90;
        }
    }
    
    //grabbed object safety
    if (grabbedObjectTimer > 0) {
        grabbedObjectTimer--;
    } else if (grabbedObjectTimer == 0) {
        grabbedObjectTimer = -1;
        
        bool anythingGrabbed = 0;
        for (CCSprite *sprite in objectArray) {
            object *currentObject = (object *)sprite;
            if (currentObject.objectgrabbed != 0) {
                anythingGrabbed = 1;
                break;
            }
        }
        if (anythingGrabbed == 0) {
            grabbedobject = 0;
        }
    }
    
    //updates menuLayer
    if (grabbedobjectrefresh != grabbedobject) {
        grabbedobjectrefresh = grabbedobject;
        
        MenuLayer * mnLayer = (MenuLayer *)[self.parent getChildByName:@"mnLayer" recursively:1];
        [mnLayer getObjectGrabbed:grabbedobject];
    }
    
    /*//delayed sync
    if (delayedSyncTimer > 0) {
        delayedSyncTimer--;
    } else if (delayedSyncTimer == 0) {
        delayedSyncTimer = -1;
        
        //queues object for sync
        if (vrPrimaryInstance == 1 && vrEnabled != 0) { //primary instance
            NSMutableArray *physicalProperties = [[NSMutableArray alloc] init];
            [physicalProperties addObject:[NSNumber numberWithFloat:0]];
            [physicalProperties addObject:[NSNumber numberWithFloat:0]];
            [physicalProperties addObject:[NSNumber numberWithFloat:0]];
            [physicalProperties addObject:[NSNumber numberWithFloat:0]];
            [physicalProperties addObject:[NSNumber numberWithFloat:0]];
            [physicalProperties addObject:[NSNumber numberWithFloat:0]];
            [physicalProperties addObject:[NSNumber numberWithFloat:0]];
            [startSyncPhysicalProperties addObject:physicalProperties];
            [startSyncUniqueIDs addObject:[NSNumber numberWithInt:-1]]; //should never actually coincide with an actual object
        }
    }*/
    
    //walking noises
    if (useWalkingAnimation == 1) {
        if (playWalkNoiseTimer > 0) {
            playWalkNoiseTimer = playWalkNoiseTimer - 1 - (sqrtf(((momentumZ*momentumZ) + (momentumX*momentumX))))*12.0;
        }
        if (momentumX <= -0.1 || momentumX >= 0.1 || momentumZ <= -0.1 || momentumZ >= 0.1) {
            if (positionY <= minYpos+1.0 && playerInLiquid == 0) {
                if (playWalkNoiseTimer <= 0) {
                    playWalkNoiseTimer = 750*(1.0/walkingSpeed);
                    
                    //FOV animation
                    if (playerFOVchangeTimer <= 0) {
                        playerFOVchangeTimer = 16;
                        FOVrotationscale = 0.65;
                        int randnumabcd = arc4random() % 2;
                        if (randnumabcd == 0 || vrEnabled != 0) {
                            FOVrotationvel1 = 0.8;
                            FOVrotationtoggle = 0;
                        } else {
                            FOVrotationvel1 = -0.8;
                            FOVrotationtoggle = 1;
                        }
                    }
                    
                    if (vrPrimaryInstance == 1) {
                        //plays walk sound
                        int randnum145 = arc4random() % 8;
                        float randnum1452 = 0.65 + ((float)randnum145/8.0);
                        if (playWalkNoiseType == 0) {
                            [[OALSimpleAudio sharedInstance] playEffect:@"footstep.wav" volume:1.0 pitch:randnum1452 pan:0.0 loop:0];
                        }
                    }
                }
            }
        }
    }
    
    //shade distance management
    if (shadeDistance != targetShadeDistance) {
        shadeDistance = shadeDistance + ((targetShadeDistance - shadeDistance)/80.0);
    }
    
    //FOV rotation animations
    FOVrotation = (FOVrotation + FOVrotationvel1) * FOVrotationscale;
    if (FOVrotationscale > 0) {
        FOVrotationscale = FOVrotationscale * 0.962;
        
        if (FOVrotationtoggle == 0) {
            FOVrotationvel1 = FOVrotationvel1 - 0.11;
            if (FOVrotationvel1 <= -0.6) {
                FOVrotationtoggle = 1;
            }
        } else {
            FOVrotationvel1 = FOVrotationvel1 + 0.11;
            if (FOVrotationvel1 >= 0.6) {
                FOVrotationtoggle = 0;
            }
        }
    }
    FOVrotationrad = CC_DEGREES_TO_RADIANS(FOVrotation-gyroPitchOffset);
    
    //more fov changes
    if (FOVvalue != FOVvalueinitial) {
        FOVvalue = FOVvalue + ((FOVvalueinitial-FOVvalue)/10.0);
    }
    
    //player Action Timer
    if (playerDoingAction != 0 && playerRedoActionTimer > 0) {
        playerRedoActionTimer--;
    } else if (playerDoingAction != 0 && playerRedoActionTimer <= 0) {
        playerDoingAction = 0;
        playerRedoActionTimer = 0;
    }
    
    //player FOV animation timer
    if (playerFOVchangeTimer > 0) {
        playerFOVchangeTimer--;
    } else if (playerFOVchangeTimer <= 0) {
        playerFOVchangeTimer = 0;
    }
    
    //gravity & momentum
    if (tapXon != 0 || tapZon != 0) {
        if (playerGravityEnabled == 0) {
            momentumY = -(rotationY+((90.0+(float)gyroRollOffset)*0.08))*0.8;
        }
    }
    if (tapXon == 0) {
        if (momentumX > 0 || momentumX < 0) {
            /*if (playerInLiquid == 0) {
                momentumX = momentumX * 0.88;
            } else {
                momentumX = momentumX * (0.89+(0.085*currentViscosityOfLiquid));
            }*/
            //dev, VR demo
            momentumX = momentumX * 0.92;
        }
    }
    if (tapZon == 0) {
        if (momentumZ > 0 || momentumZ < 0) {
            /*if (playerInLiquid == 0) {
                momentumZ = momentumZ * 0.88;
            } else {
                momentumZ = momentumZ * (0.89+(0.085*currentViscosityOfLiquid));
            }*/
            //dev, VR demo
            momentumZ = momentumZ * 0.92;
        }
    }
    if (tapRon == 0) {
        if (momentumrotationX > 0 || momentumrotationX < 0) {
            momentumrotationX = momentumrotationX * 0.9;
        }
        if (momentumrotationY > 0 || momentumrotationY < 0) {
            if (rotationY <= 3.6 && rotationY >= -3.6) {
                momentumrotationY = momentumrotationY * 0.9;
            } else if (rotationY > 3.6) {
                momentumrotationY = -0.08;
            } else if (rotationY < -3.6) {
                momentumrotationY = 0.08;
            }
        }
        rotationdragX = rotationX;
        rotationdragY = rotationY;
    }
    if (playerGravityEnabled == 1) {
        //if (tapYon == 0) {
        if (positionY > minYpos) {
            if (levelTypeHWL2 == 1) {
                momentumY = momentumY - 0.08;
            } else if (levelTypeHWL2 != 2) {
                momentumY = momentumY - 0.2;
            }
        }
        //}
    } else {
        momentumY = momentumY * 0.9;
    }
    if (momentumX2 != 0) {
        momentumX2 = momentumX2 * 0.9;
    }
    if (momentumY2 != 0) {
        momentumY2 = momentumY2 * 0.9;
    }
    if (momentumZ2 != 0) {
        momentumZ2 = momentumZ2 * 0.9;
    }
    
    //in liquid animation
    if (playerInLiquid == 0) {
        if (onTopOfFloatingObjects == 0) {
            positionYanimoffset = positionYanimoffset + ((0 - positionYanimoffset)/12.0);
            positionYanimoffsettimer = 0;
            positionYanimoffsettoggle = 2.8*(3.1415926535897932*2.0);
        } else {
            positionYanimoffset = positionYanimoffset + ((positionYanimoffsetPotential - positionYanimoffset)/2.5);
            positionYanimoffsettimer = 0;
            positionYanimoffsettoggle = 2.8*(3.1415926535897932*2.0);
        }
    } else {
        if (onTopOfFloatingObjects == 0) {
            if (positionYanimoffsettimer < 100) {
                positionYanimoffsettimer++;
            }
            if (tapYon == 0) {
                positionYanimoffsettoggle = positionYanimoffsettoggle + (0.6 + (currentViscosityOfLiquid*0.15));
                float calcVarUno = sinf((float)positionYanimoffsettoggle/(3.1415926535897932*2.0));
                positionYanimoffset = positionYanimoffset + (((-12+(calcVarUno*3.2*((currentViscosityOfLiquid+0.3)/1.3))) - positionYanimoffset)/13.0);
            } else {
                positionYanimoffsettoggle = positionYanimoffsettoggle + (1.32);
                float calcVarUno = sinf((float)positionYanimoffsettoggle/(3.1415926535897932*2.0));
                positionYanimoffset = positionYanimoffset + (((-10.5+(calcVarUno*7.2)) - positionYanimoffset)/13.0);
            }
            
            if (positionYanimoffsettoggle > 32*(3.1415926535897932*2.0)) {
                positionYanimoffsettoggle = 0;
            }
        } else {
            positionYanimoffset = positionYanimoffset + ((positionYanimoffsetPotential - positionYanimoffset)/2.5);
            positionYanimoffsettimer = 0;
            positionYanimoffsettoggle = 2.8*(3.1415926535897932*2.0);
        }
    }
    
    rotationX = rotationX + momentumrotationX;
    rotationY = rotationY + momentumrotationY;
    if (rotationY > 3.6) {
        rotationY = 3.6;
    } else if (rotationY < -3.6) {
        rotationY = -3.6;
    }
    //printf("%f\n",rotationY);
    positionY = positionY + momentumY;
    positionYactual = positionY + positionYanimoffset;
    
    if ((rotationX * 16.5) > 360) {
        rotationX = rotationX - (360/16.5);
    } else if ((rotationX * 16.5) < 0) {
        rotationX = rotationX + (360/16.5);
    }
    
    
    positionvar1 = CC_DEGREES_TO_RADIANS((rotationX+(gyroYawOffset/16.5)));
    if (momentumZ == 0) {
        positionvar2 = (positionvar1*16.5);
    } else {
        positionvar2 = atan(-momentumX/(momentumZ+gyroVelZOffset)) + (positionvar1*16.5);
    }
    if (momentumZ > 0) {
        positionvar3 = (sqrtf(powf(momentumX, 2) + powf((momentumZ+gyroVelZOffset), 2)));
    } else {
        positionvar3 = -(sqrtf(powf(momentumX, 2) + powf((momentumZ+gyroVelZOffset), 2)));
    }
    momentumactualX = (sinf(-positionvar2) * (positionvar3*walkingSpeed));
    momentumactualZ = (cosf(-positionvar2) * (positionvar3*walkingSpeed));
    //printf("4: %f, 5: %f, hyp: %f, ang: %f, posx: %f, posz: %f\n",momentumactualX,momentumactualZ,positionvar3,positionvar2,positionX,positionZ);
    positionX = positionX + momentumactualX + (momentumX2*1.25);
    positionZ = positionZ + momentumactualZ + (momentumZ2*1.25) + gyroVelZOffset;
    
    if (walkingSpeed <= 1.0) {
        walkingSpeed = 1.0;
    }
    
    if (currentViscosityOfLiquid <= 1.0) {
        currentViscosityOfLiquid = 1.0;
    }
    
    
    
    //player minimun height
    if (momentumX != 0 || momentumZ != 0) {
        minYposold = minYpos;
        minYpos = mininitialYpos;
    }
    
    //punch noise
    if (playPunchNoise > 0) {
        if (playPunchNoise == 1 && vrPrimaryInstance == 1) {
            [[OALSimpleAudio sharedInstance] playEffect:@"punch1.wav"];
        }
        playPunchNoise--;
    }
    
    //applies border restrictions to player
    if (bordersEnabled != 0) {
        if (positionX < -borderX) {
            positionX = -borderX;
        } else if (positionX > borderX) {
            positionX = borderX;
        }
        if (positionZ < -borderZ) {
            positionZ = -borderZ;
        } else if (positionZ > borderZ) {
            positionZ = borderZ;
        }
    }
    if (borderRadius != 0) {
        float hypo = sqrtf(powf(positionX,2.0)+powf(positionZ,2.0));
        if (hypo >= borderRadius) {
            float angle = acosf(positionX/hypo);
            positionX = cosf(angle)*borderRadius;
            if (positionZ >= 0) {
                positionZ = sinf(angle)*borderRadius;
            } else {
                positionZ = -sinf(angle)*borderRadius;
            }
        }
    }
    
    /*//not facing right direction
    if (facingColorup == 0 && currentVRmenu == 0 && collectingColorup == 0) {
        if (notFacingRightDirectionTimer < 1000) {
            notFacingRightDirectionTimer++;
        }
        
        bool conditionForSpawn = 0;
        if (notFacingRightDirectionTimer == 210 && colorID == 1) {
            conditionForSpawn = 1;
        } else if (notFacingRightDirectionTimer == 380 && colorID == 2) {
            conditionForSpawn = 1;
        }
        if (conditionForSpawn == 1) {
            for (int int2 = 0; int2 <= 0; int2++) {
                object *objectNum1 = nil;
                objectNum1 = [arrow1 arrowHelp1];
                objectNum1.posX = 0;
                objectNum1.posY = playerHeight;
                objectNum1.posZ = 50;
                objectNum1.standardScale = 0;
                [self addChild:objectNum1];
                [objectTransitionArray addObject:objectNum1];
            }
        }
    } else if (notFacingRightDirectionTimer != -1) {
        notFacingRightDirectionTimer = -1;
        
        //delete arrow
        for (CCSprite *sprite in objectArray) {
            object *currentObject = (object *)sprite;
            if (currentObject.objectid == 21) {
                currentObject.deleteObject = 1;
            }
        }
    }*/
    
    
    //player in liquid animations safety
    playerInLiquid = 0;
    positionYanimoffsetPotential = 0;
    onTopOfFloatingObjects = 0;
    
    objectsPosXOLD = nil;
    objectsPosYOLD = nil;
    objectsPosZOLD = nil;
    objectsIDsOLD = nil;
    objectsHeightsOLD = nil;
    objectsHeightOffsetOLD = nil;
    objectsRadiusOLD = nil;
    objectsCollisionTypeOLD = nil;
    objectsGrabbedOLD = nil;
    
    objectsPosXOLD = [[NSMutableArray alloc] initWithArray:objectsPosX];
    objectsPosYOLD = [[NSMutableArray alloc] initWithArray:objectsPosY];
    objectsPosZOLD = [[NSMutableArray alloc] initWithArray:objectsPosZ];
    objectsIDsOLD = [[NSMutableArray alloc] initWithArray:objectsIDs];
    objectsHeightsOLD = [[NSMutableArray alloc] initWithArray:objectsHeights];
    objectsHeightOffsetOLD = [[NSMutableArray alloc] initWithArray:objectsHeightOffset];
    objectsRadiusOLD = [[NSMutableArray alloc] initWithArray:objectsRadius];
    objectsCollisionTypeOLD = [[NSMutableArray alloc] initWithArray:objectsCollisionType];
    objectsGrabbedOLD = [[NSMutableArray alloc] initWithArray:objectsGrabbed];
    
    objectsPosX = nil;
    objectsPosY = nil;
    objectsPosZ = nil;
    objectsIDs = nil;
    objectsHeights = nil;
    objectsHeightOffset = nil;
    objectsRadius = nil;
    objectsCollisionType = nil;
    objectsGrabbed = nil;
    
    objectsPosX = [[NSMutableArray alloc] init];
    objectsPosY = [[NSMutableArray alloc] init];
    objectsPosZ = [[NSMutableArray alloc] init];
    objectsIDs = [[NSMutableArray alloc] init];
    objectsHeights = [[NSMutableArray alloc] init];
    objectsHeightOffset = [[NSMutableArray alloc] init];
    objectsRadius = [[NSMutableArray alloc] init];
    objectsCollisionType = [[NSMutableArray alloc] init];
    objectsGrabbed = [[NSMutableArray alloc] init];
    
    numOfAsteroidsOld = numOfAsteroids;
    numOfAsteroids = 0;
    
    float vrosCurrentClosestHypo = 9999;
    int vrosCurrentClosestObjectID = -1;
    
    motionScore = 0;
    anObjectIsBeingSelectedOLD = anObjectIsBeingSelected;
    if (vrEnabled == 0) { //sends whether an object can be grabbed to menuLayer
        if (anObjectIsBeingSelectedOLDRefresh != anObjectIsBeingSelectedOLD) {
            anObjectIsBeingSelectedOLDRefresh = anObjectIsBeingSelectedOLD;
            
            MenuLayer * mnLayer = (MenuLayer *)[self.parent getChildByName:@"mnLayer" recursively:1];
            [mnLayer getObjectBeingHighlighted:anObjectIsBeingSelectedOLDRefresh];
        }
    }
    anObjectIsBeingSelected = 0;
    
    //used for calculation later
    float playerCosAngle = (positionvar1*16.5)+(3.1415926535897932/2.0);
    if (playerCosAngle > (3.1415926535897932*2.0)) {
        playerCosAngle -= (3.1415926535897932*2.0);
    }
    
    //setting P2aimAngle
    float targetAngle = playerCosAngle;
    if (P2aimAngle < 3.1415926535897932/2.0 && targetAngle > 3.1415926535897932*3.0/2.0) {
        P2aimAngle = P2aimAngle + 3.1415926535897932*2.0;
    } else if (P2aimAngle > 3.1415926535897932*3.0/2.0 && targetAngle < 3.1415926535897932/2.0) {
        P2aimAngle = P2aimAngle - 3.1415926535897932*2.0;
    }
    if (P2aimAngle < targetAngle-0.17) {
        P2aimAngle = P2aimAngle + 0.016;
    } else if (P2aimAngle > targetAngle+0.17) {
        P2aimAngle = P2aimAngle - 0.016;
    } else {
        P2aimAngle = P2aimAngle + ((targetAngle - P2aimAngle)/20.0);
    }
    
    
    
    //objects
    for (CCSprite *sprite in objectArray) {
        object *currentObject = (object *)sprite;
        
        //explosion particles
        if (currentObject.objectid == 53) {
            currentObject.posX = currentObject.posX + currentObject.posXmomentum;
            currentObject.posY = currentObject.posY + currentObject.posYmomentum;
            currentObject.posZ = currentObject.posZ + currentObject.posZmomentum;
        }
        
        //gun
        if (currentObject.objectid == 51) {
            currentObject.pospreXoffset = (cosf(P2aimAngle)*(currentObject.FGOposXmomentum*((((100.0-(float)P2shootTimer)/100.0)*0.1)+0.9)));
            currentObject.pospreZoffset = (sinf(P2aimAngle)*(currentObject.FGOposXmomentum*((((100.0-(float)P2shootTimer)/100.0)*0.1)+0.9)));
        }
        
        //gun missiles
        if (currentObject.objectid == 52) {
            currentObject.posX = currentObject.posX + currentObject.posXmomentum;
            currentObject.posZ = currentObject.posZ + currentObject.posZmomentum;
            
            printf("%.1f, %.1f\n",currentObject.posXmomentum,currentObject.posZmomentum);
            
            if (currentObject.hypotenusetoplayer > 3000) {
                currentObject.deleteObject = 1;
            }
            
            //missile-asteroid collision
            for (int count1 = 1; count1 <= [objectsIDsOLD count]; count1++) {
                int IDcheck = (int)[[objectsIDsOLD objectAtIndex:count1-1] intValue];
                
                if (IDcheck != currentObject.uniqueobjectid) {
                    float posXCheck = [[objectsPosXOLD objectAtIndex:count1-1] floatValue];
                    float posYCheck = [[objectsPosYOLD objectAtIndex:count1-1] floatValue];
                    float posZCheck = [[objectsPosZOLD objectAtIndex:count1-1] floatValue];
                    float heightCheck = [[objectsHeightsOLD objectAtIndex:count1-1] floatValue];
                    float heightOffsetCheck = [[objectsHeightOffsetOLD objectAtIndex:count1-1] floatValue];
                    float radiusCheck = [[objectsRadiusOLD objectAtIndex:count1-1] floatValue];
                    int collisionTypeCheck = (int)[[objectsCollisionTypeOLD objectAtIndex:count1-1] intValue];
                    
                    float hypo = sqrtf(powf(currentObject.posX-posXCheck,2.0)+powf(currentObject.posZ-posZCheck,2.0));
                    
                    if (hypo <= 50.0) { //radius overlap
                        currentObject.deleteObject = 3;
                        for (CCSprite *sprite in objectArray) {
                            object *otherObject = (object *)sprite;
                            if (otherObject.uniqueobjectid == IDcheck) {
                                otherObject.deleteObject = 3;
                            }
                        }
                        
                        //particles
                        int randNumofParticles = [self randomNumberFish];
                        for (int int2 = 0; int2 < 25; int2++) {
                            
                            int randXMom = [self randomNumberFish] * 41;
                            int randYMom = [self randomNumberFish] * 41;
                            int randZMom = [self randomNumberFish] * 41;
                            
                            object *objectNum1 = nil;
                            objectNum1 = [expl1 explParticle1];
                            objectNum1.posX = posXCheck;
                            objectNum1.posY = posYCheck;
                            objectNum1.posZ = posZCheck;
                            objectNum1.posXmomentum = ((float)randXMom-20.0)*0.10;
                            objectNum1.posYmomentum = ((float)randYMom-20.0)*0.10;
                            objectNum1.posZmomentum = ((float)randZMom-20.0)*0.10;
                            
                            float randColorThing = [self randomNumberFish];
                            if (randColorThing < 0.5) {
                                objectNum1.polygonColorRed = 146.0;
                                objectNum1.polygonColorGreen = 117.0;
                                objectNum1.polygonColorBlue = 83.0;
                            } else {
                                objectNum1.polygonColorRed = 102.0;
                                objectNum1.polygonColorGreen = 102.0;
                                objectNum1.polygonColorBlue = 102.0;
                            }
                            
                            [self addChild:objectNum1];
                            [objectTransitionArray addObject:objectNum1];
                        }
                    }
                }
            }
        }
        
        //floor/ceiling/spaceship cabin things
        if (currentObject.objectid == 4 || currentObject.objectid == 50) {
            currentObject.posX = positionX+0.01+currentObject.pospreXoffset;
            currentObject.posY = positionY+0.01+currentObject.pospreYoffset;
            currentObject.posZ = positionZ+0.01+currentObject.pospreZoffset;
        } else if (currentObject.objectid == 51) {
            currentObject.posX = positionX+0.01+currentObject.pospreXoffset;
            currentObject.posY = positionY+0.01+currentObject.pospreYoffset;
            currentObject.posZ = positionZ+0.01+currentObject.pospreZoffset;
        }
        
        if (currentObject.objectusescollisions != 0 && currentObject.objectonhorizon == 0 && currentObject.vrUIelement == 0) {
            motionScore += ((currentObject.posXmomentum+currentObject.posYmomentum+currentObject.posZmomentum+currentObject.rotationoffsetx2)*0.1)+((currentObject.posX+currentObject.posY+currentObject.posZ)*0.001);
        }
        
        //used for calculation later
        float cosAngle = acosf((currentObject.posX-positionX)/sqrtf(powf((currentObject.posX-positionX),2.0)+powf((currentObject.posZ-positionZ),2.0)));
        if ((currentObject.posZ-positionZ) < 0) {
            cosAngle = (3.1415926535897932*2.0)-cosAngle;
        }
        
        bool facingObject = 0;
        bool nearEnoughToShow = 0;
        if (fabsf(cosAngle-playerCosAngle) < (float)(3.1415926535897932/2.0) || fabsf(cosAngle-playerCosAngle-(float)(3.1415926535897932*2.0)) < (float)(3.1415926535897932/2.0) || fabsf(cosAngle-playerCosAngle+(float)(3.1415926535897932*2.0)) < (float)(3.1415926535897932/2.0)) {
            facingObject = 1;
            nearEnoughToShow = 1;
        }
        if (currentObject.hypotenusetoplayer <= currentObject.polygonRadius*2.0 || currentObject.hypotenusetoplayer <= currentObject.objecttoplayerradius*2.0 || currentObject.hypotenusetoplayer < 100) {
            nearEnoughToShow = 1;
        }
        
        //syncing physical properties across multiple instances of HelloWorldLayer2
        if ([tempSyncUniqueIDs containsObject:[NSNumber numberWithInt:currentObject.uniqueobjectid]]) { //checks to see whether object needs syncing
            
            int index = -1;
            for (int i = 0; i < [tempSyncUniqueIDs count]; i++) { //finds index in array of object that needs syncing
                if (currentObject.uniqueobjectid == [[tempSyncUniqueIDs objectAtIndex:i] intValue]) { //found it
                    //apply physical properties from tempSyncPhysicalProperties
                    NSMutableArray *physicalProperties = [tempSyncPhysicalProperties objectAtIndex:i];
                    currentObject.posX = [[physicalProperties objectAtIndex:0] floatValue];
                    currentObject.posY = [[physicalProperties objectAtIndex:1] floatValue];
                    currentObject.posZ = [[physicalProperties objectAtIndex:2] floatValue];
                    currentObject.posXmomentum = [[physicalProperties objectAtIndex:3] floatValue];
                    currentObject.posYmomentum = [[physicalProperties objectAtIndex:4] floatValue];
                    currentObject.posZmomentum = [[physicalProperties objectAtIndex:5] floatValue];
                    currentObject.rotationoffsetx2 = [[physicalProperties objectAtIndex:6] floatValue];
                    
                    index = i;
                }
            }
            
            if (index != -1) { //removes elements from arrays, makes future computation faster
                [tempSyncUniqueIDs removeObjectAtIndex:index];
                [tempSyncPhysicalProperties removeObjectAtIndex:index];
            }
        }
        
        //non-vr elements
        if (currentObject.vrUIelement == 0) {
            
            //stars
            if (currentObject.objectid == 42) {
                //twinkling
                if (currentObject.audiolengthcount == 1) {
                    currentObject.particleDilationRate = currentObject.particleDilationRate+0.11;
                    if (currentObject.particleDilationRate > (3.1415926535897932*2.0)) {
                        currentObject.particleDilationRate = 0;
                    }
                    
                    currentObject.objectScaleXOffset = ((cosf(currentObject.particleDilationRate)*0.2)+1.0);
                    currentObject.objectScaleYOffset = ((cosf(currentObject.particleDilationRate+(3.1415926535897932/3.0))*0.2)+1.0);
                }
            }
            
            //asteroids
            if (currentObject.objectid == 40 || currentObject.objectid == 41 || currentObject.objectid == 48 || currentObject.objectid == 49) {
                numOfAsteroids++;
                
                //rotation
                currentObject.polygonRadius += currentObject.polygonColorRed;
                if (currentObject.polygonRadius >= 360.0) {
                    currentObject.polygonRadius -= 360.0;
                }
                if (currentObject.polygonRadius <= -360.0) {
                    currentObject.polygonRadius += 360.0;
                }
                
                /*//giving initial momentum
                if (currentObject.audiolengthcount != 1) {
                    currentObject.audiolengthcount = 1;
                    
                    currentObject.posXmomentum = ([self randomNumber]-0.5)*0.24;
                    currentObject.posYmomentum = ([self randomNumber]-0.5)*0.24;
                    currentObject.posZmomentum = ([self randomNumber]+0.5)*1.1;
                }*/
                
                [objectsIDs addObject:[NSNumber numberWithInt:currentObject.uniqueobjectid]];
                [objectsPosX addObject:[NSNumber numberWithFloat:currentObject.posX+currentObject.posXmomentum]];
                [objectsPosY addObject:[NSNumber numberWithFloat:currentObject.posY+currentObject.posYmomentum]];
                [objectsPosZ addObject:[NSNumber numberWithFloat:currentObject.posZ+currentObject.posZmomentum]];
                [objectsHeights addObject:[NSNumber numberWithFloat:currentObject.standardHeight]];
                [objectsHeightOffset addObject:[NSNumber numberWithFloat:currentObject.collisionyoffset]];
                [objectsRadius addObject:[NSNumber numberWithFloat:currentObject.objecttoobjectradius]];
                [objectsCollisionType addObject:[NSNumber numberWithInt:currentObject.objectusescollisions]];
                [objectsGrabbed addObject:[NSNumber numberWithInt:currentObject.objectgrabbed]];
            }
            
            //dust particles
            if (currentObject.objectid == 44) {
                currentObject.posX = currentObject.posX + currentObject.posXmomentum;
                currentObject.posY = currentObject.posY + currentObject.posYmomentum;
                currentObject.posZ = currentObject.posZ + currentObject.posZmomentum;
                
                //rotation
                if (currentObject.audiorange != 0) {
                    currentObject.polygonRadius = currentObject.polygonRadius + currentObject.audiorange;
                }
            }
            
            //arrow for help/direction
            if (currentObject.objectid == 21) {
                float radius = 31;
                currentObject.posX = (sinf(-(atan(0)+(positionvar1*16.5))) * radius) + positionX;
                currentObject.posY = 3.8 + positionYactual - (rotationY*4.0);
                currentObject.posZ = (cosf(-(atan(0)+(positionvar1*16.5))) * radius) + positionZ;
                
                float cosAngle2 = acosf((currentObject.posX-colorupX)/sqrtf(powf((currentObject.posX-colorupX),2.0)+powf((currentObject.posZ-colorupZ),2.0)));
                if ((currentObject.posZ-colorupZ) < 0) {
                    cosAngle2 = (3.1415926535897932*2.0)-cosAngle2;
                }
                currentObject.particleDilationRate = cosAngle2;
            }
            
            //color, refreshing sprites
            if (currentObject.colorIDrefresh != colorID && currentObject.isafloorobject == 0) {
                currentObject.colorIDrefresh = colorID;
                
                if (levelTypeHWL2 == 2) {
                    if (currentObject.objectid == 39 || currentObject.objectid == 43) {
                        if (currentObject.colorExposeID == 8) { //orange
                            currentObject.polygonColorRed = 253.0;
                            currentObject.polygonColorGreen = 152.0;
                            currentObject.polygonColorBlue = 64.0;
                        } else if (currentObject.colorExposeID == 9) { //red
                            currentObject.polygonColorRed = 229.0;
                            currentObject.polygonColorGreen = 65.0;
                            currentObject.polygonColorBlue = 73.0;
                        } else if (currentObject.colorExposeID == 10) { //pink
                            currentObject.polygonColorRed = 238.0;
                            currentObject.polygonColorGreen = 101.0;
                            currentObject.polygonColorBlue = 190.0;
                        } else if (currentObject.colorExposeID == 11) { //purple
                            currentObject.polygonColorRed = 146.0;
                            currentObject.polygonColorGreen = 35.0;
                            currentObject.polygonColorBlue = 237.0;
                        } else if (currentObject.colorExposeID == 5) { //brown
                            currentObject.polygonColorRed = 146.0;
                            currentObject.polygonColorGreen = 117.0;
                            currentObject.polygonColorBlue = 83.0;
                        } else if (currentObject.colorExposeID == 2) { //blue
                            currentObject.polygonColorRed = 23.0;
                            currentObject.polygonColorGreen = 60.0;
                            currentObject.polygonColorBlue = 196.0;
                        } else if (currentObject.colorExposeID == 6) { //grey
                            currentObject.polygonColorRed = 102.0;
                            currentObject.polygonColorGreen = 102.0;
                            currentObject.polygonColorBlue = 102.0;
                        }
                    } else if (currentObject.objectid == 42) {
                        if (colorID == 2) { //blue
                            currentObject.polygonColorRed = 23.0;
                            currentObject.polygonColorGreen = 60.0;
                            currentObject.polygonColorBlue = 196.0;
                        } else if (colorID == 3) { //green
                            currentObject.polygonColorRed = 34.0;
                            currentObject.polygonColorGreen = 157.0;
                            currentObject.polygonColorBlue = 196.0;
                        } else if (colorID <= 5) { //yellow
                            currentObject.polygonColorRed = 255.0;
                            currentObject.polygonColorGreen = 253.0;
                            currentObject.polygonColorBlue = 196.0;
                        } else { //grey
                            currentObject.polygonColorRed = 255.0;
                            currentObject.polygonColorGreen = 255.0;
                            currentObject.polygonColorBlue = 255.0;
                        }
                    } else if (currentObject.objectid == 45) { //planets
                        if (currentObject.colorExposeID == 9) { //red
                            currentObject.polygonColorRed = 229.0;
                            currentObject.polygonColorGreen = 65.0;
                            currentObject.polygonColorBlue = 73.0;
                        } else if (currentObject.colorExposeID == 11) { //purple
                            currentObject.polygonColorRed = 146.0;
                            currentObject.polygonColorGreen = 35.0;
                            currentObject.polygonColorBlue = 237.0;
                        } else if (currentObject.colorExposeID == 5) { //brown
                            currentObject.polygonColorRed = 146.0;
                            currentObject.polygonColorGreen = 117.0;
                            currentObject.polygonColorBlue = 83.0;
                        } else if (currentObject.colorExposeID == 2) { //blue
                            currentObject.polygonColorRed = 23.0;
                            currentObject.polygonColorGreen = 60.0;
                            currentObject.polygonColorBlue = 196.0;
                        } else if (currentObject.colorExposeID == 6) { //grey
                            currentObject.polygonColorRed = 102.0;
                            currentObject.polygonColorGreen = 102.0;
                            currentObject.polygonColorBlue = 102.0;
                        } else if (currentObject.colorExposeID == 3) { //green
                            currentObject.polygonColorRed = 34.0;
                            currentObject.polygonColorGreen = 156.0;
                            currentObject.polygonColorBlue = 100.0;
                        }
                    } else if (currentObject.objectid == 46) { //planet rings
                        if (currentObject.colorExposeID == 9) { //red
                            currentObject.polygonColorRed = 229.0;
                            currentObject.polygonColorGreen = 65.0;
                            currentObject.polygonColorBlue = 73.0;
                        } else if (currentObject.colorExposeID == 11) { //purple
                            currentObject.polygonColorRed = 146.0;
                            currentObject.polygonColorGreen = 35.0;
                            currentObject.polygonColorBlue = 237.0;
                        } else if (currentObject.colorExposeID == 4) { //yellow
                            currentObject.polygonColorRed = 255.0;
                            currentObject.polygonColorGreen = 253.0;
                            currentObject.polygonColorBlue = 114.0;
                        } else if (currentObject.colorExposeID == 8) { //orange
                            currentObject.polygonColorRed = 253.0;
                            currentObject.polygonColorGreen = 152.0;
                            currentObject.polygonColorBlue = 64.0;
                        } else if (currentObject.colorExposeID == 10) { //pink
                            currentObject.polygonColorRed = 238.0;
                            currentObject.polygonColorGreen = 101.0;
                            currentObject.polygonColorBlue = 190.0;
                        }
                    }
                }
            }
            
            //spinning colorup
            if (currentObject.objectid == 8) {
                currentObject.polygonRadius += 0.45+((float)(1.0-collectingColorupTrans)*0.8);
                if (currentObject.polygonRadius >= 360.0) {
                    currentObject.polygonRadius -= 360.0;
                }
            }
            
            //colorup & bg
            if (currentObject.objectid == 7 || currentObject.objectid == 8) {
                
                //visibility safety
                if (currentObject.objectinvisible != 0) {
                    currentObject.objectinvisible = 0;
                }
                
                //detecting if player is facing colorup
                if (currentObject.objectid == 7 && colorID <= 2) {
                    float cosAngle3 = acosf((colorupX-positionX)/sqrtf(powf((colorupX-positionX),2.0)+powf((colorupZ-positionZ),2.0)));
                    if ((colorupZ-positionZ) < 0) {
                        cosAngle3 = (3.1415926535897932*2.0)-cosAngle3;
                    }
                    
                    if (fabsf(cosAngle3-playerCosAngle) < (float)(3.1415926535897932/3.4) || fabsf(cosAngle3-playerCosAngle-(float)(3.1415926535897932*2.0)) < (float)(3.1415926535897932/3.4) || fabsf(cosAngle3-playerCosAngle+(float)(3.1415926535897932*2.0)) < (float)(3.1415926535897932/3.4)) {
                        facingColorup = 1;
                    } else if (facingColorup != 0) {
                        facingColorup = 0;
                    }
                } else if (currentObject.objectid == 7 && colorID > 2 && facingColorup != 1) {
                    facingColorup = 1;
                }
                
                if (collectingColorup != 0) {
                    float targetX = (sinf(-(atan(0) + (positionvar1*16.5))) * colorupHypo) + positionX;
                    float targetY = positionYactual;
                    float targetZ = (cosf(-(atan(0) + (positionvar1*16.5))) * colorupHypo) + positionZ;
                    currentObject.posX = currentObject.posX + ((targetX-currentObject.posX)/((30.0*collectingColorupTrans)+1.0));
                    currentObject.posY = currentObject.posY + ((targetY-currentObject.posY)/((30.0*collectingColorupTrans)+1.0));
                    currentObject.posZ = currentObject.posZ + ((targetZ-currentObject.posZ)/((30.0*collectingColorupTrans)+1.0));
                }
            }
            
            //delete object
            if (currentObject.objectid == 21) {
                if (currentObject.deleteObject > 0) {
                    currentObject.standardScale = currentObject.standardScale + ((0.0-currentObject.standardScale)/10.0);
                    if (currentObject.standardScale < 0.01) {
                        [objectRemovalArray addObject:currentObject];
                    }
                } else {
                    currentObject.standardScale = currentObject.standardScale + ((1.0-currentObject.standardScale)/10.0);
                }
            } else {
                if (currentObject.deleteObject > 0) {
                    if (currentObject.deleteObject < 2) {
                        currentObject.deleteObject++;
                    } else {
                        [objectRemovalArray addObject:currentObject];
                    }
                }
            }
            
            //object highlight
            if (currentObject.playerusable != 0 && currentObject.isasubobject == 0) {
                float var1 = atan(0)+(positionvar1*16.5);
                float testPosX = (sinf(-var1) * (sqrtf(powf(50.0,2.0)))) + positionX;
                float testPosY = (2.64 + positionYactual)-((rotationY+((90.0+(float)gyroRollOffset)*0.08)) * 2.2);
                if (iPadVarMain != 1) {
                    testPosY = (2.64 + positionYactual)-((rotationY+((90.0+(float)gyroRollOffset)*0.08)) * 1.52);
                }
                float testPosZ = (cosf(-var1) * (sqrtf(powf(40.0,2.0)))) + positionZ;
                float hypoCheck1 = sqrtf(powf(currentObject.posX-testPosX, 2.0)+powf(currentObject.posY-testPosY, 2.0)+powf(currentObject.posZ-testPosZ, 2.0));
                
                if (hypoCheck1 < 40.0 && hypoCheck1 < vrosCurrentClosestHypo && currentObject.postposZ > positionZ && currentObject.objectgrabbed == 0 && grabbedobject == 0) {
                    vrosCurrentClosestHypo = hypoCheck1;
                    vrosCurrentClosestObjectID = currentObject.uniqueobjectid;
                }
            }
            if (currentObject.uniqueobjectid == vrosClosestObjectID && currentObject.objectBeingHighlighted != 1 && currentObject.isasubobject == 0) {
                currentObject.objectBeingHighlighted = 1;
                
                //printf("OBJECT BEING HIGHLIGHTED: %.1f\n",currentObject.hypotenusetoplayer);
                
                for (CCSprite *sprite in objectArray) {
                    object *otherObject = (object *)sprite;
                    if (otherObject.parentobjectid == currentObject.uniqueobjectid && otherObject != currentObject && otherObject.deleteObject != 1) {
                        otherObject.objectBeingHighlighted = 1;
                    }
                }
            } else if (currentObject.uniqueobjectid != vrosClosestObjectID && currentObject.objectBeingHighlighted != 0 && currentObject.isasubobject == 0) {
                currentObject.objectBeingHighlighted = 0;
                
                for (CCSprite *sprite in objectArray) {
                    object *otherObject = (object *)sprite;
                    if (otherObject.parentobjectid == currentObject.uniqueobjectid && otherObject != currentObject && otherObject.deleteObject != 1) {
                        otherObject.objectBeingHighlighted = 0;
                    }
                }
            }
            
            //selection animation
            if (currentObject.objectBeingHighlighted != 0 && anObjectIsBeingSelected == 0) {
                anObjectIsBeingSelected = 1;
            }
            
            //picking up objects
            if (currentObject.canbePickedUp != 0 && currentObject.hasbeenPickedUp == 1) {
                float targetvelx = (positionX - currentObject.posX)/2.0;
                float targetvely = ((positionYactual-10) - currentObject.posY)/2.0;
                float targetvelz = (positionZ - currentObject.posZ)/2.0;
                currentObject.posXmomentum = currentObject.posXmomentum + ((targetvelx - currentObject.posXmomentum)/10.0);
                currentObject.posYmomentum = currentObject.posYmomentum + ((targetvely - currentObject.posYmomentum)/10.0);
                currentObject.posZmomentum = currentObject.posZmomentum + ((targetvelz - currentObject.posZmomentum)/10.0);
                
                if (currentObject.posX < positionX+4 && currentObject.posX > positionX-4) {
                    if (currentObject.posZ < positionZ+4 && currentObject.posZ > positionZ-4) {
                        if (currentObject.posY < (positionYactual-10)+3 && currentObject.posY > (positionYactual-10)-3) {
                            [objectRemovalArray addObject:currentObject];
                            printf("Pick-up item successfully picked up\n");
                            
                            //execute specific actions here
                            
                            //plays collection sound
                            if (vrPrimaryInstance == 1) {
                                int randnum145 = arc4random() % 15;
                                float randnum1452 = 1.2 + ((float)randnum145/22.0);
                                [[OALSimpleAudio sharedInstance] playEffect:@"Jump004.wav" volume:1.0 pitch:randnum1452 pan:0.0 loop:0];
                            }
                        }
                    }
                }
            }
            
            //particles
            if (currentObject.isaparticle == 1) {
                currentObject.particleDilation = currentObject.particleDilation + ((0.0 - currentObject.particleDilation)/currentObject.particleDilationRate);
                if (currentObject.particleDilation <= 0.002) {
                    [objectRemovalArray addObject:currentObject];
                }
            }
            
            //player on top of floating objects detection
            if (currentObject.isahillgradientobject == 0 && playerGravityEnabled == 1) {
                if (positionY >= (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset)+playerHeight-3 && currentObject.hypotenusetoplayer < (currentObject.objecttoplayerradius*0.75) && currentObject.hypotenusetoplayer > -(currentObject.objecttoplayerradius*0.75) && minYpos-2 <= (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset)+playerHeight && currentObject.objectstackable == 1 && currentObject.isasubobject == 0) {
                    if (currentObject.overLiquidBase == 1 || currentObject.overAnotherFloatingObject == 1 || currentObject.oLBfuncYoffset != 0) {
                        onTopOfFloatingObjects = 1;
                        positionYanimoffsetPotential = currentObject.oLBfuncYoffset;
                    }
                }
            }
            
            //player minimum height
            if (playerCollisionsEnabled == 1) {
                if (momentumX != 0 || momentumZ != 0) {
                    if (currentObject.isahillgradientobject == 0) {
                        minYpospotential = (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset)+playerHeight+gravityBuffer2;
                        if (positionY > (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset)+playerHeight && currentObject.hypotenusetoplayer < (currentObject.objecttoplayerradius*0.75) && currentObject.hypotenusetoplayer > -(currentObject.objecttoplayerradius*0.75) && minYpos < (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset)+playerHeight && currentObject.objectstackable == 1 && currentObject.isasubobject == 0) {
                            minYpos = (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset)+playerHeight+gravityBuffer2;
                        }
                    } else {
                        minYpospotential = (currentObject.posY-(currentObject.standardHeight/2)-(currentObject.hillHeight/2)+(currentObject.hillHeight*(currentObject.objecttoplayerradius/(currentObject.hypotenusetoplayer+currentObject.objecttoplayerradius)))+currentObject.collisionyoffset)+playerHeight;
                        if (positionY >= (currentObject.posY-(currentObject.standardHeight/2)+currentObject.collisionyoffset)+playerHeight && currentObject.hypotenusetoplayer < currentObject.objecttoplayerradius && currentObject.hypotenusetoplayer > -currentObject.objecttoplayerradius && currentObject.isasubobject == 0) {
                            minYpos = minYpospotential;
                        }
                    }
                }
            }
            
            //spawning sub objects
            if (currentObject.objectusessubobjects == 1 && currentObject.spawnpartnerobjects == 0) {
                currentObject.spawnpartnerobjects = 1;
                
                //dev, create subobjects
            }
            
            //horizon objects
            if (currentObject.objectonhorizon == 1) {
                currentObject.posY = currentObject.minyposition + positionY;
                if (currentObject.objectid >= 39 && levelTypeHWL2 == 2) {
                    currentObject.posY = currentObject.minyposition + positionY + currentObject.pospreYoffset;
                }
                currentObject.posX = positionX + currentObject.pospreXoffset;
                currentObject.posZ = positionZ + currentObject.pospreZoffset;
            }
            
            //usable object animation
            if (currentObject.usableanimtoggle == 1 && currentObject.objectgrabbed == 1) {
                currentObject.usableposYoffsetanim = currentObject.usableposYoffsetanim+((-16-currentObject.usableposYoffsetanim)/2.0);
                currentObject.usableposZoffsetanim = currentObject.usableposZoffsetanim+((25-currentObject.usableposZoffsetanim)/2.0);
                currentObject.usableposXoffsetanim = currentObject.usableposXoffsetanim+((-15-currentObject.usableposXoffsetanim)/2.0);
                if (currentObject.usableposYoffsetanim <= -14) {
                    currentObject.usableanimtoggle = 2;
                }
            } else if (currentObject.usableanimtoggle == 2 && currentObject.objectgrabbed == 1) {
                currentObject.usableposYoffsetanim = currentObject.usableposYoffsetanim+((4-currentObject.usableposYoffsetanim)/4.0);
                currentObject.usableposZoffsetanim = currentObject.usableposZoffsetanim+((-15-currentObject.usableposZoffsetanim)/4.0);
                currentObject.usableposXoffsetanim = currentObject.usableposXoffsetanim+((10-currentObject.usableposXoffsetanim)/4.0);
                if (currentObject.usableposYoffsetanim >= 3.8) {
                    currentObject.usableanimtoggle = 3;
                }
            } else if (currentObject.usableanimtoggle == 3 && currentObject.objectgrabbed == 1) {
                currentObject.usableposYoffsetanim = currentObject.usableposYoffsetanim+((0-currentObject.usableposYoffsetanim)/24.0);
                currentObject.usableposZoffsetanim = currentObject.usableposZoffsetanim+((0-currentObject.usableposZoffsetanim)/24.0);
                currentObject.usableposXoffsetanim = currentObject.usableposXoffsetanim+((0-currentObject.usableposXoffsetanim)/24.0);
                if (currentObject.usableposYoffsetanim <= 0.3) {
                    currentObject.usableanimtoggle = 0;
                }
            } else if (currentObject.objectgrabbed == 0 && currentObject.isasubobject == 0 && currentObject.objectid != 38) {
                currentObject.usableanimtoggle = 0;
                currentObject.usableposXoffsetanim = 0;
                currentObject.usableposYoffsetanim = 0;
                currentObject.usableposZoffsetanim = 0;
            }
            
            //object grabbed
            if (currentObject.objectgrabbed == 1 && currentObject.isasubobject == 0) {
                
                currentObject.posYmomentum = 0;
                
                //resets float anim offset
                currentObject.oLBfuncYoffset = currentObject.oLBfuncYoffset + ((0 - currentObject.oLBfuncYoffset)/12.0);
                currentObject.oLBfuncX = 2.8*(3.1415926535897932*2.0);
                
                //sets main variables
                if (grabbedobject == 1) {
                    
                    currentObject.pospreYoffset2 = -((rotationY+((90.0+(float)gyroRollOffset)*0.08)) * 2.2);
                    if (iPadVarMain != 1) {
                        currentObject.pospreYoffset2 = -((rotationY+((90.0+(float)gyroRollOffset)*0.08)) * 1.52);
                    }
                    
                    grabobjectvar1 = atan(0) + (positionvar1*16.5);
                    grabobjectvar2 = (sqrtf(powf((currentObject.objecttoplayerradius + 1), 2)));
                    grabobjectposx = (sinf(-grabobjectvar1) * grabobjectvar2) + positionX;
                    grabobjectposy = 3.7 + positionYactual;
                    grabobjectposz = (cosf(-grabobjectvar1) * grabobjectvar2) + positionZ;
                    //printf("GOP X: %f Y: %f Z: %f\n",grabobjectposx,grabobjectposy,grabobjectposz);
                    
                    currentObject.rotationoffsetx2 = currentObject.rotationoffsetx2 + ((currentObject.rotationtargetoffsetx2 - currentObject.rotationoffsetx2)/4.0);
                    
                    //changes walking speed if carrying heavy object
                    if (currentObject.objectheavy == 1) {
                        if (walkingSpeed > 0.5) {
                            walkingSpeed = 0.5;
                        }
                    }
                }
                
                //checks and fixes grab duplicates
                for (CCSprite *sprite in objectArray) {
                    object *otherObject = (object *)sprite;
                    
                    if (otherObject.objectgrabbed == 1 && otherObject.hypotenusetoplayer > currentObject.hypotenusetoplayer && otherObject != currentObject) {
                        otherObject.objectgrabbed = 0;
                    } else if (otherObject.objectgrabbed == 1 && otherObject.hypotenusetoplayer < currentObject.hypotenusetoplayer && otherObject != currentObject) {
                        currentObject.objectgrabbed = 0;
                    } else if (otherObject.objectgrabbed == 1 && otherObject != currentObject) {
                        otherObject.objectgrabbed = 0;
                    }
                }
                
                //physical effects
                currentObject.FGOposXmomentum = ((grabobjectposx - currentObject.posX)/3.0);
                currentObject.FGOposYmomentum = ((grabobjectposy - currentObject.posY)/3.0);
                currentObject.FGOposZmomentum = ((grabobjectposz - currentObject.posZ)/3.0);
                currentObject.posX = currentObject.posX + currentObject.FGOposXmomentum;
                currentObject.posY = currentObject.posY + currentObject.FGOposYmomentum + currentObject.pospreYoffset2;
                currentObject.posZ = currentObject.posZ + currentObject.FGOposZmomentum;
            }
            
            //fov effects
            currentObject.preposX = currentObject.posX;
            currentObject.preposY = currentObject.posY;
            currentObject.preposZ = currentObject.posZ;
            
            //adjusts position according to rotationx
            currentObject.calcZ2 = atan((currentObject.preposX - (positionX+VRoffsetX))/(currentObject.preposZ - (positionZ+VRoffsetZ))) + (CC_DEGREES_TO_RADIANS(rotationX+(gyroYawOffset/16.5))*16.5);
            if ((currentObject.preposZ - (positionZ+VRoffsetZ)) >= 0) {
                currentObject.calcZ3 = sqrtf(powf((currentObject.preposX - (positionX+VRoffsetX)), 2) + powf((currentObject.preposZ - (positionZ+VRoffsetZ)), 2));
            } else {
                currentObject.calcZ3 = -(sqrtf(powf((currentObject.preposX - (positionX+VRoffsetX)), 2) + powf((currentObject.preposZ - (positionZ+VRoffsetZ)), 2)));
            }
            if (currentObject.objectid == 7 || currentObject.objectid == 8) {
                currentObject.postposY = currentObject.posY+currentObject.usableposYoffsetanim+currentObject.oLBfuncYoffset+(sinf(hoverAnimX)*2.0*collectingColorupTrans);
            } else {
                currentObject.postposY = currentObject.posY+currentObject.usableposYoffsetanim+currentObject.oLBfuncYoffset;
            }
            currentObject.postposZ = (cosf(currentObject.calcZ2) * currentObject.calcZ3)+(positionZ+VRoffsetZ)+currentObject.usableposZoffsetanim;
            currentObject.postposX = (sinf(currentObject.calcZ2) * currentObject.calcZ3)+(positionX+VRoffsetX)+currentObject.usableposXoffsetanim;
            
            //collision detection & momentum variables
            if (currentObject.posZ > positionZ) {
                currentObject.PREangletoplayer = (atan((currentObject.preposX - positionX)/(currentObject.preposZ - positionZ)));
            } else {
                currentObject.PREangletoplayer = 3.1415926535897932 + (atan((currentObject.preposX - positionX)/(currentObject.preposZ - positionZ)));
            }
            if (currentObject.PREangletoplayer < 0) {
                currentObject.angletoplayer = currentObject.PREangletoplayer + (3.1415926535897932*2.0);
            } else {
                currentObject.angletoplayer = currentObject.PREangletoplayer;
            }
            currentObject.hypotenusetoplayer = sqrtf(powf((currentObject.preposX - positionX), 2) + powf((currentObject.preposZ - positionZ), 2));
            
            if (currentObject.objecttag != 0) {
                //printf("\nx distance: %f, angle w rotation: %f, hypotenuse: %f\n",(currentObject.posX - positionX),currentObject.calcZ5,currentObject.calcZ3);
                //printf("z diff: %f, postposz: %f, hypotenuse: %f\n",(currentObject.posZ - positionZ),currentObject.postposZ,currentObject.calcZ3);
                //printf("hypotenuse to player: %f, angle: %f\n",currentObject.hypotenusetoplayer,CC_RADIANS_TO_DEGREES(currentObject.angletoplayer));
                //printf("correct x: %f, current x:%f\n",currentObject.collisioncorrectposx,positionX);
                //printf("correct z: %f, current z:%f\n",currentObject.collisioncorrectposz,positionZ);
                //printf("rotation2: %f, calcz4: %f\n",currentObject.rotationoffsetx2,currentObject.calcZ4);
                //printf("ob%i miny: %.2f, minyinitial: %.2f\n",currentObject.objecttag,currentObject.minyposition,currentObject.mininitialyposition);
            }
            
            //z-ordering & invisibility
            float threeAxisHypotenuse = sqrtf(powf(currentObject.posX-positionX,2.0)/*+powf(currentObject.posY-positionY,2.0)*/+powf(currentObject.posZ-positionZ,2.0));
            if (currentObject.isafloorobject == 0 || currentObject.objectid == 29) {
                if (currentObject.objectonhorizon == 0) {
                    if (levelTypeHWL2 == 2) {
                        [currentObject setZOrder:299999-(threeAxisHypotenuse*1.2)+currentObject.actual2DZorder/*-(fabsf(currentObject.posY-positionY+playerHeight)*0.05)*/];
                    } else {
                        if (currentObject.posY >= 0) {
                            [currentObject setZOrder:299999-(threeAxisHypotenuse*1.2)+currentObject.actual2DZorder/*-(fabsf(currentObject.posY-positionY+playerHeight)*0.05)*/];
                        } else {
                            [currentObject setZOrder:199999-(threeAxisHypotenuse*1.2)+currentObject.actual2DZorder/*-(fabsf(currentObject.posY-positionY+playerHeight)*0.05)*/];
                        }
                    }
                } else {
                    [currentObject setZOrder:99999-sqrtf(threeAxisHypotenuse*1.2)+currentObject.actual2DZorder];
                }
            } else if (currentObject.isafloorobject == 2) { //horizontal floor pieces, //dev
                [currentObject setZOrder:299999-(threeAxisHypotenuse*1.2)-(currentObject.polygonRadius*1.2)+currentObject.actual2DZorder/*-(fabsf(currentObject.posY-positionY+playerHeight)*0.05)*/];
            } else if (currentObject.isafloorobject == 3) { //vertical floor pieces, //dev
                [currentObject setZOrder:299999-(threeAxisHypotenuse*1.2)+currentObject.actual2DZorder];
            } else if (currentObject.isafloorobject == 4) { //custom arrow object
                [currentObject setZOrder:300000];
            }
            
            if (currentObject.objectinvisible == 1 && currentObject.parentsubinvisiblewhenscalenegative == 1) {
                currentObject.visible = NO;
            } else if (currentObject.objectinvisible == 0 && currentObject.parentsubinvisiblewhenscalenegative == 1) {
                currentObject.visible = YES;
            }
            currentObject.visible = facingObject;
            if (currentObject.objectinvisible == 1 && currentObject.parentsubinvisiblewhenscalenegative == 0 && currentObject.visible != NO) {
                currentObject.visible = NO;
            }
            
            //distance toggle (custom for each object)
            float vrDamper = 1.0;
            if (vrEnabled == 1) {
                vrDamper = 0.66;
            }
            bool hideShowCondition = nearEnoughToShow;
            if (vrEnabled == 0) {
                hideShowCondition = 1;
            }
            
            //parent objects (only for non-static parent composite objects)
            if (currentObject.objectusessubobjects == 1) {
                for (CCSprite *sprite in objectArray) {
                    object *otherObject = (object *)sprite;
                    if (otherObject.parentobjectid == currentObject.uniqueobjectid && otherObject != currentObject) {
                        otherObject.rotationoffsetx2 = currentObject.rotationoffsetx2;
                        if (otherObject.pospreZoffset == 0) {
                            otherObject.rotationoffsetvar1 = (otherObject.rotationoffsetx2);
                            otherObject.rotationscalevar1 = (otherObject.rotationoffsetx2) + currentObject.angletoplayer;
                        } else {
                            otherObject.rotationoffsetvar1 = atan(((otherObject.pospreXoffset)/(otherObject.pospreZoffset))) + (otherObject.rotationoffsetx2);
                            otherObject.rotationscalevar1 = atan(((otherObject.pospreXoffset)/(otherObject.pospreZoffset))) + (otherObject.rotationoffsetx2) + currentObject.angletoplayer;
                        }
                        if (otherObject.pospreZoffset >= 0) {
                            otherObject.rotationoffsetvar2 = (sqrtf(powf(otherObject.pospreXoffset, 2) + powf(otherObject.pospreZoffset, 2)));
                        } else {
                            otherObject.rotationoffsetvar2 = -(sqrtf(powf(otherObject.pospreXoffset, 2) + powf(otherObject.pospreZoffset, 2)));
                        }
                        otherObject.rotationscalevar2 = (sinf(-otherObject.rotationscalevar1) * otherObject.rotationoffsetvar2);
                        float rotationscalevar3 = (cosf(-otherObject.rotationscalevar1) * otherObject.rotationoffsetvar2);
                        
                        otherObject.posXoffset = (sinf(-otherObject.rotationoffsetvar1) * otherObject.rotationoffsetvar2);
                        otherObject.posYoffset = otherObject.pospreYoffset;
                        otherObject.posZoffset = (cosf(-otherObject.rotationoffsetvar1) * otherObject.rotationoffsetvar2);
                        otherObject.posX = (otherObject.posXoffset * currentObject.objectScaleX) + currentObject.posX;
                        otherObject.posY = (otherObject.posYoffset * currentObject.objectScaleY) + currentObject.posY + currentObject.usableposYoffsetanim + currentObject.oLBfuncYoffset;
                        otherObject.posZ = (otherObject.posZoffset * currentObject.objectScaleX) + currentObject.posZ;
                        
                        if (otherObject.parentsubinvisiblewhenscalenegative == 1) {
                            if (rotationscalevar3 > 0) {
                                otherObject.objectinvisible = 1;
                            } else {
                                otherObject.objectinvisible = 0;
                            }
                        }
                    }
                }
            }
            
            //opacity & shading
            if (currentObject.visible == YES) {
                //opacity
                if (currentObject.isasmallobject == 0 && currentObject.objectonhorizon == 0) { //normal objects
                    float sampleOpacity = 0;
                    if (currentObject.hypotenusetoplayer < 2200) {
                        if (currentObject.isaparticle == 0) {
                            sampleOpacity = (2200 - currentObject.hypotenusetoplayer)*1.5;
                        } else {
                            sampleOpacity = (2200 - currentObject.hypotenusetoplayer)*1.5*currentObject.particleDilation;
                        }
                    } else {
                        sampleOpacity = 0;
                    }
                    
                    if (currentObject.objectid == 45 || currentObject.objectid == 46) {
                        sampleOpacity = 255.0;
                    }
                    
                    if (sampleOpacity < 0) {
                        currentObject.opacity = 0;
                        currentObject.visible = NO;
                    } else if (sampleOpacity > 255) {
                        currentObject.opacity = (255.0/255.0)*currentObject.customOpacity;
                        if (currentObject.objectBeingHighlighted != 0) {
                            currentObject.opacity = (255.0/255.0)*currentObject.customOpacity*(0.75+(sinf(vrosSelectionAnimX)*0.25));
                        }
                    } else {
                        currentObject.opacity = (sampleOpacity/255.0)*currentObject.customOpacity;
                        if (currentObject.objectBeingHighlighted != 0) {
                            currentObject.opacity = (sampleOpacity/255.0)*currentObject.customOpacity*(0.75+(sinf(vrosSelectionAnimX)*0.25));
                        }
                    }
                } else if (currentObject.isasmallobject == 1 && currentObject.objectonhorizon == 0) { //small objects
                    if (currentObject.objectid == 24) {
                        float sampleOpacity = 0;
                        if (currentObject.hypotenusetoplayer < 490) {
                            if (currentObject.isaparticle == 0) {
                                sampleOpacity = (490 - currentObject.hypotenusetoplayer)*2.0;
                            } else {
                                sampleOpacity = (490 - currentObject.hypotenusetoplayer)*2.0*currentObject.particleDilation;
                            }
                        } else {
                            sampleOpacity = 0;
                        }
                        
                        if (sampleOpacity < 0) {
                            currentObject.opacity = 0;
                            currentObject.visible = NO;
                        } else if (sampleOpacity > 255) {
                            currentObject.opacity = (255.0/255.0)*currentObject.customOpacity;
                            if (currentObject.objectBeingHighlighted != 0) {
                                currentObject.opacity = (255.0/255.0)*currentObject.customOpacity*(0.75+(sinf(vrosSelectionAnimX)*0.25));
                            }
                        } else {
                            currentObject.opacity = (sampleOpacity/255.0)*currentObject.customOpacity;
                            if (currentObject.objectBeingHighlighted != 0) {
                                currentObject.opacity = (sampleOpacity/255.0)*currentObject.customOpacity*(0.75+(sinf(vrosSelectionAnimX)*0.25));
                            }
                        }
                    } else {
                        float sampleOpacity = 0;
                        if (currentObject.hypotenusetoplayer < 450) {
                            if (currentObject.isaparticle == 0) {
                                sampleOpacity = (450 - currentObject.hypotenusetoplayer)*2.0;
                            } else {
                                sampleOpacity = (450 - currentObject.hypotenusetoplayer)*2.0*currentObject.particleDilation;
                            }
                        } else {
                            sampleOpacity = 0;
                        }
                        
                        if (sampleOpacity < 0) {
                            currentObject.opacity = 0;
                            currentObject.visible = NO;
                        } else if (sampleOpacity > 255) {
                            currentObject.opacity = (255.0/255.0)*currentObject.customOpacity;
                            if (currentObject.objectBeingHighlighted != 0) {
                                currentObject.opacity = (255.0/255.0)*currentObject.customOpacity*(0.75+(sinf(vrosSelectionAnimX)*0.25));
                            }
                        } else {
                            currentObject.opacity = (sampleOpacity/255.0)*currentObject.customOpacity;
                            if (currentObject.objectBeingHighlighted != 0) {
                                currentObject.opacity = (sampleOpacity/255.0)*currentObject.customOpacity*(0.75+(sinf(vrosSelectionAnimX)*0.25));
                            }
                        }
                    }
                }
                
                //shading
                if (shadeDistance > 15) { //minimum shade distance
                    if (currentObject.visible == YES && currentObject.opacity != 0 && currentObject.objectonhorizon == 0) {
                        float calcVar = (shadeDistance-currentObject.hypotenusetoplayer)/shadeDistance;
                        if (currentObject.objectid == 7 || currentObject.objectid == 8 || currentObject.objectid == 15 || currentObject.objectid == 43 || currentObject.objectid == 45 || currentObject.objectid == 46 || currentObject.objectid == 52 || currentObject.objectid == 53) {
                            calcVar = 1.0;
                        }
                        if (calcVar <= 0) {
                            currentObject.color = [CCColor colorWithCcColor3b:ccc3(0,0,0)];
                            
                            //polygon exceptions
                            if (currentObject.isafloorobject != 0) {
                                currentObject.polygonShade = 0;
                            }
                        } else if (calcVar > 1.0) {
                            currentObject.color = [CCColor colorWithCcColor3b:ccc3(255.0,255.0,255.0)];
                            
                            //polygon exceptions
                            if (currentObject.isafloorobject != 0) {
                                currentObject.polygonShade = 1;
                            }
                        } else {
                            currentObject.color = [CCColor colorWithCcColor3b:ccc3(255.0*calcVar,255.0*calcVar,255.0*calcVar)];
                            if (currentObject.objectid == 43 || currentObject.objectid == 45 || currentObject.objectid == 46 || currentObject.objectid == 52 || currentObject.objectid == 53) {
                                currentObject.color = [CCColor colorWithCcColor3b:ccc3(currentObject.polygonColorRed,currentObject.polygonColorGreen,currentObject.polygonColorBlue)];
                            }
                            
                            //polygon exceptions
                            if (currentObject.isafloorobject != 0) {
                                currentObject.polygonShade = calcVar;
                            }
                        }
                    } else if (currentObject.visible == YES && currentObject.opacity != 0 && currentObject.objectonhorizon != 0) {
                        if (shadeDistance > 1000) {
                            currentObject.color = [CCColor colorWithCcColor3b:ccc3(255.0,255.0,255.0)];
                        } else {
                            currentObject.color = [CCColor colorWithCcColor3b:ccc3(255.0*((shadeDistance+500)/1500.0),255.0*((shadeDistance+500)/1500.0),255.0*((shadeDistance+500)/1500.0))];
                        }
                        
                        if (levelTypeHWL2 == 2) {
                            currentObject.color = [CCColor colorWithCcColor3b:ccc3(currentObject.polygonColorRed,currentObject.polygonColorGreen,currentObject.polygonColorBlue)];
                        }
                    }
                }
                
                //horizon objects (vr invisibility)
                if (currentObject.objectonhorizon != 0) {
                    float sampleOpacity = 255.0;
                    
                    if (sampleOpacity > 255) {
                        currentObject.opacity = (255.0/255.0)*currentObject.customOpacity;
                    } else {
                        currentObject.opacity = (sampleOpacity/255.0)*currentObject.customOpacity;
                    }
                }
            } else if (currentObject.isafloorobject == 2 && currentObject.postposZ <= positionZ && currentObject.postposZ >= positionZ-currentObject.polygonRadius) {
                float calcVar = (shadeDistance-currentObject.hypotenusetoplayer)/shadeDistance;
                if (calcVar <= 0) {
                    currentObject.polygonShade = 0;
                } else if (calcVar > 1.0) {
                    currentObject.polygonShade = 1;
                } else {
                    currentObject.polygonShade = calcVar;
                }
            }
            
            //position & real-time variables
            bool visibleCheck = 1;
            if (currentObject.visible == NO || currentObject.opacity <= 0) {
                visibleCheck = 0;
            }
            if (visibleCheck == 1) {
                if ((currentObject.postposZ - (positionZ+VRoffsetZ)) == 0) {
                    currentObject.calcX1 = 0;
                    currentObject.calcY1 = 0;
                } else {
                    currentObject.calcX1 = (((currentObject.postposX - (positionX+VRoffsetX))) * (100/(currentObject.postposZ - (positionZ+VRoffsetZ))));
                    currentObject.calcY1 = (((currentObject.postposY - (positionYactual+VRoffsetY))) * (100/(currentObject.postposZ - (positionZ+VRoffsetZ))));
                }
                if (currentObject.visible == YES) {
                    if (currentObject.dontVaryPerspective == 0 && currentObject.isinvisibleparentobject == 0) {
                        currentObject.rotationoffsetx = -((rotationX+(gyroYawOffset/16.5)) * 16.5);
                        currentObject.calcZ1 = (asinf((currentObject.postposX - (positionX+VRoffsetX))/(currentObject.hypotenusetoplayer))*180/3.141592654)+currentObject.rotationoffsetx+(currentObject.rotationoffsetx2 * 57.2957779);
                        if (currentObject.objectid >= 33 && currentObject.objectid <= 37) {
                            float fakeCalcZ2 = atan((currentObject.preposX - positionX)/(currentObject.preposZ - positionZ)) + (CC_DEGREES_TO_RADIANS(rotationX+(gyroYawOffset/16.5))*16.5);
                            float fakeCalcZ3 = 0;
                            if ((currentObject.preposZ - positionZ) >= 0) {
                                fakeCalcZ3 = sqrtf(powf((currentObject.preposX - positionX), 2) + powf((currentObject.preposZ - positionZ), 2));
                            } else {
                                fakeCalcZ3 = -(sqrtf(powf((currentObject.preposX - positionX), 2) + powf((currentObject.preposZ - positionZ), 2)));
                            }
                            float fakePostPosX = (sinf(fakeCalcZ2) * fakeCalcZ3)+positionX+currentObject.usableposXoffsetanim;
                            currentObject.calcZ1 = (asinf((fakePostPosX - positionX)/(currentObject.hypotenusetoplayer))*180/3.141592654)+currentObject.rotationoffsetx+(currentObject.rotationoffsetx2 * 57.2957779);
                        }
                        
                        //makes sure FinCalcZ1 is between 0 & 360 degrees
                        float FinCalcZ1 = 0;
                        int Calcz0 = 0;
                        if (currentObject.calcZ1 < 0) {
                            Calcz0 = (currentObject.calcZ1-360)/360;
                        } else {
                            Calcz0 = (currentObject.calcZ1)/360;
                        }
                        if (Calcz0 != 0) {
                            FinCalcZ1 = currentObject.calcZ1-((float)Calcz0*360.0);
                        } else {
                            FinCalcZ1 = currentObject.calcZ1;
                        }
                        
                        int graphicFrames = 0; //number of available frames
                        int rotationFrames = 0; //number of frames per full rotation (360 degrees)
                    }
                } else if (currentObject.visible == NO) {
                    if (currentObject.texturePerspective != -9999) {
                        currentObject.texturePerspective = -9999;
                    }
                }
                
                //scale
                if (currentObject.isinvisibleparentobject == 0) {
                    if (currentObject.objectonhorizon == 0) {
                        if (currentObject.changescaleX == 0) {
                            currentObject.scaleX = (((currentObject.randomflipped*-2)+1)*(100/(currentObject.postposZ - (positionZ+VRoffsetZ))) * currentObject.objectScaleX * currentObject.objectScaleXOffset * FOVvalue * currentObject.standardScale) * isiPhone6PlusCoeff;
                        } else {
                            if (currentObject.rotationscalevar2 >= 0) {
                                currentObject.scaleX = (((currentObject.randomflipped*-2)+1)*(100/(currentObject.postposZ - (positionZ+VRoffsetZ))) * currentObject.objectScaleX * currentObject.objectScaleXOffset * FOVvalue * currentObject.standardScale) * ((currentObject.rotationoffsetvar2-currentObject.rotationscalevar2)/currentObject.rotationoffsetvar2) * isiPhone6PlusCoeff;
                            } else {
                                currentObject.scaleX = (((currentObject.randomflipped*-2)+1)*(100/(currentObject.postposZ - (positionZ+VRoffsetZ))) * currentObject.objectScaleX * currentObject.objectScaleXOffset * FOVvalue * currentObject.standardScale) * ((currentObject.rotationoffsetvar2+currentObject.rotationscalevar2)/currentObject.rotationoffsetvar2) * isiPhone6PlusCoeff;
                            }
                        }
                        if (currentObject.isafloorobject == 0) {
                            currentObject.scaleY = ((100/(currentObject.postposZ - (positionZ+VRoffsetZ))) * currentObject.objectScaleY * FOVvalue * currentObject.standardScale) * (currentObject.objectScaleYOffset) * isiPhone6PlusCoeff;
                        } else {
                            float distanceCalc1 = 1.0;
                            float distanceCalc2 = 0;
                            float distanceCalc3 = 0;
                            if (currentObject.posY >= positionYactual) {
                                //dev, change value if needed later
                                //IF FLOOR OBJECT IS HIGHER THAN PLAYER, NO CURRENT Y SCALE CHANGE
                                distanceCalc2 = 0;
                            } else {
                                //IF FLOOR OBJECT IS LOWER THAN PLAYER, Y SCALE CHANGE
                                distanceCalc2 = atanf((positionYactual-currentObject.posY)/currentObject.hypotenusetoplayer);
                            }
                            if (positionYactual >= currentObject.posY && ((positionYactual-currentObject.posY)/60.0) <= 0.69) {
                                distanceCalc3 = ((positionYactual-currentObject.posY)/60.0);
                            } else if (positionYactual >= currentObject.posY) {
                                distanceCalc3 = 0.69;
                            } else if (positionYactual < currentObject.posY) {
                                distanceCalc3 = 0.0;
                            }
                            if (currentObject.hypotenusetoplayer < 70) {
                                distanceCalc1 = 1.0+((70-currentObject.hypotenusetoplayer)/170.0);
                            }
                            currentObject.scaleY = (((((60/(currentObject.postposZ - (positionZ+VRoffsetZ)))*(100/(currentObject.hypotenusetoplayer+180)))*distanceCalc1)+(distanceCalc2*0.35*distanceCalc3)) * currentObject.objectScaleY * FOVvalue * currentObject.standardScale) * (currentObject.objectScaleYOffset) * isiPhone6PlusCoeff;
                        }
                    } else if (currentObject.visible == YES) {
                        if (currentObject.changescaleX == 0) {
                            currentObject.scaleX = (((currentObject.randomflipped*-2)+1)*(100/(currentObject.postposZ - (positionZ+VRoffsetZ))) * currentObject.objectScaleX * currentObject.objectScaleXOffset * FOVvalue * currentObject.standardScale) * isiPhone6PlusCoeff;
                        } else {
                            if (currentObject.rotationscalevar2 >= 0) {
                                currentObject.scaleX = (((currentObject.randomflipped*-2)+1)*(100/(currentObject.postposZ - (positionZ+VRoffsetZ))) * currentObject.objectScaleX * currentObject.objectScaleXOffset * FOVvalue * currentObject.standardScale) * ((currentObject.rotationoffsetvar2-currentObject.rotationscalevar2)/currentObject.rotationoffsetvar2) * isiPhone6PlusCoeff;
                            } else {
                                currentObject.scaleX = (((currentObject.randomflipped*-2)+1)*(100/(currentObject.postposZ - (positionZ+VRoffsetZ))) * currentObject.objectScaleX * currentObject.objectScaleXOffset * FOVvalue * currentObject.standardScale) * ((currentObject.rotationoffsetvar2+currentObject.rotationscalevar2)/currentObject.rotationoffsetvar2) * isiPhone6PlusCoeff;
                            }
                        }
                        currentObject.scaleY = ((100/(currentObject.postposZ - (positionZ+VRoffsetZ))) * currentObject.objectScaleY * FOVvalue * currentObject.standardScale) * (currentObject.objectScaleYOffset) * isiPhone6PlusCoeff;
                    }
                }
                
                //position & rotation update
                currentObject.finalposX = (currentObject.calcX1*FOVvalue);
                currentObject.finalposY = (currentObject.calcY1*FOVvalue);
                if (currentObject.objectonhorizon == 1) {
                    currentObject.finalposY = currentObject.finalposY-0.5;
                }
                if (currentObject.finalposY != 0) {
                    if (currentObject.finalposX != 0) {
                        currentObject.FOVrotationobjectvar1 = atan(currentObject.finalposX/currentObject.finalposY) + (FOVrotationrad);
                    } else {
                        currentObject.FOVrotationobjectvar1 = FOVrotationrad;
                    }
                } else {
                    if (currentObject.finalposX != 0) {
                        currentObject.FOVrotationobjectvar1 = -(atan(currentObject.finalposX/currentObject.finalposY)) + (FOVrotationrad);
                    } else {
                        currentObject.FOVrotationobjectvar1 = FOVrotationrad;
                    }
                }
                if (currentObject.finalposY > 0) {
                    currentObject.FOVrotationobjectvar2 = sqrtf(powf(currentObject.finalposX, 2) + powf(currentObject.finalposY, 2));
                } else {
                    currentObject.FOVrotationobjectvar2 = -(sqrtf(powf(currentObject.finalposX, 2) + powf(currentObject.finalposY, 2)));
                }
                currentObject.FOVrotationobjectvar3 = (sinf(currentObject.FOVrotationobjectvar1) * currentObject.FOVrotationobjectvar2);
                currentObject.FOVrotationobjectvar4 = (cosf(currentObject.FOVrotationobjectvar1) * currentObject.FOVrotationobjectvar2);
                currentObject.position = ccp((currentObject.FOVrotationobjectvar3 + (winSize.width/2)),(currentObject.FOVrotationobjectvar4 + (winSize.height/2.0) + vrGlobalYOffset + (rotationY+((90.0+(float)gyroRollOffset)*0.08))*45.0));
                if (currentObject.isinvisibleparentobject == 0) {
                    if (currentObject.objectid == 8 || currentObject.objectid == 40 || currentObject.objectid == 41 || currentObject.objectid == 44 || currentObject.objectid == 48 || currentObject.objectid == 49) {
                        currentObject.rotation = FOVrotation-gyroPitchOffset+currentObject.polygonRadius;
                    } else {
                        currentObject.rotation = FOVrotation-gyroPitchOffset;
                    }
                }
            }
            
            //detects collisions for liquid base objects
            if (currentObject.liquidBase == 1 && playerGravityEnabled == 1) {
                if (currentObject.hypotenusetoplayer <= currentObject.objecttoplayerradius && positionY-playerHeight+(momentumY*2.0) <= currentObject.posY+3) {
                    playerInLiquid = 1;
                    if (walkingSpeed > currentObject.liquidViscosity) {
                        walkingSpeed = currentObject.liquidViscosity;
                    }
                    if (currentViscosityOfLiquid > currentObject.liquidViscosity) {
                        currentViscosityOfLiquid = currentObject.liquidViscosity;
                    }
                }
            }
            
            if (playerCollisionsEnabled == 0) {
                if (currentObject.exemptFromPlayerCollisionsTimer != 5) {
                    currentObject.exemptFromPlayerCollisionsTimer = 5;
                }
            }
            if (currentObject.hasbeenPickedUp == 0) {
                if (currentObject.objectusescollisions == 0) {
                    if (currentObject.objectusesgravity == 1) {
                        
                        //checks for player & object collisions if is a collectable object
                        if (currentObject.canbePickedUp != 0) {
                            
                            //exemption from player collisions timer
                            if (currentObject.exemptFromPlayerCollisionsTimer > 0 && playerCollisionsEnabled == 1) {
                                currentObject.exemptFromPlayerCollisionsTimer--;
                            } else if (currentObject.exemptFromPlayerCollisionsTimer < 0) {
                                currentObject.exemptFromPlayerCollisionsTimer = 0;
                            }
                            
                            //player collisions
                            if (playerCollisionsEnabled == 1) {
                                if (currentObject.hypotenusetoplayer < (currentObject.objecttoplayerradius*0.75) && currentObject.hypotenusetoplayer > -(currentObject.objecttoplayerradius*0.75) && positionY-playerHeight > (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset) && currentObject.objectstackable == 1) {
                                } else if (currentObject.hypotenusetoplayer < (currentObject.objecttoplayerradius*0.75) && currentObject.hypotenusetoplayer > -(currentObject.objecttoplayerradius*0.75) && positionY-playerHeight+30 >= (currentObject.posY-(currentObject.standardHeight/2)+currentObject.collisionyoffset) && positionY-playerHeight <= (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset) && currentObject.isahillgradientobject == 0 && currentObject.exemptFromPlayerCollisionsTimer <= 0) {
                                    
                                    if (currentObject.hasbeenPickedUp == 0) {
                                        currentObject.hasbeenPickedUp = 1;
                                    }
                                } else if (currentObject.hypotenusetoplayer < currentObject.objecttoplayerradius*1.3 && currentObject.hypotenusetoplayer > -currentObject.objecttoplayerradius*1.3 && positionY-playerHeight+30 <= (currentObject.posY-(currentObject.standardHeight/2)+currentObject.collisionyoffset)) {
                                    currentObject.refreshminypos = 1;
                                }
                            }
                            
                            //collectables hover animation
                            if (currentObject.posY > currentObject.minyposition+4.0 || currentObject.hasbeenPickedUp != 0) {
                                if (currentObject.visible == YES && currentObject.opacity > 0) {
                                    currentObject.oLBfuncYoffset = currentObject.oLBfuncYoffset + ((0 - currentObject.oLBfuncYoffset)/12.0);
                                    currentObject.oLBfuncX = 2.8*(3.1415926535897932*2.0);
                                } else {
                                    currentObject.oLBfuncYoffset = 0;
                                    currentObject.oLBfuncX = 0;
                                }
                            } else {
                                currentObject.oLBfuncX = currentObject.oLBfuncX + 0.4;
                                float calcVarUno = sinf((float)currentObject.oLBfuncX/(3.1415926535897932*2.0));
                                currentObject.oLBfuncYoffset = currentObject.oLBfuncYoffset + (((6.0+(calcVarUno*3.0)) - currentObject.oLBfuncYoffset)/12.0);
                                if (currentObject.oLBfuncX > 32*(3.1415926535897932*2.0)) {
                                    currentObject.oLBfuncX = 0;
                                }
                            }
                        }
                        
                        //y momentum & gravity
                        if (levelTypeHWL2 != 2) {
                            if (currentObject.posY+(currentObject.posYmomentum-gravityBuffer1) > currentObject.minyposition && currentObject.objectgrabbed == 0 && currentObject.objectusesgravity == 1) {
                                if (levelTypeHWL2 == 1) {
                                    currentObject.posYmomentum = currentObject.posYmomentum-(0.15*0.4);
                                } else {
                                    currentObject.posYmomentum = currentObject.posYmomentum-0.15;
                                }
                            } else if (currentObject.posY+(currentObject.posYmomentum-gravityBuffer1) <= currentObject.minyposition && currentObject.objectgrabbed == 0 && currentObject.posYmomentum != 0 && currentObject.objectusesgravity == 1) {
                                //printf("momentumy: %f\n",currentObject.posYmomentum);
                                currentObject.posY = currentObject.minyposition;
                                if (currentObject.posYmomentum < -gravityBuffer1) { //y bounce threshold
                                    if (levelTypeHWL2 == 1) {
                                        currentObject.posYmomentum = -currentObject.posYmomentum*0.65;
                                    } else {
                                        currentObject.posYmomentum = -currentObject.posYmomentum*0.75;
                                    }
                                } else { //eliminates bounce to avoid phasing through other objects
                                    currentObject.posYmomentum = 0;
                                }
                                //printf(" - %f\n",currentObject.posYmomentum);
                            } else if (currentObject.posY+gravityBuffer1 < currentObject.minyposition && currentObject.objectgrabbed == 0) {
                                currentObject.posY = currentObject.minyposition;
                                if (levelTypeHWL2 == 1) {
                                    currentObject.posYmomentum = 2.7*0.35;
                                } else {
                                    currentObject.posYmomentum = 2.7;
                                }
                            }
                            
                            //x momentum
                            if (currentObject.posXmomentum != 0) {
                                if (currentObject.posY <= currentObject.minyposition) {
                                    currentObject.posXmomentum = currentObject.posXmomentum * 0.9;
                                } else {
                                    currentObject.posXmomentum = currentObject.posXmomentum * 0.98;
                                }
                            }
                            //z momentum
                            if (currentObject.posZmomentum != 0) {
                                if (currentObject.posY <= currentObject.minyposition) {
                                    currentObject.posZmomentum = currentObject.posZmomentum * 0.9;
                                } else {
                                    currentObject.posZmomentum = currentObject.posZmomentum * 0.98;
                                }
                            }
                        }
                        
                        //applies momentum & gravity
                        if (currentObject.posYmomentum != 0) {
                            currentObject.posY = currentObject.posY + currentObject.posYmomentum;
                        }
                        if (currentObject.posXmomentum != 0) {
                            currentObject.posX = currentObject.posX + currentObject.posXmomentum;
                        }
                        if (currentObject.posZmomentum != 0) {
                            currentObject.posZ = currentObject.posZ + currentObject.posZmomentum;
                        }
                    }
                } else if (currentObject.objectusescollisions == 1 && currentObject.isasubobject == 0) { //submissive collisions
                    
                    //exemption from player collisions timer
                    if (currentObject.exemptFromPlayerCollisionsTimer > 0 && playerCollisionsEnabled == 1) {
                        currentObject.exemptFromPlayerCollisionsTimer--;
                    } else if (currentObject.exemptFromPlayerCollisionsTimer < 0) {
                        currentObject.exemptFromPlayerCollisionsTimer = 0;
                    }
                    
                    //detects only moving objects
                    if (currentObject.posXmomentum != 0 || currentObject.posZmomentum != 0 || currentObject.posYmomentum < -gravityBuffer1 || currentObject.objectgrabbed != 0 || currentObject.refreshminypos != 0) {
                        //min y position safety
                        if (currentObject.minyposition != currentObject.mininitialyposition) {
                            currentObject.minyposition = currentObject.mininitialyposition;
                        }
                        currentObject.overLiquidBase = 0;
                        currentObject.overAnotherFloatingObject = 0;
                        currentObject.overLiquidViscosity = 1.0;
                        for (CCSprite *sprite in objectArray) {
                            object *otherObject = (object *)sprite;
                            if (otherObject.objectusescollisions == 1 && otherObject.objectgrabbed == 0 && otherObject != currentObject) {
                                //gets sin&cos (angle) to otherObject
                                float var1 = asinf((otherObject.posZ-currentObject.posZ)/(sqrtf(powf(otherObject.posX-currentObject.posX, 2) + powf((otherObject.posZ-currentObject.posZ), 2)))); //negative = down, positive = up
                                float var2 = asinf((otherObject.posX-currentObject.posX)/(sqrtf(powf(otherObject.posX-currentObject.posX, 2) + powf((otherObject.posZ-currentObject.posZ), 2)))); //negative = left, positive = right
                                float var3 = 0;
                                float var4 = 0;
                                //sets closest point to other object
                                if (var2 >= 0) {
                                    var3 = (cosf(var1)*currentObject.objecttoobjectradius)+currentObject.posX;
                                    var4 = (sinf(var1)*currentObject.objecttoobjectradius)+currentObject.posZ;
                                } else if (var2 < 0) {
                                    var3 = -(cosf(var1)*currentObject.objecttoobjectradius)+currentObject.posX;
                                    var4 = (sinf(var1)*currentObject.objecttoobjectradius)+currentObject.posZ;
                                }
                                
                                //gets sin&cos (angle) to currentObject
                                float var5 = asinf((currentObject.posZ-otherObject.posZ)/(sqrtf(powf(currentObject.posX-otherObject.posX, 2) + powf((currentObject.posZ-otherObject.posZ), 2)))); //negative = down, positive = up
                                float var6 = asinf((currentObject.posX-otherObject.posX)/(sqrtf(powf(currentObject.posX-otherObject.posX, 2) + powf((currentObject.posZ-otherObject.posZ), 2)))); //negative = left, positive = right
                                float var7;
                                float var8;
                                //sets closest point to current object
                                if (var6 >= 0) {
                                    var7 = (cosf(var5)*otherObject.objecttoobjectradius)+otherObject.posX;
                                    var8 = (sinf(var5)*otherObject.objecttoobjectradius)+otherObject.posZ;
                                } else if (var6 < 0) {
                                    var7 = -(cosf(var5)*otherObject.objecttoobjectradius)+otherObject.posX;
                                    var8 = (sinf(var5)*otherObject.objecttoobjectradius)+otherObject.posZ;
                                }
                                
                                //printf("\n");
                                
                                //tests for overlapping radii
                                bool radiioverlapping = 0;
                                if (currentObject.posX <= var3 && currentObject.posZ <= var4 && var3 >= var7 && var4 >= var8) { //Q1
                                    if (otherObject.posX > var7 && otherObject.posZ > var8) { //Q3, matches Q1
                                                                                              //printf("Q1vQ3 collision\n");
                                        radiioverlapping = 1;
                                    }
                                } else if (currentObject.posX > var3 && currentObject.posZ <= var4 && var3 <= var7 && var4 >= var8) { //Q2
                                    if (otherObject.posX <= var7 && otherObject.posZ > var8) { //Q4, matches Q2
                                                                                               //printf("Q2vQ4 collision\n");
                                        radiioverlapping = 1;
                                    }
                                } else if (currentObject.posX <= var3 && currentObject.posZ > var4 && var3 >= var7 && var4 <= var8) { //Q4
                                    if (otherObject.posX > var7 && otherObject.posZ <= var8) { //Q2, matches Q4
                                                                                               //printf("Q4vQ2 collision\n");
                                        radiioverlapping = 1;
                                    }
                                } else if (currentObject.posX > var3 && currentObject.posZ > var4 && var3 <= var7 && var4 <= var8) { //Q3
                                    if (otherObject.posX <= var7 && otherObject.posZ <= var8) { //Q1, matches Q3
                                                                                                //printf("Q3vQ1 collision\n");
                                        radiioverlapping = 1;
                                    }
                                }
                                
                                //post-radii overlap
                                if (radiioverlapping == 1) {
                                    if (currentObject.posY-(currentObject.posYmomentum-gravityBuffer1) > (otherObject.posY+(otherObject.standardHeight/2)+otherObject.collisionyoffset)+((currentObject.standardHeight/2)+currentObject.collisionyoffset) && currentObject.minyposition < (otherObject.posY+(otherObject.standardHeight/2)+otherObject.collisionyoffset)+((currentObject.standardHeight/2)+currentObject.collisionyoffset) && (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset) > (otherObject.posY+(otherObject.standardHeight/2)+otherObject.collisionyoffset) && currentObject.posY >= otherObject.posY && otherObject.objectstackable == 1) { //OBJECT STACK, resets minyposition
                                        if (otherObject.isahillgradientobject == 0) {
                                            currentObject.minyposition = otherObject.posY+(otherObject.standardHeight/2)+otherObject.collisionyoffset+((currentObject.standardHeight/2)+currentObject.collisionyoffset);
                                            if (otherObject.oLBfuncYoffset != 0 && otherObject.overLiquidBase == 1 && currentObject.objectgrabbed == 0) {
                                                currentObject.oLBfuncYoffset = otherObject.oLBfuncYoffset;
                                                currentObject.overAnotherFloatingObject = 1;
                                            } else if (otherObject.overAnotherFloatingObject == 1 && currentObject.objectgrabbed == 0) {
                                                currentObject.oLBfuncYoffset = otherObject.oLBfuncYoffset;
                                                currentObject.overAnotherFloatingObject = 1;
                                            }
                                        } else {
                                            currentObject.refreshminypos = 1;
                                        }
                                    } else if (currentObject.posY-(currentObject.posYmomentum-gravityBuffer1) < (otherObject.posY+(otherObject.standardHeight/2)+otherObject.collisionyoffset)+((currentObject.standardHeight/2)+currentObject.collisionyoffset) && currentObject.posY >= otherObject.posY) { //collision
                                        
                                        float cOpreXmom = 0;
                                        float cOpreZmom = 0;
                                        float oOpreXmom = 0;
                                        float oOpreZmom = 0;
                                        
                                        if (currentObject.posXmomentum > -1.0 && currentObject.posXmomentum < 1.0) {
                                            cOpreXmom = 0;
                                        } else {
                                            cOpreXmom = currentObject.posXmomentum;
                                        }
                                        if (currentObject.posZmomentum > -1.0 && currentObject.posZmomentum < 1.0) {
                                            cOpreZmom = 0;
                                        } else {
                                            cOpreZmom = currentObject.posZmomentum;
                                        }
                                        if (otherObject.posXmomentum > -1.0 && otherObject.posXmomentum < 1.0) {
                                            oOpreXmom = 0;
                                        } else {
                                            oOpreXmom = otherObject.posXmomentum;
                                        }
                                        if (otherObject.posZmomentum > -1.0 && otherObject.posZmomentum < 1.0) {
                                            oOpreZmom = 0;
                                        } else {
                                            oOpreZmom = otherObject.posZmomentum;
                                        }
                                        
                                        //printf("collision 1: %.2f, %.2f, %.2f, %.2f\n",cOpreXmom,cOpreZmom,oOpreXmom,oOpreZmom);
                                        
                                        if (currentObject.objectgrabbed == 0 && currentObject.objectheavy == 0) {
                                            currentObject.posXmomentum = ((-(var3-currentObject.posX))*0.16)+(oOpreXmom*0.9);
                                            currentObject.posZmomentum = ((-(var4-currentObject.posZ))*0.16)+(oOpreZmom*0.9);
                                        } else if (currentObject.objectgrabbed == 0 && currentObject.objectheavy == 1) {
                                            currentObject.posXmomentum = ((-(var3-currentObject.posX))*0.11)+(oOpreXmom*0.9);
                                            currentObject.posZmomentum = ((-(var4-currentObject.posZ))*0.11)+(oOpreZmom*0.9);
                                        }
                                        if (otherObject.objectgrabbed == 0 && otherObject.objectheavy == 0) {
                                            otherObject.posXmomentum = ((-(var7-otherObject.posX))*0.16)+(cOpreXmom*0.9);
                                            otherObject.posZmomentum = ((-(var8-otherObject.posZ))*0.16)+(cOpreZmom*0.9);
                                        } else if (otherObject.objectgrabbed == 0 && otherObject.objectheavy == 1) {
                                            otherObject.posXmomentum = ((-(var7-otherObject.posX))*0.11)+(cOpreXmom*0.9);
                                            otherObject.posZmomentum = ((-(var8-otherObject.posZ))*0.11)+(cOpreZmom*0.9);
                                        }
                                    } else if ((currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset) >= (otherObject.posY-(otherObject.standardHeight/2)+otherObject.collisionyoffset)+gravityBuffer1 && currentObject.posY <= otherObject.posY) { //collision
                                        
                                        float cOpreXmom = 0;
                                        float cOpreZmom = 0;
                                        float oOpreXmom = 0;
                                        float oOpreZmom = 0;
                                        
                                        if (currentObject.posXmomentum > -1.0 && currentObject.posXmomentum < 1.0) {
                                            cOpreXmom = 0;
                                        } else {
                                            cOpreXmom = currentObject.posXmomentum;
                                        }
                                        if (currentObject.posZmomentum > -1.0 && currentObject.posZmomentum < 1.0) {
                                            cOpreZmom = 0;
                                        } else {
                                            cOpreZmom = currentObject.posZmomentum;
                                        }
                                        if (otherObject.posXmomentum > -1.0 && otherObject.posXmomentum < 1.0) {
                                            oOpreXmom = 0;
                                        } else {
                                            oOpreXmom = otherObject.posXmomentum;
                                        }
                                        if (otherObject.posZmomentum > -1.0 && otherObject.posZmomentum < 1.0) {
                                            oOpreZmom = 0;
                                        } else {
                                            oOpreZmom = otherObject.posZmomentum;
                                        }
                                        
                                        //printf("collision 1: %.2f, %.2f, %.2f, %.2f\n",cOpreXmom,cOpreZmom,oOpreXmom,oOpreZmom);
                                        
                                        if (currentObject.objectgrabbed == 0 && currentObject.objectheavy == 0) {
                                            currentObject.posXmomentum = ((-(var3-currentObject.posX))*0.16)+(oOpreXmom*0.9);
                                            currentObject.posZmomentum = ((-(var4-currentObject.posZ))*0.16)+(oOpreZmom*0.9);
                                        } else if (currentObject.objectgrabbed == 0 && currentObject.objectheavy == 1) {
                                            currentObject.posXmomentum = ((-(var3-currentObject.posX))*0.11)+(oOpreXmom*0.9);
                                            currentObject.posZmomentum = ((-(var4-currentObject.posZ))*0.11)+(oOpreZmom*0.9);
                                        }
                                        if (otherObject.objectgrabbed == 0 && otherObject.objectheavy == 0) {
                                            otherObject.posXmomentum = ((-(var7-otherObject.posX))*0.16)+(cOpreXmom*0.9);
                                            otherObject.posZmomentum = ((-(var8-otherObject.posZ))*0.16)+(cOpreZmom*0.9);
                                        } else if (otherObject.objectgrabbed == 0 && otherObject.objectheavy == 1) {
                                            otherObject.posXmomentum = ((-(var7-otherObject.posX))*0.11)+(cOpreXmom*0.9);
                                            otherObject.posZmomentum = ((-(var8-otherObject.posZ))*0.11)+(cOpreZmom*0.9);
                                        }
                                    } else if (currentObject.posY > otherObject.posY && otherObject.objectgrabbed == 0) {
                                        otherObject.refreshminypos = 1;
                                    }
                                }
                            } else if (otherObject.objectusescollisions == 2 && otherObject.objectgrabbed == 0 && otherObject != currentObject) {
                                //gets sin&cos (angle) to otherObject
                                float var1 = asinf((otherObject.posZ-currentObject.posZ)/(sqrtf(powf(otherObject.posX-currentObject.posX, 2) + powf((otherObject.posZ-currentObject.posZ), 2)))); //negative = down, positive = up
                                float var2 = asinf((otherObject.posX-currentObject.posX)/(sqrtf(powf(otherObject.posX-currentObject.posX, 2) + powf((otherObject.posZ-currentObject.posZ), 2)))); //negative = left, positive = right
                                float var3 = 0;
                                float var4 = 0;
                                //sets closest point to other object
                                if (var2 >= 0) {
                                    var3 = (cosf(var1)*currentObject.objecttoobjectradius)+currentObject.posX;
                                    var4 = (sinf(var1)*currentObject.objecttoobjectradius)+currentObject.posZ;
                                } else if (var2 < 0) {
                                    var3 = -(cosf(var1)*currentObject.objecttoobjectradius)+currentObject.posX;
                                    var4 = (sinf(var1)*currentObject.objecttoobjectradius)+currentObject.posZ;
                                }
                                
                                //gets sin&cos (angle) to currentObject
                                float var5 = asinf((currentObject.posZ-otherObject.posZ)/(sqrtf(powf(currentObject.posX-otherObject.posX, 2) + powf((currentObject.posZ-otherObject.posZ), 2)))); //negative = down, positive = up
                                float var6 = asinf((currentObject.posX-otherObject.posX)/(sqrtf(powf(currentObject.posX-otherObject.posX, 2) + powf((currentObject.posZ-otherObject.posZ), 2)))); //negative = left, positive = right
                                float var7;
                                float var8;
                                //sets closest point to current object
                                if (var6 >= 0) {
                                    var7 = (cosf(var5)*otherObject.objecttoobjectradius)+otherObject.posX;
                                    var8 = (sinf(var5)*otherObject.objecttoobjectradius)+otherObject.posZ;
                                } else if (var6 < 0) {
                                    var7 = -(cosf(var5)*otherObject.objecttoobjectradius)+otherObject.posX;
                                    var8 = (sinf(var5)*otherObject.objecttoobjectradius)+otherObject.posZ;
                                }
                                
                                //tests for overlapping radii
                                bool radiioverlapping = 0;
                                if (currentObject.posX <= var3 && currentObject.posZ <= var4 && var3 >= var7 && var4 >= var8) { //Q1
                                    if (otherObject.posX > var7 && otherObject.posZ > var8) { //Q3, matches Q1
                                        radiioverlapping = 1;
                                    }
                                } else if (currentObject.posX > var3 && currentObject.posZ <= var4 && var3 <= var7 && var4 >= var8) { //Q2
                                    if (otherObject.posX <= var7 && otherObject.posZ > var8) { //Q4, matches Q2
                                        radiioverlapping = 1;
                                    }
                                } else if (currentObject.posX <= var3 && currentObject.posZ > var4 && var3 >= var7 && var4 <= var8) { //Q4
                                    if (otherObject.posX > var7 && otherObject.posZ <= var8) { //Q2, matches Q4
                                        radiioverlapping = 1;
                                    }
                                } else if (currentObject.posX > var3 && currentObject.posZ > var4 && var3 <= var7 && var4 <= var8) { //Q3
                                    if (otherObject.posX <= var7 && otherObject.posZ <= var8) { //Q1, matches Q3
                                        radiioverlapping = 1;
                                    }
                                }
                                
                                //post-radii overlap
                                if (radiioverlapping == 1) {
                                    if (currentObject.posY-(currentObject.posYmomentum-gravityBuffer1) > (otherObject.posY+(otherObject.standardHeight/2)+otherObject.collisionyoffset)+((currentObject.standardHeight/2)+currentObject.collisionyoffset) && currentObject.minyposition < (otherObject.posY+(otherObject.standardHeight/2)+otherObject.collisionyoffset)+((currentObject.standardHeight/2)+currentObject.collisionyoffset) && (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset) > (otherObject.posY+(otherObject.standardHeight/2)+otherObject.collisionyoffset) && currentObject.posY >= otherObject.posY && otherObject.objectstackable == 1) { //OBJECT STACK, resets minyposition
                                        if (otherObject.isahillgradientobject == 0) {
                                            currentObject.minyposition = otherObject.posY+(otherObject.standardHeight/2)+otherObject.collisionyoffset+((currentObject.standardHeight/2)+currentObject.collisionyoffset);
                                            if (otherObject.oLBfuncYoffset != 0 && otherObject.overLiquidBase == 1 && currentObject.objectgrabbed == 0) {
                                                currentObject.oLBfuncYoffset = otherObject.oLBfuncYoffset;
                                                currentObject.overAnotherFloatingObject = 1;
                                            } else if (otherObject.overAnotherFloatingObject == 1 && currentObject.objectgrabbed == 0) {
                                                currentObject.oLBfuncYoffset = otherObject.oLBfuncYoffset;
                                                currentObject.overAnotherFloatingObject = 1;
                                            }
                                        } else {
                                            currentObject.refreshminypos = 1;
                                        }
                                    } else if (currentObject.posY-(currentObject.posYmomentum-gravityBuffer1) < (otherObject.posY+(otherObject.standardHeight/2)+otherObject.collisionyoffset)+((currentObject.standardHeight/2)+currentObject.collisionyoffset) && currentObject.posY >= otherObject.posY) { //collision
                                        if (currentObject.objectgrabbed == 0) {
                                            if (currentObject.objectheavy == 0) {
                                                currentObject.posXmomentum = (-(var3-currentObject.posX))*0.16;
                                                currentObject.posZmomentum = (-(var4-currentObject.posZ))*0.16;
                                            } else {
                                                currentObject.posXmomentum = (-(var3-currentObject.posX))*0.11;
                                                currentObject.posZmomentum = (-(var4-currentObject.posZ))*0.11;
                                            }
                                        }
                                    } else if ((currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset) >= (otherObject.posY-(otherObject.standardHeight/2)+otherObject.collisionyoffset)+gravityBuffer1 && currentObject.posY <= otherObject.posY) { //collision
                                        if (currentObject.objectgrabbed == 0) {
                                            if (currentObject.objectheavy == 0) {
                                                currentObject.posXmomentum = (-(var3-currentObject.posX))*0.16;
                                                currentObject.posZmomentum = (-(var4-currentObject.posZ))*0.16;
                                            } else {
                                                currentObject.posXmomentum = (-(var3-currentObject.posX))*0.11;
                                                currentObject.posZmomentum = (-(var4-currentObject.posZ))*0.11;
                                            }
                                        }
                                    } else if (currentObject.posY > otherObject.posY && otherObject.objectgrabbed == 0) {
                                        currentObject.refreshminypos = 1;
                                    }
                                }
                            }
                            
                            //object over liquid base
                            if (otherObject.liquidBase == 1 && currentObject.canbePickedUp == 0) {
                                if (currentObject.posY+(currentObject.posYmomentum-gravityBuffer1) <= currentObject.minyposition+4.0 && currentObject.objectgrabbed == 0 && currentObject.objectusesgravity != 0) {
                                    //gets sin&cos (angle) to otherObject
                                    float var1 = asinf((otherObject.posZ-currentObject.posZ)/(sqrtf(powf(otherObject.posX-currentObject.posX, 2) + powf((otherObject.posZ-currentObject.posZ), 2)))); //negative = down, positive = up
                                    float var2 = asinf((otherObject.posX-currentObject.posX)/(sqrtf(powf(otherObject.posX-currentObject.posX, 2) + powf((otherObject.posZ-currentObject.posZ), 2)))); //negative = left, positive = right
                                    float var3 = 0;
                                    float var4 = 0;
                                    //sets closest point to other object
                                    if (var2 >= 0) {
                                        var3 = (cosf(var1)*currentObject.objecttoobjectradius)+currentObject.posX;
                                        var4 = (sinf(var1)*currentObject.objecttoobjectradius)+currentObject.posZ;
                                    } else if (var2 < 0) {
                                        var3 = -(cosf(var1)*currentObject.objecttoobjectradius)+currentObject.posX;
                                        var4 = (sinf(var1)*currentObject.objecttoobjectradius)+currentObject.posZ;
                                    }
                                    
                                    //gets sin&cos (angle) to currentObject
                                    float var5 = asinf((currentObject.posZ-otherObject.posZ)/(sqrtf(powf(currentObject.posX-otherObject.posX, 2) + powf((currentObject.posZ-otherObject.posZ), 2)))); //negative = down, positive = up
                                    float var6 = asinf((currentObject.posX-otherObject.posX)/(sqrtf(powf(currentObject.posX-otherObject.posX, 2) + powf((currentObject.posZ-otherObject.posZ), 2)))); //negative = left, positive = right
                                    float var7;
                                    float var8;
                                    //sets closest point to current object
                                    if (var6 >= 0) {
                                        var7 = (cosf(var5)*otherObject.objecttoobjectradius)+otherObject.posX;
                                        var8 = (sinf(var5)*otherObject.objecttoobjectradius)+otherObject.posZ;
                                    } else if (var6 < 0) {
                                        var7 = -(cosf(var5)*otherObject.objecttoobjectradius)+otherObject.posX;
                                        var8 = (sinf(var5)*otherObject.objecttoobjectradius)+otherObject.posZ;
                                    }
                                    
                                    //tests for overlapping radii
                                    bool radiioverlapping = 0;
                                    if (currentObject.posX <= var3 && currentObject.posZ <= var4 && var3 >= var7 && var4 >= var8) { //Q1
                                        if (otherObject.posX > var7 && otherObject.posZ > var8) { //Q3, matches Q1
                                            radiioverlapping = 1;
                                        }
                                    } else if (currentObject.posX > var3 && currentObject.posZ <= var4 && var3 <= var7 && var4 >= var8) { //Q2
                                        if (otherObject.posX <= var7 && otherObject.posZ > var8) { //Q4, matches Q2
                                            radiioverlapping = 1;
                                        }
                                    } else if (currentObject.posX <= var3 && currentObject.posZ > var4 && var3 >= var7 && var4 <= var8) { //Q4
                                        if (otherObject.posX > var7 && otherObject.posZ <= var8) { //Q2, matches Q4
                                            radiioverlapping = 1;
                                        }
                                    } else if (currentObject.posX > var3 && currentObject.posZ > var4 && var3 <= var7 && var4 <= var8) { //Q3
                                        if (otherObject.posX <= var7 && otherObject.posZ <= var8) { //Q1, matches Q3
                                            radiioverlapping = 1;
                                        }
                                    }
                                    
                                    //post-radii overlap
                                    if (radiioverlapping == 1) {
                                        if ((currentObject.posY-(currentObject.standardHeight/2)+currentObject.collisionyoffset) >= otherObject.posY-1+currentObject.posYmomentum && (currentObject.posY-(currentObject.standardHeight/2)+currentObject.collisionyoffset) <= otherObject.posY+1-currentObject.posYmomentum) {
                                            currentObject.overLiquidBase = 1;
                                            if (currentObject.overLiquidViscosity > otherObject.liquidViscosity) {
                                                currentObject.overLiquidViscosity = otherObject.liquidViscosity;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    //over liquid base animations
                    if (currentObject.objectusesgravity != 0 && currentObject.objectusescollisions == 1) {
                        if (currentObject.overLiquidBase == 0) {
                            if (currentObject.visible == YES && currentObject.opacity > 0) {
                                currentObject.oLBfuncYoffset = currentObject.oLBfuncYoffset + ((0 - currentObject.oLBfuncYoffset)/12.0);
                                currentObject.oLBfuncX = 2.8*(3.1415926535897932*2.0);
                            } else {
                                currentObject.oLBfuncYoffset = 0;
                                currentObject.oLBfuncX = 0;
                            }
                        } else {
                            if (currentObject.objectheavy == 0) {
                                currentObject.oLBfuncX = currentObject.oLBfuncX + (0.6 + (currentObject.overLiquidViscosity*0.15));
                            } else {
                                currentObject.oLBfuncX = currentObject.oLBfuncX + (0.45 + (currentObject.overLiquidViscosity*0.15));
                            }
                            float calcVarUno = sinf((float)currentObject.oLBfuncX/(3.1415926535897932*2.0));
                            if (currentObject.objectheavy == 0) {
                                currentObject.oLBfuncYoffset = currentObject.oLBfuncYoffset + (((-3.5+(calcVarUno*3.5*((currentObject.overLiquidViscosity+0.3)/1.3))) - currentObject.oLBfuncYoffset)/13.0);
                            } else {
                                currentObject.oLBfuncYoffset = currentObject.oLBfuncYoffset + (((-5.5+(calcVarUno*3.0*((currentObject.overLiquidViscosity+0.3)/1.3))) - currentObject.oLBfuncYoffset)/13.0);
                            }
                            
                            if (currentObject.oLBfuncX > 32*(3.1415926535897932*2.0)) {
                                currentObject.oLBfuncX = 0;
                            }
                        }
                    }
                    
                    //player collisions
                    if (playerCollisionsEnabled == 1 && currentObject.objectgrabbed == 0) {
                        if (currentObject.hypotenusetoplayer < (currentObject.objecttoplayerradius*0.75) && currentObject.hypotenusetoplayer > -(currentObject.objecttoplayerradius*0.75) && positionY-playerHeight+30 >= (currentObject.posY-(currentObject.standardHeight/2)+currentObject.collisionyoffset) && positionY-playerHeight <= (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset) && currentObject.isahillgradientobject == 0) {
                            
                            if (currentObject.canbePickedUp == 0) {
                                //x&z momentum
                                //gets sin&cos (angle) to otherObject
                                float var1 = asinf((positionZ-currentObject.posZ)/(sqrtf(powf(positionX-currentObject.posX, 2) + powf((positionZ-currentObject.posZ), 2)))); //negative = down, positive = up
                                float var2 = asinf((positionX-currentObject.posX)/(sqrtf(powf(positionX-currentObject.posX, 2) + powf((positionZ-currentObject.posZ), 2)))); //negative = left, positive = right
                                float var3 = 0;
                                float var4 = 0;
                                //sets closest point to other object
                                if (var2 >= 0) {
                                    var3 = (cosf(var1)*(currentObject.objecttoplayerradius*0.75));
                                    var4 = (sinf(var1)*(currentObject.objecttoplayerradius*0.75));
                                } else if (var2 < 0) {
                                    var3 = -(cosf(var1)*(currentObject.objecttoplayerradius*0.75));
                                    var4 = (sinf(var1)*(currentObject.objecttoplayerradius*0.75));
                                }
                                
                                //momentum set
                                //currentObject.posXmomentum = -(currentObject.posX+var3-positionX)*1.6;
                                //currentObject.posZmomentum = -(currentObject.posZ+var4-positionZ)*1.6;
                                
                                //position reset
                                if (currentObject.objectheavy == 0) {
                                    currentObject.posX = -var3+positionX;
                                    currentObject.posZ = -var4+positionZ;
                                } else {
                                    currentObject.posX = -var3+positionX;
                                    currentObject.posZ = -var4+positionZ;
                                    momentumX2 = var3*0.035;
                                    momentumZ2 = var4*0.035;
                                }
                            } else if (currentObject.hasbeenPickedUp == 0) {
                                currentObject.hasbeenPickedUp = 1;
                            }
                        }
                    }
                    
                    //y momentum & gravity
                    if (levelTypeHWL2 != 2) {
                        if (currentObject.posY+(currentObject.posYmomentum-gravityBuffer1) > currentObject.minyposition && currentObject.objectgrabbed == 0 && currentObject.objectusesgravity == 1) {
                            if (levelTypeHWL2 == 1) {
                                currentObject.posYmomentum = currentObject.posYmomentum-(0.19*0.4);
                            } else {
                                currentObject.posYmomentum = currentObject.posYmomentum-0.19;
                            }
                        } else if (currentObject.posY+(currentObject.posYmomentum-gravityBuffer1) <= currentObject.minyposition && currentObject.objectgrabbed == 0 && currentObject.posYmomentum != 0 && currentObject.objectusesgravity == 1) {
                            //printf("momentumy: %f, %i, %i\n",currentObject.posYmomentum,currentObject.overLiquidBase,currentObject.overAnotherFloatingObject);
                            currentObject.posY = currentObject.minyposition;
                            if (currentObject.posYmomentum < -gravityBuffer1) { //y bounce threshold
                                if (currentObject.overLiquidBase != 0 || currentObject.overAnotherFloatingObject != 0) {
                                    currentObject.posYmomentum = 0;
                                } else {
                                    if (levelTypeHWL2 == 1) {
                                        currentObject.posYmomentum = -currentObject.posYmomentum*0.28;
                                    } else {
                                        currentObject.posYmomentum = -currentObject.posYmomentum*0.34;
                                    }
                                    
                                    //generic proximity-based landing sound
                                    if (currentObject.hypotenusetoplayer <= 140 && vrPrimaryInstance == 1) {
                                        //printf("%f\n",currentObject.posYmomentum);
                                        if (currentObject.posYmomentum >= 1.5) {
                                            [[OALSimpleAudio sharedInstance] playEffect:@"thud3_loud.wav"];
                                        } else if (currentObject.posYmomentum < 1.5 && currentObject.posYmomentum > 0.4) {
                                            [[OALSimpleAudio sharedInstance] playEffect:@"thud3_soft.wav"];
                                        }
                                    } else if (currentObject.hypotenusetoplayer <= 250) {
                                        if (currentObject.posYmomentum >= 1.5) {
                                            [[OALSimpleAudio sharedInstance] playEffect:@"thud3_soft.wav"];
                                        }
                                    }
                                }
                            } else { //eliminates bounce to avoid phasing through other objects
                                currentObject.posYmomentum = 0;
                            }
                            //printf(" - %f\n",currentObject.posYmomentum);
                        } else if (currentObject.posY+gravityBuffer1 < currentObject.minyposition && currentObject.objectgrabbed == 0) {
                            currentObject.posY = currentObject.minyposition;
                            if (currentObject.overLiquidBase == 0) {
                                if (levelTypeHWL2 == 1) {
                                    currentObject.posYmomentum = 2.7*0.35;
                                } else {
                                    currentObject.posYmomentum = 2.7;
                                }
                            } else {
                                currentObject.posYmomentum = 4.8;
                            }
                        }
                        
                        //x momentum
                        if (currentObject.posXmomentum != 0) {
                            if (currentObject.posY <= currentObject.minyposition) {
                                if (currentObject.overLiquidBase == 0) {
                                    currentObject.posXmomentum = currentObject.posXmomentum * 0.86;
                                } else {
                                    currentObject.posXmomentum = currentObject.posXmomentum * (0.89+(0.085*currentObject.overLiquidViscosity));
                                }
                            } else {
                                currentObject.posXmomentum = currentObject.posXmomentum * 0.98;
                            }
                        }
                        //z momentum
                        if (currentObject.posZmomentum != 0) {
                            if (currentObject.posY <= currentObject.minyposition) {
                                if (currentObject.overLiquidBase == 0) {
                                    currentObject.posZmomentum = currentObject.posZmomentum * 0.86;
                                } else {
                                    currentObject.posZmomentum = currentObject.posZmomentum * (0.89+(0.085*currentObject.overLiquidViscosity));
                                }
                            } else {
                                currentObject.posZmomentum = currentObject.posZmomentum * 0.98;
                            }
                        }
                    }
                    
                    //applies momentum
                    if (currentObject.posYmomentum != 0) {
                        currentObject.posY = currentObject.posY + currentObject.posYmomentum;
                    }
                    if (currentObject.posXmomentum != 0) {
                        currentObject.posX = currentObject.posX + currentObject.posXmomentum;
                    }
                    if (currentObject.posZmomentum != 0) {
                        currentObject.posZ = currentObject.posZ + currentObject.posZmomentum;
                    }
                } else if (currentObject.objectusescollisions == 2 && currentObject.isasubobject == 0) { //obtrusive collisions
                    
                    //player collisions
                    if (playerCollisionsEnabled == 1) {
                        if (currentObject.hypotenusetoplayer < (currentObject.objecttoplayerradius*0.8) && currentObject.hypotenusetoplayer > -(currentObject.objecttoplayerradius*0.8) && positionY-playerHeight+30 >= (currentObject.posY-(currentObject.standardHeight/2)+currentObject.collisionyoffset) && positionY-playerHeight <= (currentObject.posY+(currentObject.standardHeight/2)+currentObject.collisionyoffset) && currentObject.isahillgradientobject == 0) {
                            
                            if (currentObject.objectid != 7) {
                                if (currentObject.canbePickedUp == 0) {
                                    //x&z momentum
                                    //gets sin&cos (angle) to otherObject
                                    float var1 = asinf((positionZ-currentObject.posZ)/(sqrtf(powf(positionX-currentObject.posX, 2) + powf((positionZ-currentObject.posZ), 2)))); //negative = down, positive = up
                                    float var2 = asinf((positionX-currentObject.posX)/(sqrtf(powf(positionX-currentObject.posX, 2) + powf((positionZ-currentObject.posZ), 2)))); //negative = left, positive = right
                                    float var3 = 0;
                                    float var4 = 0;
                                    //sets closest point to other object
                                    if (var2 >= 0) {
                                        var3 = (cosf(var1)*(currentObject.objecttoplayerradius*0.8));
                                        var4 = (sinf(var1)*(currentObject.objecttoplayerradius*0.8));
                                    } else if (var2 < 0) {
                                        var3 = -(cosf(var1)*(currentObject.objecttoplayerradius*0.8));
                                        var4 = (sinf(var1)*(currentObject.objecttoplayerradius*0.8));
                                    }
                                    positionX = var3+currentObject.posX;
                                    positionZ = var4+currentObject.posZ;
                                } else if (currentObject.hasbeenPickedUp == 0) {
                                    currentObject.hasbeenPickedUp = 1;
                                }
                            } else { //collecting colorup
                                if (collectingColorup == 0 && collectingColorupTrans > 0.9 && colorupFadeExists == 0) {
                                    collectingColorup = 1;
                                    colorupHypo = 43.0;
                                }
                            }
                        }
                        
                        //x momentum
                        if (currentObject.posXmomentum != 0 && levelTypeHWL2 != 2) {
                            currentObject.posXmomentum = currentObject.posXmomentum * 0.97;
                            currentObject.posX = currentObject.posX + currentObject.posXmomentum;
                        }
                        //y momentum
                        if (currentObject.posYmomentum != 0 && levelTypeHWL2 != 2) {
                            currentObject.posYmomentum = currentObject.posYmomentum * 0.97;
                            currentObject.posY = currentObject.posY + currentObject.posYmomentum;
                        }
                        //z momentum
                        if (currentObject.posZmomentum != 0 && levelTypeHWL2 != 2) {
                            currentObject.posZmomentum = currentObject.posZmomentum * 0.97;
                            currentObject.posZ = currentObject.posZ + currentObject.posZmomentum;
                        }
                    }
                }
            } else { //applies momentum for picked up objects
                if (currentObject.posYmomentum != 0) {
                    currentObject.posY = currentObject.posY + currentObject.posYmomentum;
                }
                if (currentObject.posXmomentum != 0) {
                    currentObject.posX = currentObject.posX + currentObject.posXmomentum;
                }
                if (currentObject.posZmomentum != 0) {
                    currentObject.posZ = currentObject.posZ + currentObject.posZmomentum;
                }
            }
            
            //collisions with static objects (rubber-banding)
            if (currentObject.objectusescollisions == 1 && currentObject.objectgrabbed != 0) { //collisions
                currentObject.minyposition = currentObject.mininitialyposition;
                for (int count1 = 1; count1 <= [objectsIDsOLD count]; count1++) {
                    int IDcheck = (int)[[objectsIDsOLD objectAtIndex:count1-1] intValue];
                    
                    if (IDcheck != currentObject.uniqueobjectid) {
                        float posXCheck = [[objectsPosXOLD objectAtIndex:count1-1] floatValue];
                        float posYCheck = [[objectsPosYOLD objectAtIndex:count1-1] floatValue];
                        float posZCheck = [[objectsPosZOLD objectAtIndex:count1-1] floatValue];
                        float heightCheck = [[objectsHeightsOLD objectAtIndex:count1-1] floatValue];
                        float heightOffsetCheck = [[objectsHeightOffsetOLD objectAtIndex:count1-1] floatValue];
                        float radiusCheck = [[objectsRadiusOLD objectAtIndex:count1-1] floatValue];
                        int collisionTypeCheck = (int)[[objectsCollisionTypeOLD objectAtIndex:count1-1] intValue];
                        
                        float hypo = sqrtf(powf(currentObject.posX-posXCheck,2.0)+powf(currentObject.posZ-posZCheck,2.0));
                        
                        if (hypo <= radiusCheck+currentObject.objecttoobjectradius) { //radius overlap
                            if (currentObject.posY-(currentObject.standardHeight/2.0)+currentObject.collisionyoffset < posYCheck+(heightCheck/2.0)+heightOffsetCheck && currentObject.posY+(currentObject.standardHeight/2.0)+currentObject.collisionyoffset >= posYCheck-(heightCheck/2.0)+heightOffsetCheck) { //head-on collisions
                                
                                //x&z momentum
                                //gets sin&cos (angle) to otherObject
                                float var1 = asinf((posZCheck-currentObject.posZ)/(sqrtf(powf(posXCheck-currentObject.posX, 2) + powf((posZCheck-currentObject.posZ), 2)))); //negative = down, positive = up
                                float var2 = asinf((posXCheck-currentObject.posX)/(sqrtf(powf(posXCheck-currentObject.posX, 2) + powf((posZCheck-currentObject.posZ), 2)))); //negative = left, positive = right
                                float var3 = 0;
                                float var4 = 0;
                                //sets closest point to other object
                                if (var2 >= 0) {
                                    var3 = (cosf(var1)*(radiusCheck+currentObject.objecttoobjectradius));
                                    var4 = (sinf(var1)*(radiusCheck+currentObject.objecttoobjectradius));
                                } else if (var2 < 0) {
                                    var3 = -(cosf(var1)*(radiusCheck+currentObject.objecttoobjectradius));
                                    var4 = (sinf(var1)*(radiusCheck+currentObject.objecttoobjectradius));
                                }
                                if (currentObject.objectgrabbed != 0 && collisionTypeCheck == 1) {
                                    //NOTHING, other object bounces off
                                } else { //current object bounces off
                                    float hypoMomentum = sqrtf(powf(currentObject.posXmomentum,2.0)+powf(currentObject.posZmomentum,2.0));
                                    
                                    if (hypoMomentum >= fabsf(currentObject.posYmomentum)) { //predominantly horizontal collision
                                        currentObject.posX = posXCheck-var3;
                                        currentObject.posZ = posZCheck-var4;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            //audio objects
            if (currentObject.isanaudioobject != 0) {
                if (currentObject.isanaudioobject == 1) { //play once
                    if (currentObject.hypotenusetoplayer < currentObject.audiorange && currentObject.hypotenusetoplayer > -currentObject.audiorange) {
                        if (currentObject.audiolengthcount == 0) {
                            currentObject.audiolengthcount = 1;
                            currentObject.audioPLAY = 1;
                        }
                    } else if (currentObject.audiolengthcount == 1) {
                        currentObject.audiolengthcount = 0;
                    }
                } else if (currentObject.isanaudioobject == 2) { //repeat audio
                    if (currentObject.hypotenusetoplayer < currentObject.audiorange && currentObject.hypotenusetoplayer > -currentObject.audiorange) {
                        currentObject.audiolengthcount--;
                        if (currentObject.audiolengthcount <= 0) {
                            currentObject.audiolengthcount = currentObject.audiolength;
                            currentObject.audioPLAY = 1;
                        }
                    } else if (currentObject.audiolengthcount == 1) {
                        currentObject.audiolengthcount = 0;
                    }
                }
                
                //actual sounds
                if (currentObject.audioPLAY == 1) {
                    if (positionY < currentObject.posY + 80 && positionY > currentObject.posY - 80 && vrPrimaryInstance == 1) { //height requirements
                        if (currentObject.audioid == 1) {
                            if (currentObject.isanaudioobject == 1) {
                                [[OALSimpleAudio sharedInstance] playEffect:@"brush.wav"];
                            } else if (currentObject.isanaudioobject == 2) {
                                [[OALSimpleAudio sharedInstance] playEffect:@"brush.wav" volume:((float)(currentObject.audiorange-currentObject.hypotenusetoplayer)/(float)currentObject.audiorange) pitch:1.0 pan:0.0 loop:0];
                            }
                        }
                    }
                    currentObject.audioPLAY = 0;
                }
            }
            
            //applies border restrictions
            if (bordersEnabled != 0 && currentObject.objectusescollisions == 1) {
                if (currentObject.posX < -borderX) {
                    if (currentObject.posXmomentum < 0) {
                        currentObject.posXmomentum = -currentObject.posXmomentum*0.8;
                    }
                    currentObject.posX = -borderX;
                } else if (currentObject.posX > borderX) {
                    if (currentObject.posXmomentum > 0) {
                        currentObject.posXmomentum = -currentObject.posXmomentum*0.8;
                    }
                    currentObject.posX = borderX;
                }
                if (currentObject.posZ < -borderZ) {
                    if (currentObject.posZmomentum < 0) {
                        currentObject.posZmomentum = -currentObject.posZmomentum*0.8;
                    }
                    currentObject.posZ = -borderZ;
                } else if (currentObject.posZ > borderZ) {
                    if (currentObject.posZmomentum > 0) {
                        currentObject.posZmomentum = -currentObject.posZmomentum*0.8;
                    }
                    currentObject.posZ = borderZ;
                }
            }
            if (borderRadius != 0 && currentObject.objectusescollisions == 1 && levelTypeHWL2 != 2) {
                float hypo = sqrtf(powf(currentObject.posX,2.0)+powf(currentObject.posZ,2.0));
                if (hypo >= borderRadius) {
                    float angle = acosf(currentObject.posX/hypo);
                    currentObject.posX = cosf(angle)*borderRadius;
                    if (currentObject.posZ >= 0) {
                        currentObject.posZ = sinf(angle)*borderRadius;
                    } else {
                        currentObject.posZ = -sinf(angle)*borderRadius;
                    }
                    
                    /*float momhypo = sqrtf(powf(currentObject.posXmomentum,2.0)+powf(currentObject.posZmomentum,2.0));
                    float momangle = acosf(currentObject.posX/momhypo);*/ //dev
                }
            }
            
            //tracking object collisions
            if (currentObject.objectusescollisions == 2) {
                [objectsIDs addObject:[NSNumber numberWithInt:currentObject.uniqueobjectid]];
                [objectsPosX addObject:[NSNumber numberWithFloat:currentObject.posX+currentObject.posXmomentum]];
                [objectsPosY addObject:[NSNumber numberWithFloat:currentObject.posY+currentObject.posYmomentum]];
                [objectsPosZ addObject:[NSNumber numberWithFloat:currentObject.posZ+currentObject.posZmomentum]];
                [objectsHeights addObject:[NSNumber numberWithFloat:currentObject.standardHeight]];
                [objectsHeightOffset addObject:[NSNumber numberWithFloat:currentObject.collisionyoffset]];
                [objectsRadius addObject:[NSNumber numberWithFloat:currentObject.objecttoobjectradius]];
                [objectsCollisionType addObject:[NSNumber numberWithInt:currentObject.objectusescollisions]];
                [objectsGrabbed addObject:[NSNumber numberWithInt:currentObject.objectgrabbed]];
            }
            
            //draw floor objects
            if (currentObject.isafloorobject == 2 && currentObject.polygonRadius > 0 && currentObject.polygonSides > 2) {
                if (nearEnoughToShow == 1) {
                    //calculate 4 surrounding points
                    float finalPointX = 0;
                    float finalPointY = 0;
                    float prePointX = currentObject.posX;
                    float prePointY = currentObject.posY+currentObject.oLBfuncYoffset;
                    float prePointZ = currentObject.posZ;
                    float prePointX2 = 0;
                    float prePointZ2 = 0;
                    NSMutableArray *pointsArrayX = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayY = [[NSMutableArray alloc]init ];
                    //safety for horizontal polygons
                    float maxDiffY = 0;
                    float refY = 0;
                    float maxDiffX = 0;
                    float refX = 0;
                    for (int int1 = 1; int1 <= currentObject.polygonSides; int1++) {
                        float var2 = ((((float)int1-1.0)/currentObject.polygonSides)*(2*3.1415926535897932));
                        //applies vars to new position
                        float randomOffsetY = 0;
                        prePointX = (cosf(var2)*currentObject.polygonRadius)+currentObject.posX;
                        prePointY = currentObject.posY+currentObject.oLBfuncYoffset+randomOffsetY;
                        prePointZ = (sinf(var2)*currentObject.polygonRadius)+currentObject.posZ;
                        
                        float negativo = 0;
                        float calcZ = atan((prePointX - (positionX+VRoffsetX))/(prePointZ - (positionZ+VRoffsetZ))) + (CC_DEGREES_TO_RADIANS((rotationX+(gyroYawOffset/16.5)))*16.5)+currentObject.rotationoffsetx2;
                        float calcZ_3 = 0;
                        if ((prePointZ - (positionZ+VRoffsetZ)) >= 0) {
                            calcZ_3 = sqrtf(powf((prePointX - (positionX+VRoffsetX)), 2) + powf((prePointZ - (positionZ+VRoffsetZ)), 2));
                        } else {
                            calcZ_3 = -(sqrtf(powf((prePointX - (positionX+VRoffsetX)), 2) + powf((prePointZ - (positionZ+VRoffsetZ)), 2)));
                        }
                        prePointZ2 = (cosf(calcZ) * calcZ_3)+(positionZ+VRoffsetZ);
                        prePointX2 = (sinf(calcZ) * calcZ_3)+(positionX+VRoffsetX);
                        
                        if (prePointZ2-(positionZ+VRoffsetZ) <= 0) {
                            negativo = 1;
                        }
                        
                        float calcY = 0;
                        float calcX = 0;
                        
                        if ((prePointZ - (positionZ+VRoffsetZ)) == 0) {
                            calcX = 0;
                            calcY = 0;
                        } else {
                            if (negativo == 0) {
                                calcX = (((prePointX2 - (positionX+VRoffsetX))) * (100/(prePointZ2 - (positionZ+VRoffsetZ))));
                                calcY = (((prePointY - (positionYactual+VRoffsetY))) * (100/(prePointZ2 - (positionZ+VRoffsetZ))));
                            } else {
                                calcX = 100*(((prePointX2 - (positionX+VRoffsetX))));
                                calcY = 100*(((prePointY - (positionYactual+VRoffsetY))));
                                //printf("%.2f\n",(prePointZ2 - (positionZ+VRoffsetZ)));
                                //calcX = (((prePointX2 - positionX)) * (100/(prePointZ2 - (positionZ+VRoffsetZ))));
                                //calcY = (((prePointY - positionYactual)) * (100/(prePointZ2 - (positionZ+VRoffsetZ))));
                            }
                        }
                        
                        //tracks y span of polygon
                        if (refY == 0) {
                            refY = calcY;
                        } else {
                            if (fabsf(calcY-refY) > maxDiffY) {
                                maxDiffY = fabsf(calcY-refY);
                            }
                        }
                        
                        //tracks x span of polygon
                        if (refX == 0) {
                            refX = calcX;
                        } else {
                            if (fabsf(calcX-refX) > maxDiffX) {
                                maxDiffX = fabsf(calcX-refX);
                            }
                        }
                        
                        float preFinalPointX1 = (calcX*FOVvalue);
                        float preFinalPointY1 = (calcY*FOVvalue);
                        float FOVvar1 = 0;
                        float FOVvar2 = 0;
                        if (preFinalPointY1 != 0) {
                            if (preFinalPointX1 != 0) {
                                FOVvar1 = atan(preFinalPointX1/preFinalPointY1) + (FOVrotationrad);
                            } else {
                                FOVvar1 = FOVrotationrad;
                            }
                        } else {
                            if (preFinalPointX1 != 0) {
                                FOVvar1 = -(atan(preFinalPointX1/preFinalPointY1)) + (FOVrotationrad);
                            } else {
                                FOVvar1 = FOVrotationrad;
                            }
                        }
                        if (preFinalPointY1 > 0) {
                            FOVvar2 = sqrtf(powf(preFinalPointX1, 2) + powf(preFinalPointY1, 2));
                        } else {
                            FOVvar2 = -(sqrtf(powf(preFinalPointX1, 2) + powf(preFinalPointY1, 2)));
                        }
                        
                        finalPointX = ((sinf(FOVvar1) * FOVvar2) + (winSize.width/2));
                        finalPointY = ((cosf(FOVvar1) * FOVvar2) + (winSize.height/2) + vrGlobalYOffset + ((rotationY+((90.0+(float)gyroRollOffset)*0.08))*45.0));
                        
                        [pointsArrayX addObject:[NSNumber numberWithFloat:finalPointX]];
                        [pointsArrayY addObject:[NSNumber numberWithFloat:finalPointY]];
                    }
                    
                    /*drawLayer * dwLayer = (drawLayer *)[self.parent getChildByTag:02];
                     [dwLayer drawPoly:pointsArrayX :pointsArrayY :currentObject.polygonColorRed :currentObject.polygonColorGreen :currentObject.polygonColorBlue :currentObject.polygonShade];*/
                    
                    if (maxDiffY > 0.0) { //if y span of polygon is higher than a certain range
                        polygon *poly1 = nil;
                        poly1 = [rect1 polygonsquare];
                        poly1.polygonzorder = (int)currentObject.zOrder;
                        poly1.polycolorBlue = currentObject.polygonColorBlue*currentObject.polygonShade;
                        poly1.polycolorGreen = currentObject.polygonColorGreen*currentObject.polygonShade;
                        poly1.polycolorRed = currentObject.polygonColorRed*currentObject.polygonShade;
                        if (levelTypeHWL2 == 1) {
                            poly1.polycolorBlue = ((currentObject.polygonColorBlue-190.0)*currentObject.polygonShade)+190.0;
                            poly1.polycolorGreen = ((currentObject.polygonColorGreen-50.0)*currentObject.polygonShade)+50.0;
                            poly1.polycolorRed = ((currentObject.polygonColorRed-17.0)*currentObject.polygonShade)+17.0;
                        }
                        poly1.polycolorAlpha = currentObject.polygonColorAlpha;
                        poly1.pointsOfPolygonX = [[NSMutableArray alloc] initWithArray:pointsArrayX];
                        poly1.pointsOfPolygonY = [[NSMutableArray alloc] initWithArray:pointsArrayY];
                        poly1.polygonBorderWidth = 0;
                        [self addChild:poly1];
                        [polygonArray addObject:poly1];
                    } else { //draws line spanning X coordinates to compensate
                        polygon *poly1 = nil;
                        poly1 = [line1 polygonline];
                        poly1.polygonzorder = (int)currentObject.zOrder;
                        poly1.polycolorBlue = currentObject.polygonColorBlue*currentObject.polygonShade;
                        poly1.polycolorGreen = currentObject.polygonColorGreen*currentObject.polygonShade;
                        poly1.polycolorRed = currentObject.polygonColorRed*currentObject.polygonShade;
                        if (levelTypeHWL2 == 1) {
                            poly1.polycolorBlue = ((currentObject.polygonColorBlue-190.0)*currentObject.polygonShade)+190.0;
                            poly1.polycolorGreen = ((currentObject.polygonColorGreen-50.0)*currentObject.polygonShade)+50.0;
                            poly1.polycolorRed = ((currentObject.polygonColorRed-17.0)*currentObject.polygonShade)+17.0;
                        }
                        poly1.polycolorAlpha = currentObject.polygonColorAlpha;
                        poly1.polygonBorderWidth = 0;
                        
                        NSMutableArray *pointsArrayX2 = [[NSMutableArray alloc]init ];
                        NSMutableArray *pointsArrayY2 = [[NSMutableArray alloc]init ];
                        float xvalSum = 0;
                        for (int int1 = 1; int1 <= [pointsArrayX count]; int1++) {
                            xvalSum = xvalSum + [[pointsArrayX objectAtIndex:int1-1] floatValue];
                        }
                        float yvalSum = 0;
                        for (int int1 = 1; int1 <= [pointsArrayY count]; int1++) {
                            yvalSum = yvalSum + [[pointsArrayY objectAtIndex:int1-1] floatValue];
                        }
                        float xmax = -999999;
                        float xmin = 999999;
                        for (int int1 = 1; int1 <= [pointsArrayX count]; int1++) {
                            if ([[pointsArrayX objectAtIndex:int1-1] floatValue] < xmin) {
                                xmin = [[pointsArrayX objectAtIndex:int1-1] floatValue];
                            }
                            if ([[pointsArrayX objectAtIndex:int1-1] floatValue] > xmax) {
                                xmax = [[pointsArrayX objectAtIndex:int1-1] floatValue];
                            }
                        }
                        float length = fabsf(xmin-xmax)*0.52;
                        [pointsArrayX2 addObject:[NSNumber numberWithFloat:(xvalSum/((float)[pointsArrayX count]))-(cosf(FOVrotationrad)*length)]];
                        [pointsArrayX2 addObject:[NSNumber numberWithFloat:(xvalSum/((float)[pointsArrayX count]))+(cosf(FOVrotationrad)*length)]];
                        [pointsArrayY2 addObject:[NSNumber numberWithFloat:(yvalSum/((float)[pointsArrayY count]))+(sinf(FOVrotationrad)*length)]];
                        [pointsArrayY2 addObject:[NSNumber numberWithFloat:(yvalSum/((float)[pointsArrayY count]))-(sinf(FOVrotationrad)*length)]];
                        
                        poly1.pointsOfPolygonX = [[NSMutableArray alloc] initWithArray:pointsArrayX2];
                        poly1.pointsOfPolygonY = [[NSMutableArray alloc] initWithArray:pointsArrayY2];
                        [self addChild:poly1];
                        [polygonArray addObject:poly1];
                        
                        pointsArrayX2 = nil;
                        pointsArrayY2 = nil;
                    }
                    
                    pointsArrayX = nil;
                    pointsArrayY = nil;
                }
            } else if (currentObject.isafloorobject == 3 && currentObject.polygonRadius > 0 && currentObject.polygonSides > 2) {
                if (facingObject == 1) {
                    //calculate 4 surrounding points
                    float finalPointX = 0;
                    float finalPointY = 0;
                    float prePointX = currentObject.posX;
                    float prePointY = currentObject.posY+currentObject.oLBfuncYoffset;
                    float prePointZ = currentObject.posZ;
                    float prePointX2 = 0;
                    float prePointZ2 = 0;
                    NSMutableArray *pointsArrayX = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayY = [[NSMutableArray alloc]init ];
                    //safety for vertical polygons
                    float maxDiffX = 0;
                    float refX = 0;
                    for (int int1 = 1; int1 <= currentObject.polygonSides; int1++) { //number of sides must correspond with positions below
                        if (currentObject.objectid == 9) {
                            float xCoeff = 0.82;
                            float denom = 40.0;
                            if (int1 == 1) {
                                prePointX = currentObject.posX-((currentObject.polygonRadius*xCoeff)*sinf((((float)currentObject.objecttag/denom)*(2*3.1415926535897932))));
                                prePointY = currentObject.posY+currentObject.polygonRadius;
                                prePointZ = currentObject.posZ+((currentObject.polygonRadius*xCoeff)*cosf((((float)currentObject.objecttag/denom)*(2*3.1415926535897932))));
                            } else if (int1 == 2) {
                                prePointX = currentObject.posX+((currentObject.polygonRadius*xCoeff)*sinf((((float)currentObject.objecttag/denom)*(2*3.1415926535897932))));
                                prePointY = currentObject.posY+currentObject.polygonRadius;
                                prePointZ = currentObject.posZ-((currentObject.polygonRadius*xCoeff)*cosf((((float)currentObject.objecttag/denom)*(2*3.1415926535897932))));
                            } else if (int1 == 3) {
                                prePointX = currentObject.posX+((currentObject.polygonRadius*xCoeff)*sinf((((float)currentObject.objecttag/denom)*(2*3.1415926535897932))));
                                prePointY = currentObject.posY-currentObject.polygonRadius;
                                prePointZ = currentObject.posZ-((currentObject.polygonRadius*xCoeff)*cosf((((float)currentObject.objecttag/denom)*(2*3.1415926535897932))));
                            } else if (int1 == 4) {
                                prePointX = currentObject.posX-((currentObject.polygonRadius*xCoeff)*sinf((((float)currentObject.objecttag/denom)*(2*3.1415926535897932))));
                                prePointY = currentObject.posY-currentObject.polygonRadius;
                                prePointZ = currentObject.posZ+((currentObject.polygonRadius*xCoeff)*cosf((((float)currentObject.objecttag/denom)*(2*3.1415926535897932))));
                            }
                            //prePointX = currentObject.posX;
                        }
                        
                        float negativo = 0;
                        float calcZ = atan((prePointX - (positionX+VRoffsetX))/(prePointZ - (positionZ+VRoffsetZ))) + (CC_DEGREES_TO_RADIANS((rotationX+(gyroYawOffset/16.5)))*16.5)+currentObject.rotationoffsetx2;
                        float calcZ_3 = 0;
                        if ((prePointZ - (positionZ+VRoffsetZ)) >= 0) {
                            calcZ_3 = sqrtf(powf((prePointX - (positionX+VRoffsetX)), 2) + powf((prePointZ - (positionZ+VRoffsetZ)), 2));
                        } else {
                            calcZ_3 = -(sqrtf(powf((prePointX - (positionX+VRoffsetX)), 2) + powf((prePointZ - (positionZ+VRoffsetZ)), 2)));
                        }
                        prePointZ2 = (cosf(calcZ) * calcZ_3)+(positionZ+VRoffsetZ);
                        prePointX2 = (sinf(calcZ) * calcZ_3)+(positionX+VRoffsetX);
                        
                        if (prePointZ2-(positionZ+VRoffsetZ) <= 0) {
                            negativo = 1;
                        }
                        
                        float calcY = 0;
                        float calcX = 0;
                        
                        if ((prePointZ - (positionZ+VRoffsetZ)) == 0) {
                            calcX = 0;
                            calcY = 0;
                        } else {
                            if (negativo == 0) {
                                calcX = (((prePointX2 - (positionX+VRoffsetX))) * (100/(prePointZ2 - (positionZ+VRoffsetZ))));
                                calcY = (((prePointY - (positionYactual+VRoffsetY))) * (100/(prePointZ2 - (positionZ+VRoffsetZ))));
                            } else {
                                calcX = 100*(((prePointX2 - (positionX+VRoffsetX))));
                                calcY = 100*(((prePointY - (positionYactual+VRoffsetY))));
                                //printf("%.2f\n",(prePointZ2 - (positionZ+VRoffsetZ)));
                                //calcX = (((prePointX2 - positionX)) * (100/(prePointZ2 - (positionZ+VRoffsetZ))));
                                //calcY = (((prePointY - positionYactual)) * (100/(prePointZ2 - (positionZ+VRoffsetZ))));
                            }
                        }
                        
                        //tracks x span of polygon
                        if (refX == 0) {
                            refX = calcX;
                        } else {
                            if (fabsf(calcX-refX) > maxDiffX) {
                                maxDiffX = fabsf(calcX-refX);
                            }
                        }
                        
                        float preFinalPointX1 = (calcX*FOVvalue);
                        float preFinalPointY1 = (calcY*FOVvalue);
                        float FOVvar1 = 0;
                        float FOVvar2 = 0;
                        if (preFinalPointY1 != 0) {
                            if (preFinalPointX1 != 0) {
                                FOVvar1 = atan(preFinalPointX1/preFinalPointY1) + (FOVrotationrad);
                            } else {
                                FOVvar1 = FOVrotationrad;
                            }
                        } else {
                            if (preFinalPointX1 != 0) {
                                FOVvar1 = -(atan(preFinalPointX1/preFinalPointY1)) + (FOVrotationrad);
                            } else {
                                FOVvar1 = FOVrotationrad;
                            }
                        }
                        if (preFinalPointY1 > 0) {
                            FOVvar2 = sqrtf(powf(preFinalPointX1, 2) + powf(preFinalPointY1, 2));
                        } else {
                            FOVvar2 = -(sqrtf(powf(preFinalPointX1, 2) + powf(preFinalPointY1, 2)));
                        }
                        
                        finalPointX = ((sinf(FOVvar1) * FOVvar2) + (winSize.width/2));
                        finalPointY = ((cosf(FOVvar1) * FOVvar2) + (winSize.height/2) + vrGlobalYOffset + ((rotationY+((90.0+(float)gyroRollOffset)*0.08))*45.0));
                        
                        [pointsArrayX addObject:[NSNumber numberWithFloat:finalPointX]];
                        [pointsArrayY addObject:[NSNumber numberWithFloat:finalPointY]];
                    }
                    
                    if (maxDiffX > 2.1) { //if x span of polygon is higher than a certain range
                        polygon *poly1 = nil;
                        poly1 = [rect1 polygonsquare];
                        poly1.polygonzorder = (int)currentObject.zOrder;
                        poly1.polycolorBlue = currentObject.polygonColorBlue*currentObject.polygonShade;
                        poly1.polycolorGreen = currentObject.polygonColorGreen*currentObject.polygonShade;
                        poly1.polycolorRed = currentObject.polygonColorRed*currentObject.polygonShade;
                        if (levelTypeHWL2 == 1) {
                            poly1.polycolorBlue = ((currentObject.polygonColorBlue-190.0)*currentObject.polygonShade)+190.0;
                            poly1.polycolorGreen = ((currentObject.polygonColorGreen-50.0)*currentObject.polygonShade)+50.0;
                            poly1.polycolorRed = ((currentObject.polygonColorRed-17.0)*currentObject.polygonShade)+17.0;
                        }
                        poly1.polycolorAlpha = currentObject.polygonColorAlpha;
                        poly1.pointsOfPolygonX = [[NSMutableArray alloc] initWithArray:pointsArrayX];
                        poly1.pointsOfPolygonY = [[NSMutableArray alloc] initWithArray:pointsArrayY];
                        poly1.polygonBorderWidth = 0;
                        [self addChild:poly1];
                        [polygonArray addObject:poly1];
                    } else { //draws line spanning Y coordinates to compensate
                        polygon *poly1 = nil;
                        poly1 = [line1 polygonline];
                        poly1.polygonzorder = (int)currentObject.zOrder;
                        poly1.polycolorBlue = currentObject.polygonColorBlue*currentObject.polygonShade;
                        poly1.polycolorGreen = currentObject.polygonColorGreen*currentObject.polygonShade;
                        poly1.polycolorRed = currentObject.polygonColorRed*currentObject.polygonShade;
                        if (levelTypeHWL2 == 1) {
                            poly1.polycolorBlue = ((currentObject.polygonColorBlue-190.0)*currentObject.polygonShade)+190.0;
                            poly1.polycolorGreen = ((currentObject.polygonColorGreen-50.0)*currentObject.polygonShade)+50.0;
                            poly1.polycolorRed = ((currentObject.polygonColorRed-17.0)*currentObject.polygonShade)+17.0;
                        }
                        poly1.polycolorAlpha = currentObject.polygonColorAlpha;
                        poly1.polygonBorderWidth = 0;
                        
                        NSMutableArray *pointsArrayX2 = [[NSMutableArray alloc]init ];
                        NSMutableArray *pointsArrayY2 = [[NSMutableArray alloc]init ];
                        float xvalSum = 0;
                        for (int int1 = 1; int1 <= [pointsArrayX count]; int1++) {
                            xvalSum = xvalSum + [[pointsArrayX objectAtIndex:int1-1] floatValue];
                        }
                        float yvalSum = 0;
                        for (int int1 = 1; int1 <= [pointsArrayY count]; int1++) {
                            yvalSum = yvalSum + [[pointsArrayY objectAtIndex:int1-1] floatValue];
                        }
                        float ymax = -999999;
                        float ymin = 999999;
                        for (int int1 = 1; int1 <= [pointsArrayY count]; int1++) {
                            if ([[pointsArrayY objectAtIndex:int1-1] floatValue] < ymin) {
                                ymin = [[pointsArrayY objectAtIndex:int1-1] floatValue];
                            }
                            if ([[pointsArrayY objectAtIndex:int1-1] floatValue] > ymax) {
                                ymax = [[pointsArrayY objectAtIndex:int1-1] floatValue];
                            }
                        }
                        float length = fabsf(ymin-ymax)*0.54;
                        [pointsArrayX2 addObject:[NSNumber numberWithFloat:(xvalSum/((float)[pointsArrayX count]))-(sinf(FOVrotationrad)*length)]];
                        [pointsArrayX2 addObject:[NSNumber numberWithFloat:(xvalSum/((float)[pointsArrayX count]))+(sinf(FOVrotationrad)*length)]];
                        [pointsArrayY2 addObject:[NSNumber numberWithFloat:(yvalSum/((float)[pointsArrayY count]))-(cosf(FOVrotationrad)*length)]];
                        [pointsArrayY2 addObject:[NSNumber numberWithFloat:(yvalSum/((float)[pointsArrayY count]))+(cosf(FOVrotationrad)*length)]];
                        
                        poly1.pointsOfPolygonX = [[NSMutableArray alloc] initWithArray:pointsArrayX2];
                        poly1.pointsOfPolygonY = [[NSMutableArray alloc] initWithArray:pointsArrayY2];
                        [self addChild:poly1];
                        [polygonArray addObject:poly1];
                        
                        pointsArrayX2 = nil;
                        pointsArrayY2 = nil;
                    }
                    
                    pointsArrayX = nil;
                    pointsArrayY = nil;
                }
            } else if (currentObject.isafloorobject == 4) { //custom poly type, arrow
                if (facingObject == 1) {
                    //calculate 4 surrounding points
                    float finalPointX = 0;
                    float finalPointY = 0;
                    float prePointX = currentObject.posX;
                    float prePointY = currentObject.posY+currentObject.oLBfuncYoffset;
                    float prePointZ = currentObject.posZ;
                    float prePointX2 = 0;
                    float prePointZ2 = 0;
                    NSMutableArray *pointsArrayX1 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayY1 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayX2 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayY2 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayX3 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayY3 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayX4 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayY4 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayX5 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayY5 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayX6 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayY6 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayX7 = [[NSMutableArray alloc]init ];
                    NSMutableArray *pointsArrayY7 = [[NSMutableArray alloc]init ];
                    //safety for vertical polygons
                    for (int int1 = 1; int1 <= 14; int1++) { //number of sides must correspond with positions below
                        if (int1 == 1) {
                            prePointX = currentObject.posX+(8.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY-(4.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ+(8.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 2) {
                            prePointX = currentObject.posX-(2.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY-(4.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ-(2.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 3) {
                            prePointX = currentObject.posX+(8.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY+(4.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ+(8.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 4) {
                            prePointX = currentObject.posX-(2.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY+(4.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ-(2.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 5) {
                            prePointX = currentObject.posX+(8.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY-(4.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ+(8.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 6) {
                            prePointX = currentObject.posX+(8.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY+(4.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ+(8.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 7) {
                            prePointX = currentObject.posX-(2.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY+(4.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ-(2.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 8) {
                            prePointX = currentObject.posX-(2.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY+(6.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ-(2.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 9) {
                            prePointX = currentObject.posX-(2.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY-(4.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ-(2.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 10) {
                            prePointX = currentObject.posX-(2.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY-(6.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ-(2.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 11) {
                            prePointX = currentObject.posX-(2.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY-(6.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ-(2.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 12) {
                            prePointX = currentObject.posX-(8.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY;
                            prePointZ = currentObject.posZ-(8.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 13) {
                            prePointX = currentObject.posX-(2.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY+(6.0*currentObject.standardScale);
                            prePointZ = currentObject.posZ-(2.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        } else if (int1 == 14) {
                            prePointX = currentObject.posX-(8.0*cosf(currentObject.particleDilationRate)*currentObject.standardScale);
                            prePointY = currentObject.posY;
                            prePointZ = currentObject.posZ-(8.0*sinf(currentObject.particleDilationRate)*currentObject.standardScale);
                        }
                        
                        float negativo = 0;
                        float calcZ = atan((prePointX - (positionX+VRoffsetX))/(prePointZ - (positionZ+VRoffsetZ))) + (CC_DEGREES_TO_RADIANS((rotationX+(gyroYawOffset/16.5)))*16.5)+currentObject.rotationoffsetx2;
                        float calcZ_3 = 0;
                        if ((prePointZ - (positionZ+VRoffsetZ)) >= 0) {
                            calcZ_3 = sqrtf(powf((prePointX - (positionX+VRoffsetX)), 2) + powf((prePointZ - (positionZ+VRoffsetZ)), 2));
                        } else {
                            calcZ_3 = -(sqrtf(powf((prePointX - (positionX+VRoffsetX)), 2) + powf((prePointZ - (positionZ+VRoffsetZ)), 2)));
                        }
                        prePointZ2 = (cosf(calcZ) * calcZ_3)+(positionZ+VRoffsetZ);
                        prePointX2 = (sinf(calcZ) * calcZ_3)+(positionX+VRoffsetX);
                        
                        if (prePointZ2-(positionZ+VRoffsetZ) <= 0) {
                            negativo = 1;
                        }
                        
                        float calcY = 0;
                        float calcX = 0;
                        
                        if ((prePointZ - (positionZ+VRoffsetZ)) == 0) {
                            calcX = 0;
                            calcY = 0;
                        } else {
                            if (negativo == 0) {
                                calcX = (((prePointX2 - (positionX+VRoffsetX))) * (100/(prePointZ2 - (positionZ+VRoffsetZ))));
                                calcY = (((prePointY - (positionYactual+VRoffsetY))) * (100/(prePointZ2 - (positionZ+VRoffsetZ))));
                            } else {
                                calcX = 100*(((prePointX2 - (positionX+VRoffsetX))));
                                calcY = 100*(((prePointY - (positionYactual+VRoffsetY))));
                            }
                        }
                        
                        float preFinalPointX1 = (calcX*FOVvalue);
                        float preFinalPointY1 = (calcY*FOVvalue);
                        float FOVvar1 = 0;
                        float FOVvar2 = 0;
                        if (preFinalPointY1 != 0) {
                            if (preFinalPointX1 != 0) {
                                FOVvar1 = atan(preFinalPointX1/preFinalPointY1) + (FOVrotationrad);
                            } else {
                                FOVvar1 = FOVrotationrad;
                            }
                        } else {
                            if (preFinalPointX1 != 0) {
                                FOVvar1 = -(atan(preFinalPointX1/preFinalPointY1)) + (FOVrotationrad);
                            } else {
                                FOVvar1 = FOVrotationrad;
                            }
                        }
                        if (preFinalPointY1 > 0) {
                            FOVvar2 = sqrtf(powf(preFinalPointX1, 2) + powf(preFinalPointY1, 2));
                        } else {
                            FOVvar2 = -(sqrtf(powf(preFinalPointX1, 2) + powf(preFinalPointY1, 2)));
                        }
                        
                        finalPointX = ((sinf(FOVvar1) * FOVvar2) + (winSize.width/2));
                        finalPointY = ((cosf(FOVvar1) * FOVvar2) + (winSize.height/2) + vrGlobalYOffset + ((rotationY+((90.0+(float)gyroRollOffset)*0.08))*45.0));
                        
                        if (int1 <= 2) {
                            [pointsArrayX1 addObject:[NSNumber numberWithFloat:finalPointX]];
                            [pointsArrayY1 addObject:[NSNumber numberWithFloat:finalPointY]];
                        } else if (int1 <= 4) {
                            [pointsArrayX2 addObject:[NSNumber numberWithFloat:finalPointX]];
                            [pointsArrayY2 addObject:[NSNumber numberWithFloat:finalPointY]];
                        } else if (int1 <= 6) {
                            [pointsArrayX3 addObject:[NSNumber numberWithFloat:finalPointX]];
                            [pointsArrayY3 addObject:[NSNumber numberWithFloat:finalPointY]];
                        } else if (int1 <= 8) {
                            [pointsArrayX4 addObject:[NSNumber numberWithFloat:finalPointX]];
                            [pointsArrayY4 addObject:[NSNumber numberWithFloat:finalPointY]];
                        } else if (int1 <= 10) {
                            [pointsArrayX5 addObject:[NSNumber numberWithFloat:finalPointX]];
                            [pointsArrayY5 addObject:[NSNumber numberWithFloat:finalPointY]];
                        } else if (int1 <= 12) {
                            [pointsArrayX6 addObject:[NSNumber numberWithFloat:finalPointX]];
                            [pointsArrayY6 addObject:[NSNumber numberWithFloat:finalPointY]];
                        } else if (int1 <= 14) {
                            [pointsArrayX7 addObject:[NSNumber numberWithFloat:finalPointX]];
                            [pointsArrayY7 addObject:[NSNumber numberWithFloat:finalPointY]];
                        }
                    }
                    
                    for (int int1 = 1; int1 <= 7; int1++) {
                        polygon *poly1 = nil;
                        poly1 = [line1 polygonline];
                        poly1.polygonzorder = (int)currentObject.zOrder;
                        poly1.polycolorBlue = currentObject.polygonColorBlue;
                        poly1.polycolorGreen = currentObject.polygonColorGreen;
                        poly1.polycolorRed = currentObject.polygonColorRed;
                        poly1.polycolorAlpha = currentObject.polygonColorAlpha;
                        poly1.polygonBorderWidth = ((1.0*(1.0+cosf(arrowAnimX)))+2.0)*currentObject.standardScale;
                        if (int1 == 1) {
                            poly1.pointsOfPolygonX = [[NSMutableArray alloc] initWithArray:pointsArrayX1];
                            poly1.pointsOfPolygonY = [[NSMutableArray alloc] initWithArray:pointsArrayY1];
                        } else if (int1 == 2) {
                            poly1.pointsOfPolygonX = [[NSMutableArray alloc] initWithArray:pointsArrayX2];
                            poly1.pointsOfPolygonY = [[NSMutableArray alloc] initWithArray:pointsArrayY2];
                        } else if (int1 == 3) {
                            poly1.pointsOfPolygonX = [[NSMutableArray alloc] initWithArray:pointsArrayX3];
                            poly1.pointsOfPolygonY = [[NSMutableArray alloc] initWithArray:pointsArrayY3];
                        } else if (int1 == 4) {
                            poly1.pointsOfPolygonX = [[NSMutableArray alloc] initWithArray:pointsArrayX4];
                            poly1.pointsOfPolygonY = [[NSMutableArray alloc] initWithArray:pointsArrayY4];
                        } else if (int1 == 5) {
                            poly1.pointsOfPolygonX = [[NSMutableArray alloc] initWithArray:pointsArrayX5];
                            poly1.pointsOfPolygonY = [[NSMutableArray alloc] initWithArray:pointsArrayY5];
                        } else if (int1 == 6) {
                            poly1.pointsOfPolygonX = [[NSMutableArray alloc] initWithArray:pointsArrayX6];
                            poly1.pointsOfPolygonY = [[NSMutableArray alloc] initWithArray:pointsArrayY6];
                        } else if (int1 == 7) {
                            poly1.pointsOfPolygonX = [[NSMutableArray alloc] initWithArray:pointsArrayX7];
                            poly1.pointsOfPolygonY = [[NSMutableArray alloc] initWithArray:pointsArrayY7];
                        }
                        [self addChild:poly1];
                        [polygonArray addObject:poly1];
                    }
                    
                    pointsArrayX1 = nil;
                    pointsArrayY1 = nil;
                    pointsArrayX2 = nil;
                    pointsArrayY2 = nil;
                    pointsArrayX3 = nil;
                    pointsArrayY3 = nil;
                    pointsArrayX4 = nil;
                    pointsArrayY4 = nil;
                    pointsArrayX5 = nil;
                    pointsArrayY5 = nil;
                    pointsArrayX6 = nil;
                    pointsArrayY6 = nil;
                    pointsArrayX7 = nil;
                    pointsArrayY7 = nil;
                }
            }
            
            /*//DEV - highlight close objects
             if (currentObject.hypotenusetoplayer < 130.0 && currentObject.hypotenusetoplayer > -130.0 && currentObject.visible == YES && currentObject.objectusessubobjects == 1 && currentObject.objectgrabbed != 0) {
             for (CCSprite *sprite in objectArray) {
             object *otherObject = (object *)sprite;
             
             if (otherObject.objectid == 5 && otherObject.parentobjectid == currentObject.uniqueobjectid && otherObject.visible == YES) {
             for (CCSprite *sprite in objectArray) {
             object *otherObject2 = (object *)sprite;
             if (otherObject2.objectid == 5 && otherObject2.parentobjectid == currentObject.uniqueobjectid && otherObject2.visible == YES && otherObject != otherObject2) {
             drawLayer * dwLayer = (drawLayer *)[self.parent getChildByTag:02];
             [dwLayer drawLine:otherObject2.position.x :otherObject2.position.y :otherObject.position.x :otherObject.position.y];
             }
             }
             }
             }
             }*/
        } else { //vr elements
            if (currentObject.objectid == 17) { //scenery
                currentObject.opacity = currentObject.customOpacity;
                currentObject.rotation = FOVrotation-gyroPitchOffset;
                
                currentObject.position = ccp((currentObject.FOVrotationobjectvar3 + (winSize.width/2)),(currentObject.FOVrotationobjectvar4 + (winSize.height/2.0) + vrGlobalYOffset + (rotationY+((90.0+(float)gyroRollOffset)*0.08))*45.0));
                
            } else if (currentObject.objectid == 18) { //crosshair
                currentObject.opacity = currentObject.customOpacity;
            } else if (currentObject.objectid != 18) { //other vr elements
                if (currentVRmenu == 0) {
                    if (currentObject.objectid == 23) {
                        if (currentObject.deleteObject == 0) {
                            currentObject.customOpacity = currentObject.customOpacity+((0.7-currentObject.customOpacity)/4.0);
                            currentObject.opacity = currentObject.customOpacity;
                        } else {
                            currentObject.customOpacity = currentObject.customOpacity+((0.0-currentObject.customOpacity)/4.0);
                            if (currentObject.customOpacity < 0.02) {
                                [objectRemovalArray addObject:currentObject];
                            }
                            currentObject.opacity = currentObject.customOpacity;
                        }
                    } else {
                        currentObject.customOpacity = currentObject.customOpacity+((0.0-currentObject.customOpacity)/4.0);
                        if (currentObject.customOpacity < 0.02) {
                            [objectRemovalArray addObject:currentObject];
                        }
                        if ([currentObject isKindOfClass: [vr6 class]]) {
                            currentObject.opacity = currentObject.customOpacity*(1-vrCSinputModeOn);
                        } else if ([currentObject isKindOfClass: [vr6_2 class]]) {
                            if (vrCSItemSelected == vrCSItemSelectedMAX-1) {
                                currentObject.opacity = currentObject.customOpacity;
                            } else {
                                currentObject.opacity = 0;
                            }
                        } else {
                            currentObject.opacity = currentObject.customOpacity;
                        }
                    }
                } else {
                    if (currentObject.deleteObject == 0) {
                        if (currentObject.objectid == 22) {
                            if (currentObject.pospreYoffset+vrCSscrollY < 100 && currentObject.pospreYoffset+vrCSscrollY > -185) {
                                currentObject.customOpacity = currentObject.customOpacity+((1.0-currentObject.customOpacity)/4.0);
                            } else {
                                currentObject.customOpacity = currentObject.customOpacity+((0.0-currentObject.customOpacity)/4.0);
                            }
                        } else {
                            currentObject.customOpacity = currentObject.customOpacity+((1.0-currentObject.customOpacity)/4.0);
                        }
                        
                        if (vrCSItemSelected == currentObject.objectdistancetoggle && currentObject.objectid == 22 && ![currentObject isKindOfClass: [vr6_2 class]]) { //selected
                            currentObject.opacity = (currentObject.customOpacity*sinf(vrCSSelectionAnimX)*0.4)+0.6;
                        } else { //not selected
                            if ([currentObject isKindOfClass: [vr6 class]]) {
                                currentObject.opacity = currentObject.customOpacity*(1-vrCSinputModeOn);
                            } else if ([currentObject isKindOfClass: [vr6_2 class]]) {
                                if (vrCSItemSelected == vrCSItemSelectedMAX-1) {
                                    currentObject.opacity = currentObject.customOpacity;
                                } else {
                                    currentObject.opacity = 0;
                                }
                            } else {
                                currentObject.opacity = currentObject.customOpacity;
                            }
                        }
                    } else {
                        currentObject.customOpacity = currentObject.customOpacity+((0.0-currentObject.customOpacity)/4.0);
                        if (currentObject.customOpacity < 0.02) {
                            [objectRemovalArray addObject:currentObject];
                        }
                        if (vrCSItemSelected == currentObject.objectdistancetoggle && currentObject.objectid == 22 && ![currentObject isKindOfClass: [vr6_2 class]]) { //selected
                            currentObject.opacity = currentObject.customOpacity;
                        } else { //not selected
                            if ([currentObject isKindOfClass: [vr6 class]]) {
                                currentObject.opacity = currentObject.customOpacity*(1-vrCSinputModeOn);
                            } else if ([currentObject isKindOfClass: [vr6_2 class]]) {
                                currentObject.opacity = 0;
                            } else {
                                currentObject.opacity = currentObject.customOpacity;
                            }
                        }
                    }
                }
            }
            
            if (currentObject.objectid == 22) {
                if ([currentObject isKindOfClass: [vr_kw5 class]]) {
                    currentObject.position = ccp(((winSize.width/2.0)+currentObject.pospreXoffset)-VReyeDistance*4.7+vrCSedValXOffset,((winSize.height/2.0) + vrGlobalYOffset + currentObject.pospreYoffset+vrCSscrollY));
                } else {
                    currentObject.position = ccp(((winSize.width/2.0)+currentObject.pospreXoffset)-VReyeDistance*4.7,((winSize.height/2.0) + vrGlobalYOffset + currentObject.pospreYoffset+vrCSscrollY));
                }
            } else {
                currentObject.position = ccp(((winSize.width/2.0)+currentObject.pospreXoffset)-VReyeDistance*4.7,((winSize.height/2.0) + vrGlobalYOffset + currentObject.pospreYoffset));
            }
            currentObject.scaleX = currentObject.objectScaleX * isiPhone6PlusCoeff;
            currentObject.scaleY = currentObject.objectScaleY * isiPhone6PlusCoeff;
            if (currentObject.zOrder != 299935-currentObject.actual2DZorder) {
                [currentObject setZOrder:299935-currentObject.actual2DZorder];
            }
        }
    }
    
    //immediately compares motionScores
    if (vrEnabled != 0) {
        CCScene *scene = [CCDirector sharedDirector].runningScene;
        HelloWorldLayer *mainScene = (HelloWorldLayer *)scene;
        [mainScene getMotionScore:motionScore :vrPrimaryInstance];
    }
    
    //polygons
    for (CCDrawNode *sprite in polygonArray) {
        polygon *currentPolygon = (polygon *)sprite;
        if (currentPolygon.polyremoval == 0) {
            currentPolygon.polyremoval = 1;
            
            float borderwidth = currentPolygon.polygonBorderWidth;
            CCColor *fillColor = [CCColor colorWithCcColor4b:ccc4(currentPolygon.polycolorRed,currentPolygon.polycolorGreen,currentPolygon.polycolorBlue,255.0*currentPolygon.polycolorAlpha)];
            CCColor *borderColor = [CCColor colorWithCcColor4b:ccc4(currentPolygon.polycolorRed,currentPolygon.polycolorGreen,currentPolygon.polycolorBlue,255.0*currentPolygon.polycolorAlpha)];
            
            if (currentPolygon.polygontype == 1) { //legit polygon
                if ([currentPolygon.pointsOfPolygonX count] == 3) {
                    CGPoint vertices[]={ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:0] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:0] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:1] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:1] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:2] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:2] floatValue])};
                    [currentPolygon drawPolyWithVerts:vertices count:[currentPolygon.pointsOfPolygonX count] fillColor:fillColor borderWidth:borderwidth borderColor:borderColor];
                    [currentPolygon setZOrder:currentPolygon.polygonzorder];
                } else if ([currentPolygon.pointsOfPolygonX count] == 4) {
                    CGPoint vertices[]={ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:0] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:0] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:1] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:1] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:2] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:2] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:3] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:3] floatValue])};
                    [currentPolygon drawPolyWithVerts:vertices count:[currentPolygon.pointsOfPolygonX count] fillColor:fillColor borderWidth:borderwidth borderColor:borderColor];
                    [currentPolygon setZOrder:currentPolygon.polygonzorder];
                } else if ([currentPolygon.pointsOfPolygonX count] == 5) {
                    CGPoint vertices[]={ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:0] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:0] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:1] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:1] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:2] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:2] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:3] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:3] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:4] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:4] floatValue])};
                    [currentPolygon drawPolyWithVerts:vertices count:[currentPolygon.pointsOfPolygonX count] fillColor:fillColor borderWidth:borderwidth borderColor:borderColor];
                    [currentPolygon setZOrder:currentPolygon.polygonzorder];
                } else if ([currentPolygon.pointsOfPolygonX count] == 6) {
                    CGPoint vertices[]={ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:0] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:0] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:1] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:1] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:2] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:2] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:3] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:3] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:4] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:4] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:5] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:5] floatValue])};
                    [currentPolygon drawPolyWithVerts:vertices count:[currentPolygon.pointsOfPolygonX count] fillColor:fillColor borderWidth:borderwidth borderColor:borderColor];
                    [currentPolygon setZOrder:currentPolygon.polygonzorder];
                } else if ([currentPolygon.pointsOfPolygonX count] == 7) {
                    CGPoint vertices[]={ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:0] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:0] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:1] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:1] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:2] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:2] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:3] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:3] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:4] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:4] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:5] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:5] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:6] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:6] floatValue])};
                    [currentPolygon drawPolyWithVerts:vertices count:[currentPolygon.pointsOfPolygonX count] fillColor:fillColor borderWidth:borderwidth borderColor:borderColor];
                    [currentPolygon setZOrder:currentPolygon.polygonzorder];
                } else if ([currentPolygon.pointsOfPolygonX count] == 8) {
                    CGPoint vertices[]={ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:0] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:0] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:1] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:1] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:2] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:2] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:3] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:3] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:4] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:4] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:5] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:5] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:6] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:6] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:7] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:7] floatValue])};
                    [currentPolygon drawPolyWithVerts:vertices count:[currentPolygon.pointsOfPolygonX count] fillColor:fillColor borderWidth:borderwidth borderColor:borderColor];
                    [currentPolygon setZOrder:currentPolygon.polygonzorder];
                } else if ([currentPolygon.pointsOfPolygonX count] == 9) {
                    CGPoint vertices[]={ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:0] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:0] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:1] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:1] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:2] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:2] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:3] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:3] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:4] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:4] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:5] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:5] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:6] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:6] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:7] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:7] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:8] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:8] floatValue])};
                    [currentPolygon drawPolyWithVerts:vertices count:[currentPolygon.pointsOfPolygonX count] fillColor:fillColor borderWidth:borderwidth borderColor:borderColor];
                    [currentPolygon setZOrder:currentPolygon.polygonzorder];
                } else if ([currentPolygon.pointsOfPolygonX count] == 10) {
                    CGPoint vertices[]={ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:0] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:0] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:1] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:1] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:2] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:2] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:3] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:3] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:4] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:4] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:5] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:5] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:6] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:6] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:7] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:7] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:8] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:8] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:9] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:9] floatValue])};
                    [currentPolygon drawPolyWithVerts:vertices count:[currentPolygon.pointsOfPolygonX count] fillColor:fillColor borderWidth:borderwidth borderColor:borderColor];
                    [currentPolygon setZOrder:currentPolygon.polygonzorder];
                } else if ([currentPolygon.pointsOfPolygonX count] == 11) {
                    CGPoint vertices[]={ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:0] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:0] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:1] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:1] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:2] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:2] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:3] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:3] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:4] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:4] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:5] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:5] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:6] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:6] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:7] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:7] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:8] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:8] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:9] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:9] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:10] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:10] floatValue])};
                    [currentPolygon drawPolyWithVerts:vertices count:[currentPolygon.pointsOfPolygonX count] fillColor:fillColor borderWidth:borderwidth borderColor:borderColor];
                    [currentPolygon setZOrder:currentPolygon.polygonzorder];
                } else if ([currentPolygon.pointsOfPolygonX count] == 12) {
                    CGPoint vertices[]={ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:0] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:0] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:1] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:1] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:2] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:2] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:3] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:3] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:4] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:4] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:5] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:5] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:6] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:6] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:7] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:7] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:8] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:8] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:9] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:9] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:10] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:10] floatValue]),ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:11] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:11] floatValue])};
                    [currentPolygon drawPolyWithVerts:vertices count:[currentPolygon.pointsOfPolygonX count] fillColor:fillColor borderWidth:borderwidth borderColor:borderColor];
                    [currentPolygon setZOrder:currentPolygon.polygonzorder];
                }
            } else if (currentPolygon.polygontype == 0) { //line
                [currentPolygon drawSegmentFrom:ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:0] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:0] floatValue]) to:ccp([[currentPolygon.pointsOfPolygonX objectAtIndex:1] floatValue],[[currentPolygon.pointsOfPolygonY objectAtIndex:1] floatValue]) radius:borderwidth*1.3 color:borderColor];
                [currentPolygon setZOrder:currentPolygon.polygonzorder];
            }
        } else {
            currentPolygon.pointsOfPolygonX = nil;
            currentPolygon.pointsOfPolygonY = nil;
            [polygonRemovalArray addObject:currentPolygon];
        }
    }
    
    //labels
    for (CCLabelTTF *sprite in labelArray) {
        label *currentLabel = (label *)sprite;
        
        if (currentVRmenu == 0) {
            currentLabel.labelopacity = currentLabel.labelopacity+((0.0-currentLabel.labelopacity)/4.0);
            if (currentLabel.labelopacity < 0.02) {
                [labelRemovalArray addObject:currentLabel];
            }
            currentLabel.opacity = currentLabel.labelopacity;
        } else {
            if (currentLabel.deleteLabel == 0) {
                if (currentLabel.labelid == 0) {
                    if (currentLabel.labelposY+vrCSscrollY < 100 && currentLabel.labelposY+vrCSscrollY > -185) {
                        currentLabel.labelopacity = currentLabel.labelopacity+((1.0-currentLabel.labelopacity)/4.0);
                    } else {
                        currentLabel.labelopacity = currentLabel.labelopacity+((0.0-currentLabel.labelopacity)/4.0);
                    }
                }
                
                if (vrCSItemSelected == currentLabel.labelsubid && currentLabel.labelid == 0) { //selected
                    currentLabel.opacity = (currentLabel.labelopacity*sinf(vrCSSelectionAnimX)*0.4)+0.6;
                } else { //not selected
                    currentLabel.opacity = currentLabel.labelopacity;
                }
            } else {
                currentLabel.labelopacity = currentLabel.labelopacity+((0.0-currentLabel.labelopacity)/4.0);
                if (currentLabel.labelopacity < 0.02) {
                    [labelRemovalArray addObject:currentLabel];
                }
                currentLabel.opacity = currentLabel.labelopacity;
            }
        }
        
        if (currentLabel.labelid == 0) {
            currentLabel.position = ccp(((winSize.width/2.0)+currentLabel.labelposX)-VReyeDistance*4.7,((winSize.height/2.0) + vrGlobalYOffset + currentLabel.labelposY+vrCSscrollY));
        }
        currentLabel.scaleX = isiPhone6PlusCoeff*0.5;
        currentLabel.scaleY = isiPhone6PlusCoeff*0.5;
        if (currentLabel.zOrder != 299935-currentLabel.labelzorder) {
            [currentLabel setZOrder:299935-currentLabel.labelzorder];
        }
    }
    
    //vr highlighting
    if (vrosCurrentClosestObjectID != -1) {
        vrosClosestObjectID = vrosCurrentClosestObjectID;
    } else {
        vrosClosestObjectID = -1;
    }
    
    //statItem
    for (CCSprite *sprite in statItemArray) {
        statItem *currentItem = (statItem *)sprite;
        
        if (currentItem.statitemid == 0) {
            
            currentItem.rotation = CC_RADIANS_TO_DEGREES(FOVrotationrad);
            float hypotenuseToCenter = ((currentItem.contentSize.height/2)*currentItem.scaleY);
            
            currentItem.statitemposx = (winSize.width/2)+(sinf(FOVrotationrad+(3.1415926535897932))*hypotenuseToCenter);
            currentItem.statitemposy = (winSize.height/2)+(cosf(FOVrotationrad+(3.1415926535897932))*hypotenuseToCenter);
            currentItem.position = ccp(currentItem.statitemposx,currentItem.statitemposy + ((rotationY+((90.0+(float)gyroRollOffset)*0.08))*45.0) + vrGlobalYOffset);
            
            if (currentItem.opacity != 255.0) {
                currentItem.opacity = 255.0;
            }
            
            float startOpacity = 0;
            if (shadeDistance > 300+((positionYactual-playerHeight)*2.5)) {
                startOpacity = 255;
            } else {
                startOpacity = (shadeDistance/(300.0+((positionYactual-playerHeight)*2.5)))*255.0;
            }
            currentItem.color = [CCColor colorWithCcColor3b:ccc3(startOpacity,startOpacity,startOpacity)];
        } else if (currentItem.statitemid == 1) {
            
            currentItem.rotation = CC_RADIANS_TO_DEGREES(FOVrotationrad);
            float hypotenuseToCenter = ((currentItem.contentSize.height/2)*currentItem.scaleY);
            
            currentItem.statitemposx = (winSize.width/2)+(sinf(FOVrotationrad)*hypotenuseToCenter);
            currentItem.statitemposy = (winSize.height/2)+(cosf(FOVrotationrad)*hypotenuseToCenter);
            currentItem.position = ccp(currentItem.statitemposx,currentItem.statitemposy + ((rotationY+((90.0+(float)gyroRollOffset)*0.08))*45.0) + vrGlobalYOffset);
            
            if (currentItem.opacity != 255.0) {
                currentItem.opacity = 255.0;
            }
            
            currentItem.color = [CCColor colorWithCcColor3b:ccc3(255.0,255.0,255.0)];
        } else if (currentItem.statitemid == 2) {
            
            currentItem.rotation = CC_RADIANS_TO_DEGREES(FOVrotationrad);
            float hypotenuseToCenter = ((currentItem.contentSize.height/2)*currentItem.scaleY);
            
            currentItem.statitemposx = (winSize.width/2)+(sinf(FOVrotationrad+(3.1415926535897932))*hypotenuseToCenter);
            currentItem.statitemposy = (winSize.height/2)+(cosf(FOVrotationrad+(3.1415926535897932))*hypotenuseToCenter);
            currentItem.position = ccp(currentItem.statitemposx,currentItem.statitemposy + ((rotationY+((90.0+(float)gyroRollOffset)*0.08))*45.0) + vrGlobalYOffset);
            
            float startOpacity = 0;
            if (shadeDistance <= 360) {
                startOpacity = 255;
            } else if (shadeDistance >= 2000) {
                startOpacity = 0;
            } else if (shadeDistance < 2000 && shadeDistance > 360) {
                startOpacity = ((1640.0-(shadeDistance-360.0))/1640.0)*255.0;
            }
            currentItem.opacity = startOpacity/255.0;
        }
    }
    
    /*//detecting any grabbed object
    if (sendMenuLayerLDGDinfo == 1) {
        sendMenuLayerLDGDinfo = 0;
        
        if (anyobjectgrabbed == 0 && anyobjectgrabbedtoggle == 1) {
            anyobjectgrabbedtoggle = 0;
            grabbedobject = 0;
            //sends info back to menu layer
            MenuLayer * mnLayer = (MenuLayer *)[self.parent getChildByTag:01];
            [mnLayer getGrabbableObjectPossibility:0];
        } else if (anyobjectgrabbed == 0 && anyobjectgrabbedtoggle == 0) {
            //sends info back to menu layer
            MenuLayer * mnLayer = (MenuLayer *)[self.parent getChildByTag:01];
            [mnLayer getGrabbableObjectPossibility:1];
        } else if (anyobjectgrabbed == 1 || grabbedobject == 1) {
            //sends info back to menu layer
            MenuLayer * mnLayer = (MenuLayer *)[self.parent getChildByTag:01];
            [mnLayer getGrabbableObjectPossibility:2];
        }
    }*/
    
    //object resubstitution
    for (CCSprite *sprite in objectTransitionArray) {
        object *currentObject = (object *)sprite;
        
        //uniqueID code - NECESSARY FOR ALL OBJECT CREATIONS
        bool check1 = 0;
        while (check1 == 0 && [allUniqueObjectIds count] > 0) {
            check1 = 1;
            for (int i = 0; i < [allUniqueObjectIds count]; i++) {
                if (currentObject.uniqueobjectid == [[allUniqueObjectIds objectAtIndex:i] intValue]) {
                    currentObject.uniqueobjectid++;
                    check1 = 0;
                }
            }
        }
        [allUniqueObjectIds addObject:[NSNumber numberWithInt:currentObject.uniqueobjectid]];
        
        [objectArray addObject:currentObject];
        [objectTransitionRemovalArray addObject:currentObject];
    }
    
    //delete objects
    for (CCSprite *sprite in objectRemovalArray) {
        [objectArray removeObject:sprite];
        [self removeChild:sprite cleanup:YES];
    }
    objectRemovalArray = nil;
    
    //remove objects from transition array
    for (CCSprite *sprite in objectTransitionRemovalArray) {
        [objectTransitionArray removeObject:sprite];
    }
    objectTransitionRemovalArray = nil;
    
    //delete polygons
    for (CCDrawNode *sprite in polygonRemovalArray) {
        [polygonArray removeObject:sprite];
        [self removeChild:sprite cleanup:YES];
    }
    
    //delete labels
    for (CCLabelTTF *sprite in labelRemovalArray) {
        [labelArray removeObject:sprite];
        [self removeChild:sprite cleanup:YES];
    }
    labelRemovalArray = nil;
    
    //delete statItems
    for (CCSprite *sprite in statItemRemovalArray) {
        [statItemArray removeObject:sprite];
        [self removeChild:sprite cleanup:YES];
    }
    statItemRemovalArray = nil;
    
    //syncing
    tempSyncUniqueIDs = [[NSMutableArray alloc] init];
    tempSyncPhysicalProperties = [[NSMutableArray alloc] init];
    
    if ([startSyncUniqueIDs count] > 0) { //starts a sync
        NSMutableArray *positionArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:positionX], [NSNumber numberWithFloat:positionY], [NSNumber numberWithFloat:positionZ], [NSNumber numberWithFloat:rotationX], [NSNumber numberWithFloat:rotationY], [NSNumber numberWithInt:colorID], [NSNumber numberWithBool:collectingColorup], [NSNumber numberWithFloat:collectingColorupTrans], nil];
        
        CCScene *scene = [CCDirector sharedDirector].runningScene;
        HelloWorldLayer *mainScene = (HelloWorldLayer *)scene;
        [mainScene getPrimaryInstanceSyncData:startSyncUniqueIDs :startSyncPhysicalProperties :positionArray];
    }
}

-(id) init
{
    if( (self=[super init] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        
        objectArray = [[NSMutableArray alloc]init ];
        objectTransitionArray = [[NSMutableArray alloc]init ];
        allUniqueObjectIds = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0], nil]; //prevents any object from having 0 as a unique ID
        polygonArray = [[NSMutableArray alloc]init ];
        statItemArray = [[NSMutableArray alloc]init ];
        labelArray = [[NSMutableArray alloc]init ];
        
        //sets up initial pre-loaded "random" numbers
        randNumberArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:0.537541569], [NSNumber numberWithFloat:0.132723042], [NSNumber numberWithFloat:0.618744764], [NSNumber numberWithFloat:0.293344437], [NSNumber numberWithFloat:0.893346023], [NSNumber numberWithFloat:0.396128913], [NSNumber numberWithFloat:0.917114072], [NSNumber numberWithFloat:0.247347853], [NSNumber numberWithFloat:0.232414962], [NSNumber numberWithFloat:0.830266141], [NSNumber numberWithFloat:0.303195859], [NSNumber numberWithFloat:0.018316813], [NSNumber numberWithFloat:0.976459222], [NSNumber numberWithFloat:0.237741013], [NSNumber numberWithFloat:0.032342849], [NSNumber numberWithFloat:0.780015984], [NSNumber numberWithFloat:0.531399063], [NSNumber numberWithFloat:0.529829887], [NSNumber numberWithFloat:0.185832289], [NSNumber numberWithFloat:0.975409450], [NSNumber numberWithFloat:0.405397441], [NSNumber numberWithFloat:0.190646781], [NSNumber numberWithFloat:0.015215383], [NSNumber numberWithFloat:0.220051274], [NSNumber numberWithFloat:0.827903551], nil];
        
        randFishNumberArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:0.417203204], [NSNumber numberWithFloat:0.624795825], [NSNumber numberWithFloat:0.309618007], [NSNumber numberWithFloat:0.263597117], [NSNumber numberWithFloat:0.007864375], [NSNumber numberWithFloat:0.014681689], [NSNumber numberWithFloat:0.205116563], [NSNumber numberWithFloat:0.154086473], [NSNumber numberWithFloat:0.995016997], [NSNumber numberWithFloat:0.415453748], [NSNumber numberWithFloat:0.926887085], [NSNumber numberWithFloat:0.480910485], [NSNumber numberWithFloat:0.991325556], [NSNumber numberWithFloat:0.113943968], [NSNumber numberWithFloat:0.261476735], [NSNumber numberWithFloat:0.204020202], [NSNumber numberWithFloat:0.546305459], [NSNumber numberWithFloat:0.717775199], [NSNumber numberWithFloat:0.920035728], [NSNumber numberWithFloat:0.731311879], [NSNumber numberWithFloat:0.686706657], [NSNumber numberWithFloat:0.324472144], [NSNumber numberWithFloat:0.511901727], [NSNumber numberWithFloat:0.764738625], [NSNumber numberWithFloat:0.273633238], [NSNumber numberWithFloat:0.851178110], [NSNumber numberWithFloat:0.831817328], [NSNumber numberWithFloat:0.188162056], [NSNumber numberWithFloat:0.166225022], [NSNumber numberWithFloat:0.664033068], [NSNumber numberWithFloat:0.691148432], [NSNumber numberWithFloat:0.668032980], [NSNumber numberWithFloat:0.978983194], [NSNumber numberWithFloat:0.778098585], [NSNumber numberWithFloat:0.402404151], [NSNumber numberWithFloat:0.171752762], [NSNumber numberWithFloat:0.162464029], [NSNumber numberWithFloat:0.616058662], [NSNumber numberWithFloat:0.463421092], [NSNumber numberWithFloat:0.076619122], [NSNumber numberWithFloat:0.155226229], [NSNumber numberWithFloat:0.609863571], [NSNumber numberWithFloat:0.773468161], [NSNumber numberWithFloat:0.790142673], [NSNumber numberWithFloat:0.323309722], [NSNumber numberWithFloat:0.395382544], [NSNumber numberWithFloat:0.225712104], [NSNumber numberWithFloat:0.225712104], [NSNumber numberWithFloat:0.810643544], [NSNumber numberWithFloat:0.470353760], [NSNumber numberWithFloat:0.416988054], [NSNumber numberWithFloat:0.731868073], [NSNumber numberWithFloat:0.486458640], [NSNumber numberWithFloat:0.735871460], [NSNumber numberWithFloat:0.468910115], [NSNumber numberWithFloat:0.723210739], [NSNumber numberWithFloat:0.691018391], [NSNumber numberWithFloat:0.003025739], [NSNumber numberWithFloat:0.878601998], [NSNumber numberWithFloat:0.057752646], [NSNumber numberWithFloat:0.239191939], [NSNumber numberWithFloat:0.161496130], [NSNumber numberWithFloat:0.9], [NSNumber numberWithFloat:0.85], [NSNumber numberWithFloat:0.8], [NSNumber numberWithFloat:0.5028], nil];
        
        //initial vars
        isiPhone6PlusCoeff = ((float)[self iPhone6Plus]+1.0)*2.0;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
                CGSize result = [[UIScreen mainScreen] bounds].size;
                CGFloat scale = [UIScreen mainScreen].scale;
                result = CGSizeMake(result.width * scale,result.height * scale);
                if (result.height == 640){
                    //isiPhone6PlusCoeff = isiPhone6PlusCoeff/2.0;
                }
            }
        }
        playerCollisionsEnabled = 0;
        playerGravityEnabled = 1;
        playerHeight = 25;
        
        levelTypeHWL2 = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"levelType"];
        
        minYpos = playerHeight;
        mininitialYpos = minYpos;
        VReyeDistance = 0; //manually set later
        positionX = 0;
        positionY = minYpos;
        positionZ = 0;
        
        rotationX = 0.01;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            FOVvalue = 4.2;
        } else {
            FOVvalue = 2.18;
        }
        FOVvalueinitial = FOVvalue;
        FOVrotation = 0;
        gravityBuffer1 = 0.3;
        gravityBuffer2 = 0.2;
        minYposold = minYpos;
        iPadVarMain = 1;//not ipad
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            iPadVarMain = 2;//yes ipad
        }
        useWalkingAnimation = 1; //0 = default
        baseWalkingSpeed = 0.7;
        grabbedobjectrefresh = -1;
        btKeyboardConnectedTimer = 360;
        quickLoadQueued = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"quickLoad"];
        colorID = 1;
        
        //orientation safety
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if (orientation == UIDeviceOrientationLandscapeLeft) {
            gyroQuadrant = 1;
        } else if (orientation == UIDeviceOrientationLandscapeRight) {
            gyroQuadrant = 2;
        }
        gyroQuadrantRefresh = -1;
        
        [self resetWorldAndReload];
        
        //timed actions
        [self schedule:@selector(act) interval:1.0/60.0];
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        self.motionManager = [[CMMotionManager alloc] init];
        motionManager.deviceMotionUpdateInterval = 1.0/60.0;
        if (motionManager.isDeviceMotionAvailable) {
            [motionManager startDeviceMotionUpdates];
        }
    }
    return self;
}

@end
