#import "MenuLayer.h"
#import "menuItem.h"
#import "inventoryObject.h"
#import "HelloWorldLayer2.h"

@implementation MenuLayer

- (void)appHasGoneInBackground {
    printf("APP EXITED\n");
    touchStateAction = 0;
    touchStateJoystick = 0;
    touchStateJump = 0;
}

-(BOOL)iPhone6Plus{
    if ([UIScreen mainScreen].scale > 2.1) return YES; //iPhone 6+
    
    return NO;
}

- (void)getObjectBeingHighlighted:(bool)val {
    objectBeingHighlightedML = val;
}

- (void)getObjectGrabbed:(bool)val {
    grabbedObjectML = val;
}

- (void)touchBeganCustom:(NSMutableArray *)activeTouchesX :(NSMutableArray *)activeTouchesY :(int)touchIndex {
    if ((int)[activeTouchesX count] > 0) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        CGSize actualwinSize = [[CCDirector sharedDirector] viewSizeInPixels];
        currentTouchesX_ML = activeTouchesX;
        currentTouchesY_ML = activeTouchesY;
        float touchX = [[currentTouchesX_ML objectAtIndex:touchIndex] floatValue];
        float touchY = winSize.height-[[currentTouchesY_ML objectAtIndex:touchIndex] floatValue];
        
        //dev
        if (cutSceneActive == 1) {
            cutSceneActive = 0;
        }
        
        bool touchCheck1 = 0;
        
        //joystick tap
        if (touchStateJoystick == 0 && cutSceneActive == 0) {
            float calcVar1 = sqrtf(powf(touchX-joystickPosX,2)+powf(touchY-joystickPosY,2));
            if (calcVar1 < joystickRadius) {
                touchStateJoystick = 1;
                joystickTouchPosX = touchX;
                joystickTouchPosY = touchY;
                touchCheck1 = 1;
                joystickTouchIndex = touchIndex;
                
                //printf("JOYSTICK TOUCH STARTED: %.1f, %i\n",touchX,(int)[currentTouchesX_ML count]);
            }
        }
        
        //jump tap
        if (touchStateJump == 0 && cutSceneActive == 0) {
            float calcVar1 = sqrtf(powf(touchX-jumpPosX,2)+powf(touchY-jumpPosY,2));
            if (calcVar1 < jumpButtonRadius) {
                for (CCSprite *sprite in menuItemArray) {
                    menuItem *currentItem = (menuItem *)sprite;
                    if (currentItem.itemid == 3) {
                        currentItem.itemtappedinitially = 1;
                    }
                }
                touchStateJump = 1;
                touchCheck1 = 1;
                jumpTouchIndex = touchIndex;
                //printf("JUMP TOUCH STARTED: %.1f, %i\n",touchX,(int)[currentTouchesX_ML count]);
            }
        }
        
        //vr button tap
        if (touchStateVRButton == 0 && cutSceneActive == 0) {
            float calcVar1 = sqrtf(powf(touchX-vrButtonTouchPosX,2)+powf(touchY-vrButtonTouchPosY,2));
            if (calcVar1 < vrButtonRadius) {
                for (CCSprite *sprite in menuItemArray) {
                    menuItem *currentItem = (menuItem *)sprite;
                    if (currentItem.itemid == 5) {
                        currentItem.itemtappedinitially = 1;
                    }
                }
                touchStateVRButton = 1;
                touchCheck1 = 1;
                vrButtonTouchIndex = touchIndex;
                //printf("VR BUTTON TOUCH STARTED: %.1f, %i\n",touchX,(int)[currentTouchesX_ML count]);
            }
        }
        
        //action tap
        if (touchStateAction == 0 && cutSceneActive == 0) {
            float calcVar1 = sqrtf(powf(touchX-actionPosX,2)+powf(touchY-actionPosY,2));
            if (inventoryMode == 0 && calcVar1 < actionButtonRadius) {
                for (CCSprite *sprite in menuItemArray) {
                    menuItem *currentItem = (menuItem *)sprite;
                    if (currentItem.itemid == 2) {
                        currentItem.itemtappedinitially = 1;
                    }
                }
                actionTouchIndex = touchIndex;
                touchStateAction = 1;
                touchCheck1 = 1;
                //printf("ACTION TOUCH STARTED: %.1f\n",touchX);
            } else {
                float hypot1 = (sqrtf(powf(touchX-inventorySliderPosX, 2) + powf(touchY-inventorySliderPosY, 2)));
                if (hypot1 < actionButtonRadius) { //starts punch
                    for (CCSprite *sprite in menuItemArray) {
                        menuItem *currentItem = (menuItem *)sprite;
                        if (currentItem.itemid == 2) {
                            currentItem.itemtappedinitially = 1;
                        }
                    }
                    touchStateAction = 1;
                    touchCheck1 = 1;
                    actionTouchIndex = touchIndex;
                    //printf("ACTION (punch) TOUCH STARTED: %.1f\n",touchX);
                } else if (hypot1 < actionButtonBGRadius) { //starts inventory drag
                    touchCheck1 = 1;
                    touchStateAction = 2;
                    actionTouchIndex = touchIndex;
                    
                    //printf("ACTION (drag) TOUCH STARTED: %.1f\n",touchX);
                    
                    //get angle offset
                    float preNearestDistance = (sqrtf(powf(touchX-inventorySliderPosX, 2) + powf(touchY-inventorySliderPosY, 2)));
                    float angle1 = acosf((inventorySliderPosX-touchX)/preNearestDistance); //left = 0, right = 180
                    float angle2 = asinf((inventorySliderPosY-touchY)/preNearestDistance); //top = -90, bottom = 90
                    
                    if (angle1 < 1.570796) {
                        if (angle2 < 0) { //bottom left
                            inventoryAngleOffset = -angle1;
                        } else { //top left
                            inventoryAngleOffset = angle1;
                        }
                    } else {
                        if (angle2 < 0) { //bottom right
                            inventoryAngleOffset = -angle1;
                        } else { //top right
                            inventoryAngleOffset = angle1;
                        }
                    }
                }
            }
        }
        
        //LDGD tap
        if (touchCheck1 == 0 && touchLDGDMain == -1 && cutSceneActive == 0) {
            if (touchY > winSize.height*1/8 && touchY < winSize.height*7/8 && touchX >= winSize.width*0.28 && touchX <= winSize.width*0.72) {
                
                if (objectBeingHighlightedML == 0 && grabbedObjectML == 0) {
                    touchLDGDMain = 2;
                } else if (objectBeingHighlightedML != 0 && grabbedObjectML == 0) {
                    touchLDGDMain = 1;
                } else if (grabbedObjectML != 0) {
                    touchLDGDMain = 3;
                }
            } else {
                touchLDGDMain = 2;
            }
            touchLDGDtapx = touchX*(1334.0/actualwinSize.width);
            touchLDGDtapy = touchY*(750.0/actualwinSize.height);
            touchLDGDtapxorigin = touchLDGDtapx;
            touchLDGDtapyorigin = touchLDGDtapy;
            LDGDTouchIndex = touchIndex;
        }
    } else { //safety reset
        
    }
}

- (void)touchMovedCustom:(NSMutableArray *)activeTouchesX :(NSMutableArray *)activeTouchesY :(int)touchIndex {
    if ((int)[activeTouchesX count] > 0) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        currentTouchesX_ML = activeTouchesX;
        currentTouchesY_ML = activeTouchesY;
        
        if (cutSceneActive == 0) {
            if (touchStateJoystick != 0) { //joystick
                float touchX = [[currentTouchesX_ML objectAtIndex:joystickTouchIndex] floatValue];
                float touchY = winSize.height-[[currentTouchesY_ML objectAtIndex:joystickTouchIndex] floatValue];
                
                float touchRadius = sqrtf(powf(touchX-joystickPosX, 2) + powf(touchY-joystickPosY, 2));
                
                //printf("JOYSTICK TOUCH MOVED: %i\n",(int)[currentTouchesX_ML count]);
                
                if (touchRadius < joystickRadius) {
                    joystickTouchPosX = touchX;
                    joystickTouchPosY = touchY;
                } else {
                    //gets sin&cos (angle) to touch
                    float var1 = asinf((touchY-joystickPosY)/(sqrtf(powf(touchX-joystickPosX, 2) + powf(touchY-joystickPosY, 2)))); //negative = down, positive = up
                    float var2 = asinf((touchX-joystickPosX)/(sqrtf(powf(touchX-joystickPosX, 2) + powf(touchY-joystickPosY, 2)))); //negative = left, positive = right
                                                                                                                                    //applies vars to new position
                    if (var2 >= 0) {
                        joystickTouchPosX = (cosf(var1)*joystickRadius)+joystickPosX;
                        joystickTouchPosY = (sinf(var1)*joystickRadius)+joystickPosY;
                    } else if (var2 < 0) {
                        joystickTouchPosX = -(cosf(var1)*joystickRadius)+joystickPosX;
                        joystickTouchPosY = (sinf(var1)*joystickRadius)+joystickPosY;
                    }
                }
            }
            
            if (touchStateJump != 0) { //jump
                float touchX = [[currentTouchesX_ML objectAtIndex:jumpTouchIndex] floatValue];
                float touchY = winSize.height-[[currentTouchesY_ML objectAtIndex:jumpTouchIndex] floatValue];
                
                float touchRadius = sqrtf(powf(touchX-jumpPosX, 2) + powf(touchY-jumpPosY, 2));
                
                //printf("JUMP TOUCH MOVED: %i\n",(int)[currentTouchesX_ML count]);
                
                if (touchRadius <= jumpButtonRadius) {
                    for (CCSprite *sprite in menuItemArray) {
                        menuItem *currentItem = (menuItem *)sprite;
                        if (currentItem.itemid == 3 && currentItem.itemtappedinitially != 1) {
                            currentItem.itemtappedinitially = 1;
                        }
                    }
                } else {
                    for (CCSprite *sprite in menuItemArray) {
                        menuItem *currentItem = (menuItem *)sprite;
                        if (currentItem.itemid == 3 && currentItem.itemtappedinitially != 0) {
                            currentItem.itemtappedinitially = 0;
                        }
                    }
                }
            }
            
            if (touchStateVRButton != 0) { //vr button
                float touchX = [[currentTouchesX_ML objectAtIndex:vrButtonTouchIndex] floatValue];
                float touchY = winSize.height-[[currentTouchesY_ML objectAtIndex:vrButtonTouchIndex] floatValue];
                
                float touchRadius = sqrtf(powf(touchX-vrButtonTouchPosX, 2) + powf(touchY-vrButtonTouchPosY, 2));
                
                if (touchRadius <= vrButtonRadius) {
                    for (CCSprite *sprite in menuItemArray) {
                        menuItem *currentItem = (menuItem *)sprite;
                        if (currentItem.itemid == 5 && currentItem.itemtappedinitially != 1) {
                            currentItem.itemtappedinitially = 1;
                        }
                    }
                } else {
                    for (CCSprite *sprite in menuItemArray) {
                        menuItem *currentItem = (menuItem *)sprite;
                        if (currentItem.itemid == 5 && currentItem.itemtappedinitially != 0) {
                            currentItem.itemtappedinitially = 0;
                        }
                    }
                }
            }
            
            if (touchStateAction != 0) { //action
                float touchX = [[currentTouchesX_ML objectAtIndex:actionTouchIndex] floatValue];
                float touchY = winSize.height-[[currentTouchesY_ML objectAtIndex:actionTouchIndex] floatValue];
                
                float touchRadius = sqrtf(powf(touchX-actionPosX, 2) + powf(touchY-actionPosY, 2));
                
                if (touchStateAction == 1) { //normal action button
                    if (touchRadius <= actionButtonRadius) {
                        for (CCSprite *sprite in menuItemArray) {
                            menuItem *currentItem = (menuItem *)sprite;
                            if (currentItem.itemid == 2 && currentItem.itemtappedinitially != 1) {
                                currentItem.itemtappedinitially = 1;
                            }
                        }
                    } else {
                        for (CCSprite *sprite in menuItemArray) {
                            menuItem *currentItem = (menuItem *)sprite;
                            if (currentItem.itemid == 2 && currentItem.itemtappedinitially != 0) {
                                currentItem.itemtappedinitially = 0;
                            }
                        }
                    }
                } else if (touchStateAction == 2 && inventoryMode == 1) { //inventory drag
                    //uses closest touch
                    float angle1 = acosf((inventorySliderPosX-touchX)/touchRadius); //left = 0, right = 180
                    float angle2 = asinf((inventorySliderPosY-touchY)/touchRadius); //top = -90, bottom = 90
                    
                    if (angle1 < 1.570796) {
                        if (angle2 < 0) { //bottom left
                            inventoryAngle = -angle1-inventoryAngleOffset;
                        } else { //top left
                            inventoryAngle = angle1-inventoryAngleOffset;
                        }
                    } else {
                        if (angle2 < 0) { //bottom right
                            inventoryAngle = -angle1-inventoryAngleOffset;
                        } else { //top right
                            inventoryAngle = angle1-inventoryAngleOffset;
                        }
                    }
                    //printf("ANGLE: %.2f, %.2f, %.2f\n",CC_RADIANS_TO_DEGREES(inventoryAngle),CC_RADIANS_TO_DEGREES(angle1),CC_RADIANS_TO_DEGREES(angle2));
                }
            }
            
            //LDGD tap (look around OR grabbed object)
            if (LDGDTouchIndex == touchIndex && touchLDGDMain != 0 && touchLDGDMain != 1) {
                float touchX = [[currentTouchesX_ML objectAtIndex:LDGDTouchIndex] floatValue];
                float touchY = winSize.height-[[currentTouchesY_ML objectAtIndex:LDGDTouchIndex] floatValue];
                
                HelloWorldLayer2 * hwLayer = (HelloWorldLayer2 *)[self.parent getChildByName:@"hwLayer2" recursively:1];
                CGSize actualwinSize = [[CCDirector sharedDirector] viewSizeInPixels];
                
                //uses closest touch
                if (touchLDGDMain == 2) { //look around
                    touchLDGDtapx = touchX*(1334.0/actualwinSize.width);
                    touchLDGDtapy = touchY*(750.0/actualwinSize.height);
                    [hwLayer lookDirection:(touchLDGDtapx-touchLDGDtapxorigin) :(touchLDGDtapy-touchLDGDtapyorigin)];
                } else if (touchLDGDMain == 3) { //monitor swipe and/or lead to object drop
                    touchLDGDtapx = touchX*(1334.0/actualwinSize.width);
                    touchLDGDtapy = touchY*(750.0/actualwinSize.height);
                    
                    //drop object boundaries
                    if (touchLDGDtapx < touchLDGDtapxorigin-8 || touchLDGDtapx > touchLDGDtapxorigin+8 || touchLDGDtapy < touchLDGDtapyorigin-11 || touchLDGDtapy > touchLDGDtapyorigin+11) {
                        touchLDGDMain = 4;
                    }
                } else if (touchLDGDMain == 4) { //swipe object
                    touchLDGDtapx = touchX*(1334.0/actualwinSize.width);
                    touchLDGDtapy = touchY*(750.0/actualwinSize.height);
                    [hwLayer draggrabbedObject:touchLDGDtapxorigin :touchLDGDtapx];
                }
            } else if (LDGDTouchIndex == touchIndex && touchLDGDMain == 1) {
                float touchX = [[currentTouchesX_ML objectAtIndex:LDGDTouchIndex] floatValue];
                float touchY = winSize.height-[[currentTouchesY_ML objectAtIndex:LDGDTouchIndex] floatValue];
                
                float touchRadius = sqrtf(powf(touchX-touchLDGDtapxorigin, 2) + powf(touchY-touchLDGDtapyorigin, 2));
                
                //cancels potential grab if touch wanders too far from initial touch
                if (touchRadius >= 22) {
                    touchLDGDMain = 2;
                }
            }
        }
    } else { //safety reset
        
    }
}

- (void)touchEndedCustom:(NSMutableArray *)activeTouchesX :(NSMutableArray *)activeTouchesY :(int)touchIndex {
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    if (touchIndex == joystickTouchIndex && touchStateJoystick != 0) { //joystick
        joystickTouchIndex = 0;
        touchStateJoystick = 0;
        joystickTouchPosX = joystickPosX;
        joystickTouchPosY = joystickPosY;
        
        HelloWorldLayer2 * hwLayer = (HelloWorldLayer2 *)[self.parent getChildByName:@"hwLayer2" recursively:1];
        [hwLayer moveXposition:0];
        [hwLayer moveZposition:0];
        
        //printf("JOYSTICK TOUCH ENDED: %i\n",(int)[currentTouchesX_ML count]);
    }
    
    //jump tap
    if (touchIndex == jumpTouchIndex && touchStateJump != 0) {
        for (CCSprite *sprite in menuItemArray) {
            menuItem *currentItem = (menuItem *)sprite;
            if (currentItem.itemid == 3) {
                currentItem.itemtappedinitially = 0;
            }
        }
        jumpTouchIndex = 0;
        touchStateJump = 0;
        
        //printf("JUMP TOUCH ENDED: %i\n",(int)[currentTouchesX_ML count]);
    }
    
    //vr button tap
    if (touchIndex == vrButtonTouchIndex && touchStateVRButton != 0) {
        for (CCSprite *sprite in menuItemArray) {
            menuItem *currentItem = (menuItem *)sprite;
            if (currentItem.itemid == 5) {
                currentItem.itemtappedinitially = 0;
            }
        }
        jumpTouchIndex = 0;
        touchStateJump = 0;
        
        //printf("VR BUTTON TOUCH ENDED: %i\n",(int)[currentTouchesX_ML count]);
        
        HelloWorldLayer2 * hwLayer = (HelloWorldLayer2 *)[self.parent getChildByName:@"hwLayer2" recursively:1];
        [hwLayer doPlayerAction:6];
    }
    
    //action tap
    if (touchIndex == actionTouchIndex && touchStateAction != 0) {
        if (touchStateAction == 1) {
            for (CCSprite *sprite in menuItemArray) {
                menuItem *currentItem = (menuItem *)sprite;
                if (currentItem.itemid == 2) {
                    currentItem.itemtappedinitially = 0;
                }
            }
            touchStateAction = 0;
        } else if (touchStateAction == 2) {
            inventoryAngleSaved = inventoryAngleSaved + inventoryAngle;
            inventoryAngle = 0;
            if (inventoryAngleSaved < 0) {
                inventoryAngleSaved = inventoryAngleSaved + (3.141592653*2);
            } else if (inventoryAngleSaved > (3.141592653*2)) {
                inventoryAngleSaved = inventoryAngleSaved - (3.141592653*2);
            }
            touchStateAction = 0;
        }
    }
    
    //ldgd tap/drag
    if (LDGDTouchIndex == touchIndex && touchLDGDMain != -1) {
        HelloWorldLayer2 * hwLayer = (HelloWorldLayer2 *)[self.parent getChildByName:@"hwLayer2" recursively:1];
        float touchX = [[currentTouchesX_ML objectAtIndex:LDGDTouchIndex] floatValue];
        float touchY = winSize.height-[[currentTouchesY_ML objectAtIndex:LDGDTouchIndex] floatValue];
        
        if (touchLDGDMain == 2) { //cancels look around
            [hwLayer lookStop];
        } else if (touchLDGDMain == 3 && touchY > winSize.height*1/8 && touchY < winSize.height*7/8 && touchX >= winSize.width*0.28 && touchX <= winSize.width*0.72) { //drops object
            [hwLayer dropgrabObject:touchLDGDtapx :touchLDGDtapy];
            grabbedObjectML = 0;
        } else if (touchLDGDMain == 4) { //stops object drag
            [hwLayer stopdraggrabbedObject];
        } else if (touchLDGDMain == 1 && touchY > winSize.height*1/8 && touchY < winSize.height*7/8 && touchX >= winSize.width*0.28 && touchX <= winSize.width*0.72) { //grabs object
            [hwLayer dropgrabObject:touchLDGDtapx :touchLDGDtapy];
            grabbedObjectML = 1;
        }
        touchLDGDMain = -1;
    }
    
    currentTouchesX_ML = activeTouchesX;
    currentTouchesY_ML = activeTouchesY;
    if (jumpTouchIndex > touchIndex) {
        jumpTouchIndex--;
    }
    if (joystickTouchIndex > touchIndex) {
        joystickTouchIndex--;
    }
    if (actionTouchIndex > touchIndex) {
        actionTouchIndex--;
    }
    if (LDGDTouchIndex > touchIndex) {
        LDGDTouchIndex--;
    }
}

- (void)reciprocatePlayerAction {
    if (inventoryMode == 1) {
        for (CCSprite *sprite in iovArray) {
            inventoryObject *currentIVO = (inventoryObject *)sprite;
            if (currentIVO.IVOAddedToInventory == 1 && currentIVO.IVObeingdeleted == 0 && currentInventorySlot == currentIVO.IVOslotid-2) {
                //uses and wastable items
                if (currentIVO.IVOwastable != 0) {
                    currentIVO.IVOuses--;
                    if (currentIVO.IVOuses <= 0 && currentIVO.IVOwastable == 1) {
                        currentIVO.IVObeingdeleted = 1;
                    }
                }
            }
        }
    }
}

- (void)setDialogText:(NSString *)textString {
    savedDialogText = textString;
    if (dialogText1present == 1) {
        dialogText1.string = textString;
    }
    dialogVisible = 1;
    
    if ([textString isEqualToString:@""]) {
        dialogVisible = 0;
    }
}

- (void)getAIInformation:(float)targetDistance :(float)playerPosY {
    currentTargetDistance = targetDistance;
    currentPlayerPosY = playerPosY;
}

- (void)act {
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    menuItemRemovalArray = [[NSMutableArray alloc] init];
    iovRemovalArray = [[NSMutableArray alloc] init];
    HelloWorldLayer2 * hwLayer = (HelloWorldLayer2 *)[self.parent getChildByName:@"hwLayer2" recursively:1];
    
    //cutscene system
    if (cutSceneActive != cutSceneActiveRefresh) {
        cutSceneActiveRefresh = cutSceneActive;
        
        if (cutSceneActive == 1) { //turn on cutscene mode
            
            //resets variables in helloWorldLayer
            HelloWorldLayer2 * hwLayer = (HelloWorldLayer2 *)[self.parent getChildByName:@"hwLayer2" recursively:1];
            [hwLayer stopdraggrabbedObject];
            [hwLayer lookStop];
            [hwLayer moveXposition:0];
            [hwLayer moveYposition:0];
            [hwLayer moveZposition:0];
            
            if (cinemaBar1exists == 0) {
                cinemaBar1exists = 1;
                cinemaBar1 = [CCSprite spriteWithImageNamed:@"blackbar.png"];
                if (iPadVar != 1) {
                    cinemaBar1.scale = 11.0*iPhone6PlusScaleOffset;
                } else {
                    cinemaBar1.scale = 5.5*iPhone6PlusScaleOffset;
                }
                cinemaBar1.position = ccp(winSize.width/2, (winSize.height+2+(cinemaBar1.contentSize.height*cinemaBar1.scale/2.0)));
                cinemaBar1posy = cinemaBar1.position.y;
                [self addChild:cinemaBar1];
                [cinemaBar1 setZOrder:7];
            }
            
            if (cinemaBar2exists == 0) {
                cinemaBar2exists = 1;
                cinemaBar2 = [CCSprite spriteWithImageNamed:@"blackbar.png"];
                if (iPadVar != 1) {
                    cinemaBar2.scale = 11.0*iPhone6PlusScaleOffset;
                } else {
                    cinemaBar2.scale = 5.5*iPhone6PlusScaleOffset;
                }
                cinemaBar2.position = ccp(winSize.width/2, (0-2-(cinemaBar2.contentSize.height*cinemaBar2.scale/2.0)));
                cinemaBar2posy = cinemaBar2.position.y;
                [self addChild:cinemaBar2];
                [cinemaBar2 setZOrder:7];
            }
        }
        
        //updates hwl instances
        HelloWorldLayer2 * hwLayer = (HelloWorldLayer2 *)[self.parent getChildByName:@"hwLayer2" recursively:1];
        [hwLayer setCutsceneActiveHWL:cutSceneActive];
    }
    if (cutSceneActive == 1) {
        //cinema bar positions
        if (iPadVar != 1) {
            if (cinemaBar1exists == 1) {
                cinemaBar1posy = cinemaBar1posy + ((430+(winSize.height-(cinemaBar1.contentSize.height*cinemaBar1.scale/2.0)) - cinemaBar1posy)/15.0);
                cinemaBar1.position = ccp(winSize.width/2,cinemaBar1posy);
            }
            if (cinemaBar2exists == 1) {
                cinemaBar2posy = cinemaBar2posy + (((-430+(cinemaBar2.contentSize.height*cinemaBar2.scale/2.0)) - cinemaBar2posy)/15.0);
                cinemaBar2.position = ccp(winSize.width/2,cinemaBar2posy);
            }
        } else {
            if (cinemaBar1exists == 1) {
                cinemaBar1posy = cinemaBar1posy + ((226+(winSize.height-(cinemaBar1.contentSize.height*cinemaBar1.scale/2.0)) - cinemaBar1posy)/15.0);
                cinemaBar1.position = ccp(winSize.width/2,cinemaBar1posy);
            }
            if (cinemaBar2exists == 1) {
                cinemaBar2posy = cinemaBar2posy + (((-226+(cinemaBar2.contentSize.height*cinemaBar2.scale/2.0)) - cinemaBar2posy)/15.0);
                cinemaBar2.position = ccp(winSize.width/2,cinemaBar2posy);
            }
        }
        
        //cutscene dilation var
        cutSceneOpacityCoefficient = cutSceneOpacityCoefficient + ((0.0 - cutSceneOpacityCoefficient)/15.0);
    } else if (cutSceneActive == 0) {
        //cinema bar positions
        if (cinemaBar1exists == 1) {
            cinemaBar1posy = cinemaBar1posy + (((winSize.height+2+(cinemaBar1.contentSize.height*cinemaBar1.scale/2.0)) - cinemaBar1posy)/15.0);
            cinemaBar1.position = ccp(winSize.width/2,cinemaBar1posy);
            
            if (cinemaBar1posy > (winSize.height+(cinemaBar1.contentSize.height*cinemaBar1.scale/2.0))) {
                [self removeChild:cinemaBar1 cleanup:YES];
                cinemaBar1exists = 0;
            }
        }
        if (cinemaBar2exists == 1) {
            cinemaBar2posy = cinemaBar2posy + (((0-2-(cinemaBar2.contentSize.height*cinemaBar2.scale/2.0)) - cinemaBar2posy)/15.0);
            cinemaBar2.position = ccp(winSize.width/2,cinemaBar2posy);
            
            if (cinemaBar2posy < (0-(cinemaBar2.contentSize.height*cinemaBar2.scale/2.0))) {
                [self removeChild:cinemaBar2 cleanup:YES];
                cinemaBar2exists = 0;
            }
        }
        
        //cutscene dilation var
        cutSceneOpacityCoefficient = cutSceneOpacityCoefficient + ((1.0 - cutSceneOpacityCoefficient)/15.0);
    }
    
    //dialog system
    if (dialogVisible == 0) {
        dialogText1y = dialogText1y + (((30.0)-dialogText1y)/10.0);
        
        if (dialogText1present == 1) {
            dialogText1.position = ccp(winSize.width/2, winSize.height+dialogText1y);
            
            if (dialogText1y > 29.0) {
                [self removeChild:dialogText1 cleanup:YES];
                dialogText1present = 0;
            }
        }
    } else if (dialogVisible == 1) {
        float dtdesty = -22.5;
        if (iPadVar != 1) {
            dtdesty = -56.5;
        }
        dialogText1y = dialogText1y + ((dtdesty-dialogText1y)/10.0);
        
        if (dialogText1present == 0) { //creates text if needed
            dialogText1present = 1;
            
            dialogText1 = [CCLabelTTF labelWithString:@"ERROR" fontName:@"ArialRoundedMTBold" fontSize:14.0];
            dialogText1.position = ccp(winSize.width/2, winSize.height+dialogText1y);
            if (![savedDialogText isEqualToString:@""] && savedDialogText != NULL) {
                dialogText1.string = savedDialogText;
            }
            [self addChild:dialogText1];
            [dialogText1 setColor:[CCColor colorWithCcColor3b:ccc3(255, 255, 255)]];
            [dialogText1 setZOrder:70];
            if (iPadVar != 1) {
                [dialogText1 setFontSize:22.0];
            }
        } else {
            dialogText1.position = ccp(winSize.width/2, winSize.height+dialogText1y);
        }
    }
    
    //inventory drag snap
    if (inventoryMode == 1) {
        currentInventorySlot = (inventoryAngle+inventoryAngleSaved+(3.1415926/10))/(3.1415926/5);
        if (touchStateAction != 2) {
            //automatically simplifies inventoryAngleSaved
            if (touchStateAction != 3) {
                int int1 = inventoryAngle/3.141592653;
                if (int1 < 0) {
                    inventoryAngleSaved = inventoryAngleSaved + 3.141592653;
                } else if (int1 > 1) {
                    inventoryAngleSaved = inventoryAngleSaved - 3.141592653;
                }
                currentInventorySlot = (inventoryAngle+inventoryAngleSaved+(3.1415926/10)+0.08)/(3.1415926/5);
            }
            
            //snap to
            float midpoint = (((3.1415926*2.0)+((3.1415926/5)*((float)objectsInInventory-2)))/2.0)-0.08;
            if (currentInventorySlot > (objectsInInventory-2) && currentInventorySlot < 10) {
                if (inventoryAngleSaved < midpoint) {
                    currentInventorySlot--;
                    if (touchStateAction == 3) {
                        touchStateAction = 0;
                    }
                } else if (inventoryAngleSaved >= midpoint) {
                    currentInventorySlot = 10;
                    if (touchStateAction != 3) {
                        touchStateAction = 3;
                    }
                }
            } else {
                if (touchStateAction == 2 || touchStateAction == 3) {
                    touchStateAction = 0;
                }
            }
            inventoryAngleSaved = inventoryAngleSaved + (((((float)currentInventorySlot*(3.141592653589793/5))-0.08) - inventoryAngleSaved)/5.0);
            //printf("%i, %.2f, %i, %2f\n",currentInventorySlot,inventoryAngleSaved+inventoryAngle,objectsInInventory,CC_RADIANS_TO_DEGREES(midpoint)/36);
            //printf("CURRENT SELECTED IVO: %i\n",currentInventorySlot);
        }
    }
    
    //inventory objects
    for (CCSprite *sprite in iovArray) {
        inventoryObject *currentIVO = (inventoryObject *)sprite;
        
        //adding IOVS (for the first time)
        if (currentIVO.IVOAddedToInventory == 0) {
            currentIVO.IVOAddedToInventory = 1;
            currentIVO.IVOslotid = objectsInInventory+1;
            currentIVO.IVOslotidposition = currentIVO.IVOslotid;
            currentIVO.IVOdilationVar1 = 0.0;
            objectsInInventory++;
            
            //ipad dilation
            if (iPadVar != 1) {
                currentIVO.IVOradius = currentIVO.IVOradius * 1.42;
            }
        }
        
        //starting (& ending) dilation
        if (currentIVO.IVOdilationVar1 < 0.985 && currentIVO.IVObeingdeleted == 0 && currentIVO.IVOAddedToInventory == 1) {
            currentIVO.IVOdilationVar1 = currentIVO.IVOdilationVar1 + ((1.0 - currentIVO.IVOdilationVar1)/7.0);
        } else if (currentIVO.IVOdilationVar1 >= 0.985 && currentIVO.IVOdilationVar1 != 1.0 && currentIVO.IVObeingdeleted == 0 && currentIVO.IVOAddedToInventory == 1) {
            currentIVO.IVOdilationVar1 = 1.0;
        } else if (currentIVO.IVObeingdeleted == 1 && currentIVO.IVOAddedToInventory == 1) {
            currentIVO.IVOdilationVar1 = currentIVO.IVOdilationVar1 + ((0.0 - currentIVO.IVOdilationVar1)/7.0);
            
            //deleting IVOs
            if (currentIVO.IVOdilationVar1 < 0.06) {
                [iovRemovalArray addObject:currentIVO];
                objectsInInventory--;
                for (CCSprite *sprite in iovArray) {
                    inventoryObject *otherIVO = (inventoryObject *)sprite;
                    if (otherIVO.IVOslotid >= currentIVO.IVOslotid) {
                        otherIVO.IVOslotid--;
                    }
                }
            }
        }
        
        //rotation
        float angle1 = acosf((inventorySliderPosX-currentIVO.position.x)/(currentIVO.IVOradius+currentIVO.IVOdilationVar2)); //left = 0, right = 180
        float angle2 = asinf((inventorySliderPosY-currentIVO.position.y)/(currentIVO.IVOradius+currentIVO.IVOdilationVar2)); //top = -90, bottom = 90
        float angle3 = 0;
        if (angle1 < 1.570796) {
            if (angle2 < 0) { //bottom left
                angle3 = angle1;
            } else { //top left
                angle3 = -angle1;
            }
        } else {
            if (angle2 < 0) { //bottom right
                angle3 = angle1;
            } else { //top right
                angle3 = -angle1;
            }
        }
        currentIVO.rotation = CC_RADIANS_TO_DEGREES(angle3)-90;
        
        float dilationVar = 1.0;
        if (angle3 < 0.791) {
            dilationVar = (angle3+0.4)/(0.791+0.4);
        } else if (angle3 >= 0.791) {
            dilationVar = ((0.791-(angle3-0.791))+1.5)/(0.791+1.5);
        }
        float dilationVar2 = 1.0;
        if (dilationVar > 0.25) {
            dilationVar2 = dilationVar;
        } else {
            dilationVar2 = 0.25;
        }
        float dilationVar3 = 1.0;
        if (dilationVar > 0.83) {
            dilationVar3 = dilationVar;
        } else {
            dilationVar3 = 0.83;
        }
        
        //slot id slide
        if (currentIVO.IVOslotidposition != currentIVO.IVOslotid) {
            currentIVO.IVOslotidposition = currentIVO.IVOslotidposition + (((float)currentIVO.IVOslotid - currentIVO.IVOslotidposition)/4.0);
        }
        
        //position (10 spots max)
        currentIVO.position = ccp((cosf((inventoryAngle+inventoryAngleSaved)+3.058+((3.141592653589793/5)*-(currentIVO.IVOslotidposition-1.0)))*(currentIVO.IVOradius+currentIVO.IVOdilationVar2))+inventorySliderPosX,(sinf((inventoryAngle+inventoryAngleSaved)+3.058+((3.141592653589793/5)*-(currentIVO.IVOslotidposition-1.0)))*(currentIVO.IVOradius+currentIVO.IVOdilationVar2))+inventorySliderPosY);
        
        //opacity
        if (inventoryMode == 1) {
            currentIVO.IVOopacity = currentIVO.IVOinitialopacity*dilationVar2*currentIVO.IVOdilationVar1;
            currentIVO.opacity = (currentIVO.IVOopacity*cutSceneOpacityCoefficient)/255.0;
        } else {
            currentIVO.IVOopacity = 0;
            currentIVO.opacity = (currentIVO.IVOopacity*cutSceneOpacityCoefficient)/255.0;
        }
        
        //scale
        currentIVO.IVOscale = currentIVO.IVOinitialscale*dilationVar3*currentIVO.IVOdilationVar1;
        if (iPadVar != 1) {
            currentIVO.scale = currentIVO.IVOscale*1.35*iPhone6PlusScaleOffset;
        } else {
            currentIVO.scale = currentIVO.IVOscale*iPhone6PlusScaleOffset;
        }
    }
    
    //menuItems
    for (CCSprite *sprite in menuItemArray) {
        menuItem *currentItem = (menuItem *)sprite;
        
        //automatically finds initial scale
        if (currentItem.iteminitialscale == 0 && currentItem.scale != 0.0) {
            currentItem.iteminitialscale = currentItem.scale;
            currentItem.itemscale = currentItem.scale;
            if (currentItem.itemScaleOffset == 0) {
                currentItem.itemScaleOffset = 1.0;
            }
        }
        
        //joystick controls
        if (currentItem.itemid == 1) {
            currentItem.itemposX = joystickTouchPosX - currentItem.itemPosXOffset;
            currentItem.itemposY = joystickTouchPosY - currentItem.itemPosYOffset;
            
            //gets angle & sends motion
            if (touchStateJoystick != 0 && cutSceneActive == 0) {
                //gets sin&cos (angle) to touch
                float var1 = asinf((currentItem.position.y-joystickPosY)/(sqrtf(powf(currentItem.position.x-joystickPosX, 2) + powf(currentItem.position.y-joystickPosY, 2)))); //negative = down, positive = up
                float var2 = asinf((currentItem.position.x-joystickPosX)/(sqrtf(powf(currentItem.position.x-joystickPosX, 2) + powf(currentItem.position.y-joystickPosY, 2)))); //negative = left, positive = right
                float var3 = (sqrtf(powf(currentItem.position.x-joystickPosX, 2) + powf(currentItem.position.y-joystickPosY, 2)));
                //determines what direction to go
                if (var2 >= 0) {
                    [hwLayer moveXposition:(cosf(var1)*var3*3.5)/joystickRadius];
                    [hwLayer moveZposition:(sinf(var1)*var3*3.5)/joystickRadius];
                } else if (var2 < 0) {
                    [hwLayer moveXposition:-(cosf(var1)*var3*3.5)/joystickRadius];
                    [hwLayer moveZposition:(sinf(var1)*var3*3.5)/joystickRadius];
                }
            }
        }
        
        //jump button
        if (currentItem.itemid == 3) {
            
            //opacity
            if (currentItem.itemtappedinitially == 1) {
                currentItem.itemopacity = 80.0/255.0;
                
                [hwLayer moveYposition:1];
            } else if (currentItem.itemtappedinitially == 0 && currentItem.itemopacity != 160.0/255.0) {
                currentItem.itemopacity = 160.0/255.0;
                
                [hwLayer moveYposition:0];
            }
        }
        
        //vr button
        if (currentItem.itemid == 5) {
            //opacity
            if (currentItem.itemtappedinitially == 1) {
                currentItem.itemopacity = 80.0/255.0;
            } else if (currentItem.itemtappedinitially == 0 && currentItem.itemopacity != 160.0/255.0) {
                currentItem.itemopacity = 160.0/255.0;
            }
        }
        
        //action button
        if (currentItem.itemid == 2) {
            //opacity
            if (currentItem.itemtappedinitially == 1 && touchStateAction != 2 && touchStateAction != 3) {
                currentItem.itemopacity = 80.0/255.0;
                
                //readjusts currentInventorySlot (if needed)
                if (currentInventorySlot >= 10) {
                    currentInventorySlot = currentInventorySlot-10;
                }
                
                //action
                if (inventoryMode == 1) {
                    for (CCSprite *sprite in iovArray) {
                        inventoryObject *currentIVO = (inventoryObject *)sprite;
                        if (currentIVO.IVOAddedToInventory == 1 && currentIVO.IVObeingdeleted == 0 && currentInventorySlot == currentIVO.IVOslotid-2) {
                            if (currentIVO.IVOwastable == 2 && currentIVO.IVOuses > 0) {
                                [hwLayer doPlayerAction:currentIVO.IVOactionid]; //action depends on type of IVO
                            } else if (currentIVO.IVOwastable == 0 || currentIVO.IVOwastable == 1) {
                                [hwLayer doPlayerAction:currentIVO.IVOactionid]; //action depends on type of IVO
                            }
                        }
                    }
                } else {
                    [hwLayer doPlayerAction:0];
                }
            } else if (currentItem.itemtappedinitially == 0 && currentItem.itemopacity != 160.0/255.0) {
                currentItem.itemopacity = 160.0/255.0;
            }
        }
        
        //position
        currentItem.position = ccp(currentItem.itemposX+currentItem.itemPosXOffset,currentItem.itemposY+currentItem.itemPosYOffset);
        
        //opacity
        currentItem.opacity = currentItem.itemopacity*cutSceneOpacityCoefficient;
        
        //scale
        currentItem.scale = currentItem.iteminitialscale*currentItem.itemScaleOffset*iPhone6PlusScaleOffset;
    }
    
    //delete menuitems
    for (CCSprite *sprite in menuItemRemovalArray) {
        [menuItemArray removeObject:sprite];
        [self removeChild:sprite cleanup:YES];
    }
    menuItemRemovalArray = nil;
    
    //delete iovs
    for (CCSprite *sprite in iovRemovalArray) {
        [iovArray removeObject:sprite];
        [self removeChild:sprite cleanup:YES];
    }
    iovRemovalArray = nil;
}

- (void)getGrabbableObjectPossibility:(int)possible {
    if (possible == 0) {
        printf("no grabbable object available, switching to view drag mode\n");
        touchLDGDMain = 2;
    } else if (possible == 1) {
        printf("grabbable object available\n");
        touchLDGDMain = 1;
    } else if (possible == 2) {
        printf("already grabbed object, switching to object drag mode\n");
        touchLDGDMain = 3;
    }
}

- (id)init
{
    if( (self=[super init] )) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        menuItemArray = [[NSMutableArray alloc]init ];
        iovArray = [[NSMutableArray alloc]init ];
        touchLDGDMain = -1;
        dialogVisible = 0;
        iPadVar = 1; //not ipad
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
                CGSize result = [[UIScreen mainScreen] bounds].size;
                CGFloat scale = [UIScreen mainScreen].scale;
                result = CGSizeMake(result.width * scale,result.height * scale);
                if(result.height == 1136 || result.width == 1136){
                    iPhone5Var = 1;
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                        iPhone5Var = 1;
                    }
                }
            }
        }
        float iPadbuttonoffset1 = 0;
        float iPadbuttonoffset2 = 0;
        float iPadbuttonoffset3 = 0; //y
        float iPadbuttonoffset4 = 0; //x
        float retinaoffset1 = 0;
        float retinaoffset2 = 0;
        float retinaoffset3 = 0;
        float retinaoffset4 = 0;
        inventoryMode = 0;
        //ipad & retina offsets
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            iPadVar = 2;//yes ipad
            iPadbuttonoffset1 = -52;
            iPadbuttonoffset2 = -140;
            iPadbuttonoffset3 = 15;
            iPadbuttonoffset4 = -15;
            retinaoffset1 = 0;
            retinaoffset2 = 0;
            retinaoffset3 = 0;
        } else if (!iPhone5Var){
            retinaoffset1 = 14;
            retinaoffset2 = -9;
            retinaoffset3 = -20;
            retinaoffset4 = 22;
        }
        
        float iPhone6offsetX1 = 0;
        float iPhone6offsetY1 = 0;
        float iPhone6offsetX2 = 0;
        float iPhone6offsetY2 = 0;
        bool isiPhone6 = [self iPhone6Plus];
        if (iPadVar != 1) {
            isiPhone6 = 0;
            
        }
        if (isiPhone6 == 0) {
            iPhone6PlusScaleOffset = 2.0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
                if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
                    CGSize result = [[UIScreen mainScreen] bounds].size;
                    CGFloat scale = [UIScreen mainScreen].scale;
                    result = CGSizeMake(result.width * scale,result.height * scale);
                    if (result.height == 640){
                        iPhone6PlusScaleOffset = 2.0;
                    }
                }
            }
        } else {
            iPhone6PlusScaleOffset = 4.0;
        }
        if (isiPhone6 != 0 && inventoryMode == 1) {
            iPhone6offsetX1 = -39;
            iPhone6offsetY1 = -20;
            iPhone6offsetX2 = -19;
            iPhone6offsetY2 = -4;
        }
        
        currentTouchesX_ML = [[NSMutableArray alloc] init];
        currentTouchesY_ML = [[NSMutableArray alloc] init];
        
        //inventory mode variables
        objectsInInventory = 1; //MINIMUM = 1
        
        //initial objects
        if (iPadVar == 1) {
            menuItem *item4 = nil;
            item4 = [vrButton vrButtonItem];
            item4.itemScaleOffset = 1.0;
            item4.itemposX = 213;
            item4.itemposY = 48;
            item4.iteminitialposx = item4.itemposX;
            item4.iteminitialposy = item4.itemposY;
            vrButtonTouchPosX = item4.iteminitialposx;
            vrButtonTouchPosY = item4.iteminitialposy;
            vrButtonRadius = (item4.contentSize.width/2.0)*item4.itemScaleOffset*item4.scale*iPhone6PlusScaleOffset;
            [self addChild:item4];
            [menuItemArray addObject:item4];
        }
        
        menuItem *item1 = nil;
        item1 = [joystickbg joystickbgItem];
        //initial variables
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            joystickRadius = 109;
            item1.itemposX = (winSize.width*1.1/6)+retinaoffset1-45;
            item1.itemposY = (winSize.height*1.25/4)+iPadbuttonoffset1-45;
        } else {
            joystickRadius = 70;
            item1.itemposX = 102;
            item1.itemposY = 102;
        }
        item1.iteminitialposx = item1.itemposX;
        item1.iteminitialposy = item1.itemposY;
        joystickPosX = item1.itemposX;
        joystickPosY = item1.itemposY;
        joystickTouchPosX = joystickPosX;
        joystickTouchPosY = joystickPosY;
        [self addChild:item1];
        [menuItemArray addObject:item1];
        
        menuItem *item2 = nil;
        item2 = [joystick joystickItem];
        //initial variables
        item2.itemposX = 120;
        item2.itemposY = 120;
        item2.iteminitialposx = item2.itemposX;
        item2.iteminitialposy = item2.itemposY;
        [self addChild:item2];
        [menuItemArray addObject:item2];
        
        menuItem *item3 = nil;
        item3 = [action actionbuttonItem];
        //initial variables
        if (inventoryMode == 1) {
            item3.itemposX = (winSize.width)-75+iPadbuttonoffset4+retinaoffset4+iPhone6offsetX2;
            item3.itemposY = 75+iPadbuttonoffset3+iPhone6offsetY2;
            item3.itemScaleOffset = 1.1;
        } else {
            item3.itemScaleOffset = 1.0;
            item3.itemposX = winSize.width-62;
            item3.itemposY = 112;
            if (iPadVar != 1) {
                item3.itemposX = (winSize.width*5.4/6)+retinaoffset2+25;
                item3.itemposY = (winSize.height*1.5/4)+iPadbuttonoffset1-72;
            }
        }
        item3.iteminitialposx = item3.itemposX;
        item3.iteminitialposy = item3.itemposY;
        actionPosX = item3.iteminitialposx;
        actionPosY = item3.iteminitialposy;
        actionButtonRadius = (item3.contentSize.width/2.0)*item3.itemScaleOffset*item3.scale*1.08*iPhone6PlusScaleOffset;
        [self addChild:item3];
        [menuItemArray addObject:item3];
        
        menuItem *item4 = nil;
        item4 = [jump jumpbuttonItem];
        //initial variables
        if (inventoryMode == 1) {
            item4.itemposX = (winSize.width)-220+iPadbuttonoffset2+iPadbuttonoffset4+retinaoffset4+iPhone6offsetX2;
            item4.itemposY = 55+iPadbuttonoffset3+iPhone6offsetY2;
            item4.itemScaleOffset = 0.75;
            if (iPadVar != 1) {
                item4.itemposX = (winSize.width)-220+iPadbuttonoffset2+iPadbuttonoffset4+retinaoffset4+89;
                item4.itemposY = 55+iPadbuttonoffset3;
            }
        } else {
            item4.itemScaleOffset = 1.0;
            item4.itemposX = winSize.width-157;
            item4.itemposY = 61;
            if (iPadVar != 1) {
                item4.itemposX = (winSize.width*4.5/6)+retinaoffset3+72;
                item4.itemposY = (winSize.height*0.8/4)+iPadbuttonoffset1-25;
            }
        }
        item4.iteminitialposx = item4.itemposX;
        item4.iteminitialposy = item4.itemposY;
        jumpPosX = item4.iteminitialposx;
        jumpPosY = item4.iteminitialposy;
        jumpButtonRadius = (item4.contentSize.width/2.0)*item4.itemScaleOffset*item4.scale*1.08*iPhone6PlusScaleOffset;
        [self addChild:item4];
        [menuItemArray addObject:item4];
        
        [self schedule:@selector(act) interval:1.0/60.0];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appHasGoneInBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
	return self;
}

@end