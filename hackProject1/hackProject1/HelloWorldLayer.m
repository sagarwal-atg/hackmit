#import "AppDelegate.h"
#import "HelloWorldLayer.h"
#import "HelloWorldLayer2.h"
#import "CCCropNode.h"
#import "MenuLayer.h"
#import "Firebase.h"

@implementation HelloWorldLayer

- (void)generateNewLevel {
    //picking level
    levelTypeHWL = 2;
    
    [[NSUserDefaults standardUserDefaults] setInteger:levelTypeHWL forKey:@"levelType"];
    
    //terrain generation
    NSMutableArray *generatedObjects = [[NSMutableArray alloc] init];
    NSMutableArray *heatmapwradius = [[NSMutableArray alloc] init];
    
    //level-specific objects
    if (levelTypeHWL == 2) {
        //faded background shines
        for (int int1 = 0; int1 <= 70; int1++) {
            NSString *objectName0 = @"spaceEnv1";
            
            int randNumArc = arc4random() % 120;
            float var1 = (((float)randNumArc/120.0)*(2*3.1415926535897932));
            int randHypoCoeff = (arc4random() % 25) + 200;
            float randnumPosX = (cosf(var1)*((float)randHypoCoeff*1000.0));
            float randnumPosZ = (sinf(var1)*((float)randHypoCoeff*1000.0));
            int randYpos = (arc4random() % 101) - 50;
            float randnumPosY = (float)randYpos*200.0;
            int randSizeCoeff = (arc4random() % 71) + 10;
            
            int colorExposeRandom = arc4random() % 10;
            int colorExposeVar = 0;
            if (colorExposeRandom == 0 || colorExposeRandom == 1) {
                colorExposeVar = 2;
            } else if (colorExposeRandom == 2) {
                colorExposeVar = 5;
            } else if (colorExposeRandom == 3) {
                colorExposeVar = 6;
            } else if (colorExposeRandom == 4) {
                colorExposeVar = 8;
            } else if (colorExposeRandom == 5) {
                colorExposeVar = 9;
            } else if (colorExposeRandom == 6) {
                colorExposeVar = 10;
            } else if (colorExposeRandom >= 7 && colorExposeRandom <= 9) {
                colorExposeVar = 11;
            }
            
            NSMutableArray *object0Attributes = [[NSMutableArray alloc] initWithObjects:objectName0, [NSNumber numberWithFloat:randnumPosX], [NSNumber numberWithFloat:randnumPosZ], [NSNumber numberWithBool:0], [NSNumber numberWithFloat:randnumPosY], [NSNumber numberWithFloat:(float)randSizeCoeff/10.0], [NSNumber numberWithInt:colorExposeVar], nil];
            [generatedObjects addObject:object0Attributes];
            object0Attributes = nil;
            
            objectName0 = nil;
        }
        
        //foreground shine clusters
        for (int int1 = 0; int1 <= 3; int1++) {
            int locX = (arc4random() % 2001) - 1000;
            int locZ = (arc4random() % 2001) - 1000;
            
            float hypo = sqrtf(powf(((float)locX), 2.0) + powf(((float)locZ), 2.0));
            bool condition = 0;
            while (condition == 0) {
                locX = (arc4random() % 2001) - 1000;
                locZ = (arc4random() % 2001) - 1000;
                hypo = sqrtf(powf(((float)locX), 2.0) + powf(((float)locZ), 2.0));
                
                //radius condition
                condition = 1;
                if (hypo > 900) {
                    condition = 0;
                }
            }
            
            //creates shade particles nearby
            int randNumOfThings = arc4random() % 4;
            for (int int1 = 0; int1 <= 5+randNumOfThings; int1++) {
                NSString *objectName0 = @"spaceEnv2";
                
                int randNumArc = arc4random() % 120;
                float var1 = (((float)randNumArc/120.0)*(2*3.1415926535897932));
                int randHypoCoeff = arc4random() % 100;
                float randnumPosX = (cosf(var1)*((float)randHypoCoeff+1.0))+(float)locX;
                float randnumPosZ = (sinf(var1)*((float)randHypoCoeff+1.0))+(float)locZ;
                int randYpos = (arc4random() % 140) - 70;
                float randnumPosY = (float)randYpos;
                int randSizeCoeff = (arc4random() % 71) + 10;
                
                int colorExposeRandom = arc4random() % 10;
                int colorExposeVar = 0;
                if (colorExposeRandom == 0 || colorExposeRandom == 1) {
                    colorExposeVar = 2;
                } else if (colorExposeRandom == 2) {
                    colorExposeVar = 5;
                } else if (colorExposeRandom == 3) {
                    colorExposeVar = 6;
                } else if (colorExposeRandom == 4) {
                    colorExposeVar = 8;
                } else if (colorExposeRandom == 5) {
                    colorExposeVar = 9;
                } else if (colorExposeRandom == 6) {
                    colorExposeVar = 10;
                } else if (colorExposeRandom >= 7 && colorExposeRandom <= 9) {
                    colorExposeVar = 11;
                }
                
                NSMutableArray *object0Attributes = [[NSMutableArray alloc] initWithObjects:objectName0, [NSNumber numberWithFloat:randnumPosX], [NSNumber numberWithFloat:randnumPosZ], [NSNumber numberWithBool:0], [NSNumber numberWithFloat:randnumPosY], [NSNumber numberWithFloat:(float)randSizeCoeff/10.0], [NSNumber numberWithInt:colorExposeVar], nil];
                [generatedObjects addObject:object0Attributes];
                object0Attributes = nil;
                
                objectName0 = nil;
            }
        }
        
        //planets
        int randNumOfPlanets = arc4random() % 2;
        for (int int1 = 0; int1 <= randNumOfPlanets+3; int1++) {
            NSString *objectName0 = @"star2";
            
            int randNumArc = arc4random() % 350;
            float var1 = (((float)randNumArc/350.0)*(2*3.1415926535897932));
            int randHypoCoeff = arc4random() % 2000;
            float randnumPosX = (cosf(var1)*((float)randHypoCoeff+2600.0));
            float randnumPosZ = (sinf(var1)*((float)randHypoCoeff+2600.0));
            int randYpos = (arc4random() % 1200) - 600;
            float randnumPosY = (float)randYpos;
            int randSizeCoeff = (arc4random() % 18) + 10;
            
            int colorExposeRandom = arc4random() % 11;
            int colorExposeVar = 0;
            
            if (colorExposeRandom == 0 || colorExposeRandom == 1) {
                colorExposeVar = 2;
            } else if (colorExposeRandom == 2 || colorExposeRandom == 3) {
                colorExposeVar = 3;
            } else if (colorExposeRandom == 4 || colorExposeRandom == 5) {
                colorExposeVar = 5;
            } else if (colorExposeRandom == 6 || colorExposeRandom == 7) {
                colorExposeVar = 6;
            } else if (colorExposeRandom == 8 || colorExposeRandom == 9) {
                colorExposeVar = 9;
            } else if (colorExposeRandom == 10) {
                colorExposeVar = 11;
            }
            bool flipped = arc4random() % 2;
            
            NSMutableArray *object0Attributes = [[NSMutableArray alloc] initWithObjects:objectName0, [NSNumber numberWithFloat:randnumPosX], [NSNumber numberWithFloat:randnumPosZ], [NSNumber numberWithBool:flipped], [NSNumber numberWithFloat:randnumPosY], [NSNumber numberWithFloat:(float)randSizeCoeff/10.0], [NSNumber numberWithInt:colorExposeVar], nil];
            [generatedObjects addObject:object0Attributes];
            object0Attributes = nil;
            
            objectName0 = nil;
            
            int randNeedsRing = arc4random() % 3;
            if (randNeedsRing == 1) {
                NSString *objectName1 = @"star2ring";
                
                int colorExposeRandom2 = arc4random() % 5;
                int colorExposeVar2 = 0;
                
                if (colorExposeRandom2 == 0) {
                    colorExposeVar2 = 4;
                } else if (colorExposeRandom2 == 1) {
                    colorExposeVar2 = 8;
                } else if (colorExposeRandom2 == 2) {
                    colorExposeVar2 = 9;
                } else if (colorExposeRandom2 == 3) {
                    colorExposeVar2 = 10;
                } else if (colorExposeRandom2 == 4) {
                    colorExposeVar2 = 11;
                }
                
                NSMutableArray *object1Attributes = [[NSMutableArray alloc] initWithObjects:objectName1, [NSNumber numberWithFloat:randnumPosX], [NSNumber numberWithFloat:randnumPosZ], [NSNumber numberWithBool:flipped], [NSNumber numberWithFloat:randnumPosY], [NSNumber numberWithFloat:(float)randSizeCoeff/10.0], [NSNumber numberWithInt:colorExposeVar2], nil];
                [generatedObjects addObject:object1Attributes];
                object1Attributes = nil;
                
                objectName1 = nil;
            }
        }
        
        //nearer stars
        for (int int1 = 0; int1 <= 85; int1++) {
            NSString *objectName0 = @"star1";
            
            int randNumArc = arc4random() % 180;
            float var1 = (((float)randNumArc/180.0)*(2*3.1415926535897932));
            int randHypoCoeff = (arc4random() % 130) + 60;
            float randnumPosX = (cosf(var1)*((float)randHypoCoeff*1000.0));
            float randnumPosZ = (sinf(var1)*((float)randHypoCoeff*1000.0));
            
            int randYpos = (arc4random() % 701) - 350;
            float randnumPosY = (float)randYpos*200.0;
            if (int1 > 32) {
                randYpos = (arc4random() % 151) - 75;
                randnumPosY = (float)randYpos*200.0;
            }
            
            int randSizeCoeff = (arc4random() % 6) + 10;
            
            bool twinkling = arc4random() % 2;
            float twinklingOffset = 0;
            if (twinkling) {
                int randOffset = arc4random() % 41;
                twinklingOffset = ((float)randOffset/40.0)*(2*3.1415926535897932);
            }
            
            int randOpac = arc4random() % 51;
            
            NSMutableArray *object0Attributes = [[NSMutableArray alloc] initWithObjects:objectName0, [NSNumber numberWithFloat:randnumPosX], [NSNumber numberWithFloat:randnumPosZ], [NSNumber numberWithBool:0], [NSNumber numberWithFloat:randnumPosY], [NSNumber numberWithFloat:(float)randSizeCoeff/10.0], [NSNumber numberWithFloat:twinklingOffset], [NSNumber numberWithFloat:((float)randOpac+40.0)/90.0], nil];
            [generatedObjects addObject:object0Attributes];
            object0Attributes = nil;
            
            objectName0 = nil;
        }
        
        //further stars
        for (int int1 = 0; int1 <= 80; int1++) {
            NSString *objectName0 = @"star1";
            
            int randNumArc = arc4random() % 180;
            float var1 = (((float)randNumArc/180.0)*(2*3.1415926535897932));
            int randHypoCoeff = (arc4random() % 80) + 210;
            float randnumPosX = (cosf(var1)*((float)randHypoCoeff*1000.0));
            float randnumPosZ = (sinf(var1)*((float)randHypoCoeff*1000.0));
            
            int randYpos = (arc4random() % 101) - 50;
            float randnumPosY = (float)randYpos*200.0;
            
            int randSizeCoeff = (arc4random() % 4) + 9;
            
            bool twinkling = arc4random() % 2;
            float twinklingOffset = 0;
            if (twinkling) {
                int randOffset = arc4random() % 41;
                twinklingOffset = ((float)randOffset/40.0)*(2*3.1415926535897932);
            }
            
            int randOpac = arc4random() % 51;
            
            NSMutableArray *object0Attributes = [[NSMutableArray alloc] initWithObjects:objectName0, [NSNumber numberWithFloat:randnumPosX], [NSNumber numberWithFloat:randnumPosZ], [NSNumber numberWithBool:0], [NSNumber numberWithFloat:randnumPosY], [NSNumber numberWithFloat:(float)randSizeCoeff/10.0], [NSNumber numberWithFloat:twinklingOffset], [NSNumber numberWithFloat:((float)randOpac+40.0)/90.0], nil];
            [generatedObjects addObject:object0Attributes];
            object0Attributes = nil;
            
            objectName0 = nil;
        }
        
        //environment
        //FLAG - IMPORTANT BOOLEAN HERE
        playerIDHWL = 0;
        [[NSUserDefaults standardUserDefaults] setInteger:playerIDHWL forKey:@"playerID"];
        if (playerIDHWL == 0) {
            
            //clears database
            [[ref child:@"asteroids"] removeValue];
            [[ref child:@"projectilesToAdd"] removeValue];
            [[[ref child:@"angle"] child:@"angle"] setValue:[NSNumber numberWithFloat:0.0]];
            [[[ref child:@"rpm"] child:@"rpm"] setValue:[NSNumber numberWithFloat:0.0]];
            
            //initial asteroids
            int asteroidID = 0;
            int numAsts = 0;
            for (int int1 = 0; int1 <= 11; int1++) {
                for (int int2 = 0; int2 <= 13; int2++) {
                    
                    int createAsteroid = arc4random() % 3;
                    
                    if (createAsteroid == 1) {
                        numAsts++;
                        NSString *objectName = @"rock3";
                        int randName = arc4random() % 4;
                        if (randName == 1) {
                            objectName = @"rock4";
                        } else if (randName == 2) {
                            objectName = @"rock5";
                        } else if (randName == 3) {
                            objectName = @"rock6";
                        }
                        
                        float randnum1 = ((float)int1-5.0)*88.0;
                        float randnum2 = ((float)int2+1.2)*250.0;
                        
                        int randnum4 = (arc4random() % 2001) - 1000;
                        int randnum5 = (arc4random() % 21);
                        int randnum6 = (arc4random() % 51) - 25;
                        
                        asteroidID++;
                        
                        bool randnum3 = arc4random() % 2;
                        NSMutableArray *object1Attributes = [[NSMutableArray alloc] initWithObjects:objectName, [NSNumber numberWithFloat:randnum1], [NSNumber numberWithFloat:randnum2], [NSNumber numberWithBool:randnum3], [NSNumber numberWithFloat:(float)randnum4/50.0], [NSNumber numberWithFloat:(float)randnum5/20.0], [NSNumber numberWithFloat:((float)randnum6/15.0)*0.42], [NSNumber numberWithInt:asteroidID], nil];
                        [generatedObjects addObject:object1Attributes];
                        objectName = nil;
                        object1Attributes = nil;
                        
                        //writes initial map to database
                        [[[ref child:@"asteroids"] child:[NSString stringWithFormat:@"%i",asteroidID]] setValue:@{@"posX": [NSNumber numberWithInt:randnum1] ,@"posZ": [NSNumber numberWithInt:randnum2]}];
                    }
                }
            }
            
            [[ref child:@"numOfAsteroids"] setValue:[NSNumber numberWithInt:numAsts]];
            [[ref child:@"gameState"] setValue:[NSNumber numberWithInt:0]];
            
            for (int int1 = 0; int1 <= 0; int1++) {
                NSString *objectName = @"pool1";
                
                NSMutableArray *object1Attributes = [[NSMutableArray alloc] initWithObjects:objectName, [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithBool:0], [NSNumber numberWithInt:-50], nil];
                [generatedObjects addObject:object1Attributes];
                object1Attributes = nil;
                
                objectName = nil;
            }
            for (int int1 = 0; int1 <= 0; int1++) {
                NSString *objectName = @"pool1";
                
                NSMutableArray *object1Attributes = [[NSMutableArray alloc] initWithObjects:objectName, [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithBool:0], [NSNumber numberWithInt:50], nil];
                [generatedObjects addObject:object1Attributes];
                object1Attributes = nil;
                
                objectName = nil;
            }
            for (int int1 = 0; int1 <= 0; int1++) {
                NSString *objectName = @"pool2";
                
                NSMutableArray *object1Attributes = [[NSMutableArray alloc] initWithObjects:objectName, [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithBool:0], [NSNumber numberWithInt:49], nil];
                [generatedObjects addObject:object1Attributes];
                object1Attributes = nil;
                
                objectName = nil;
            }
            for (int int1 = 0; int1 <= 0; int1++) {
                NSString *objectName = @"chair1";
                
                NSMutableArray *object1Attributes = [[NSMutableArray alloc] initWithObjects:objectName, [NSNumber numberWithInt:0], [NSNumber numberWithInt:-37], [NSNumber numberWithBool:(arc4random() % 2)], [NSNumber numberWithInt:-21], nil];
                [generatedObjects addObject:object1Attributes];
                object1Attributes = nil;
                
                objectName = nil;
            }
            for (int int1 = 0; int1 <= 0; int1++) {
                NSString *objectName = @"wheel1";
                
                NSMutableArray *object1Attributes = [[NSMutableArray alloc] initWithObjects:objectName, [NSNumber numberWithInt:0], [NSNumber numberWithInt:37], [NSNumber numberWithBool:(arc4random() % 2)], [NSNumber numberWithInt:-24], nil];
                [generatedObjects addObject:object1Attributes];
                object1Attributes = nil;
                
                objectName = nil;
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:generatedObjects forKey:@"generatedObjects"];
            generatedObjects = nil;
            heatmapwradius = nil;
            
            printf("DONE GENERATING\n");
            
            [self initGame];
        } else {
            
            [[ref child:@"projectilesToAdd"] removeValue];
            
            //pulls asteroid data from firebase
            
            [[ref child:@"asteroids"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                NSArray *postDict = snapshot.value;
                
                for (int index = 1; index <= postDict.count-1; index++) {
                    NSString *objectName = @"rock3";
                    int randName = arc4random() % 4;
                    if (randName == 1) {
                        objectName = @"rock4";
                    } else if (randName == 2) {
                        objectName = @"rock5";
                    } else if (randName == 3) {
                        objectName = @"rock6";
                    }
                    
                    float randnum1 = [[postDict[index] valueForKey:@"posX"] floatValue];
                    float randnum2 = [[postDict[index] valueForKey:@"posZ"] floatValue];
                    
                    int randnum4 = (arc4random() % 2001) - 1000;
                    int randnum5 = (arc4random() % 21);
                    int randnum6 = (arc4random() % 51) - 25;
                    
                    bool randnum3 = arc4random() % 2;
                    NSMutableArray *object1Attributes = [[NSMutableArray alloc] initWithObjects:objectName, [NSNumber numberWithFloat:randnum1], [NSNumber numberWithFloat:randnum2], [NSNumber numberWithBool:randnum3], [NSNumber numberWithFloat:(float)randnum4/50.0], [NSNumber numberWithFloat:(float)randnum5/20.0], [NSNumber numberWithFloat:((float)randnum6/15.0)*0.42], [NSNumber numberWithInt:index], nil];
                    [generatedObjects addObject:object1Attributes];
                    objectName = nil;
                    object1Attributes = nil;
                }
                
                for (int int1 = 0; int1 <= 0; int1++) {
                    NSString *objectName = @"pool3";
                    
                    NSMutableArray *object1Attributes = [[NSMutableArray alloc] initWithObjects:objectName, [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithBool:0], [NSNumber numberWithInt:-45], nil];
                    [generatedObjects addObject:object1Attributes];
                    object1Attributes = nil;
                    
                    objectName = nil;
                }
                for (int int1 = 0; int1 <= 0; int1++) {
                    NSString *objectName = @"wheel1";
                    
                    NSMutableArray *object1Attributes = [[NSMutableArray alloc] initWithObjects:objectName, [NSNumber numberWithInt:0], [NSNumber numberWithInt:35], [NSNumber numberWithBool:(arc4random() % 2)], [NSNumber numberWithInt:-23], nil];
                    [generatedObjects addObject:object1Attributes];
                    object1Attributes = nil;
                    
                    objectName = nil;
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:generatedObjects forKey:@"generatedObjects"];
                
                printf("DONE GENERATING\n");
                
                [self initGame];
            } withCancelBlock:^(NSError * _Nonnull error) {
                NSLog(@"%@", error.localizedDescription);
            }];
        }
    }
}

- (void)createObjectInOtherInstance:(NSMutableArray *)objectParams {
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    id layer2 = [scene getChildByName:@"hwLayer3" recursively:YES]; //only pushes info to non-primary instance
    [layer2 createObjectfromOtherInstance:objectParams];
}

- (void)getPrimaryInstanceSyncData:(NSMutableArray *)uniqueIDs :(NSMutableArray *)physicalProperties :(NSMutableArray *)playerPosition {
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    id layer2 = [scene getChildByName:@"hwLayer3" recursively:YES]; //only pushes info to non-primary instance
    [layer2 applyPrimaryInstanceChanges:uniqueIDs :physicalProperties :playerPosition];
}

- (void)restartWithVRMode:(int)mode {
    vrModeOn = mode;
    
    score1 = 0;
    score2 = 0;
    scoretoggle = 0;
    
    NSMutableArray *childrentodelete = [[NSMutableArray alloc] init];
    for (CCNode* child in self.children){
        if ([child.name isEqualToString:@"mnLayer"] || [child.name isEqualToString:@"hwLayer2"] || [child.name isEqualToString:@"hwLayer3"] || [child.name isEqualToString:@"cropBox1"] || [child.name isEqualToString:@"cropBox2"] || [child.name isEqualToString:@"eyeguard1"] || [child.name isEqualToString:@"eyeguard2"]){
            [childrentodelete addObject:child];
        }
    }
    for (CCNode* child in childrentodelete){
        [self removeChild:child];
    }
    childrentodelete = nil;
    
    [self initGame];
}

- (void)initGame {
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    float iPhone6plusOffset = (((float)[self iPhone6Plus]+1.0)*2.0);
    
    if (vrModeOn == 0) {
        //removes textfield interactivity
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] removeVRComponents];
        
        [self setScaleX:1.0];
        [self setScaleY:1.0];
        [self setPosition:ccp(0,0)];
        
        //add layers
        MenuLayer *mnLayer = [MenuLayer node];
        [self addChild:mnLayer z:500000 name:@"mnLayer"];
        
        //add layers
        HelloWorldLayer2 *hwLayer2 = [HelloWorldLayer2 node];
        [self addChild:hwLayer2 z:1 name:@"hwLayer2"];
        [hwLayer2 setPosition:ccp(0,0)];
        
        [self setUserInteractionEnabled:1];
        [self setMultipleTouchEnabled:1];
    } else if (vrModeOn == 1) {
        
        if (playerIDHWL != 0) {
            //adds textfield interactivity
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] addVRComponents];
        } else {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] removeVRComponents];
        }
        
        [self setUserInteractionEnabled:0];
        [self setMultipleTouchEnabled:0];
        
        [self setScaleX:0.5];
        [self setScaleY:0.5];
        [self setPosition:ccp(0,0)];
        
        CCCropNode *crop1 = [CCCropNode node];
        crop1.mode = CCCropModeGraphicsAndTouches;
        [self addChild:crop1 z:2 name:@"cropBox1"];
        
        HelloWorldLayer2 *hwLayer2 = [HelloWorldLayer2 node];
        [hwLayer2 setPosition:ccp(0,0)];
        [hwLayer2 setContentSize:CGSizeMake(winSize.width/2.0,winSize.height)];
        [crop1 addChild:hwLayer2 z:2 name:@"hwLayer2"];
        
        CCCropNode *crop2 = [CCCropNode node];
        crop2.mode = CCCropModeGraphicsAndTouches;
        [self addChild:crop2 z:2 name:@"cropBox2"];
        
        HelloWorldLayer2 *hwLayer3 = [HelloWorldLayer2 node];
        [hwLayer3 setPosition:ccp(winSize.width,0)];
        [hwLayer3 setContentSize:CGSizeMake(winSize.width/2.0,winSize.height)];
        [crop2 addChild:hwLayer3 z:2 name:@"hwLayer3"];
        
        CCSprite *eyeguard1 = [CCSprite spriteWithImageNamed:@"eyeguard.png"];
        eyeguard1.scaleX = 2.72*2.0*(winSize.width/1334.0)*iPhone6plusOffset;
        eyeguard1.scaleY = 3.05*2.0*(winSize.height/750.0)*iPhone6plusOffset;
        eyeguard1.position = ccp((winSize.width/2.0),winSize.height);
        [self addChild:eyeguard1 z:3 name:@"eyeguard1"];
        
        CCSprite *eyeguard2 = [CCSprite spriteWithImageNamed:@"eyeguard.png"];
        eyeguard2.scaleX = 2.72*2.0*(winSize.width/1334.0)*iPhone6plusOffset;
        eyeguard2.scaleY = 3.05*2.0*(winSize.height/750.0)*iPhone6plusOffset;
        eyeguard2.position = ccp(3*(winSize.width/2.0),winSize.height);
        [self addChild:eyeguard2 z:3 name:@"eyeguard2"];
    }
}

- (void)getMotionScore:(float)score :(int)instance {
    if (instance == 1) { //primary instance
        score1 = score;
        scoretoggle++;
        
        if (scoretoggle == 0) {
            //printf("DIFF 1: %.3f\n",score1-score2);
            HelloWorldLayer2 * hwLayer2 = (HelloWorldLayer2 *)[self getChildByName:@"hwLayer2" recursively:1];
            [hwLayer2 induceSync];
        }
    } else {
        score2 = score;
        scoretoggle--;
        
        if (scoretoggle == 0) {
            //printf("DIFF 2: %.3f\n",score1-score2);
            HelloWorldLayer2 * hwLayer2 = (HelloWorldLayer2 *)[self getChildByName:@"hwLayer2" recursively:1];
            [hwLayer2 induceSync];
        }
    }
}

-(BOOL)iPhone6Plus{
    if ([UIScreen mainScreen].scale > 2.1) return YES; //iPhone 6+
    
    return NO;
}

- (void)act {
    //vr updates partner eye distance
    if (vrModeOn != vrModeOnRefresh) {
        vrModeOnRefresh = vrModeOn;
        
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] updateVRModeAD:vrModeOn];
        
        if (vrModeOn == 1) {
            //loads previously saved vr eye distance settings
            int vrSetting = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"vrCSedVal"];
            float vrDist = 5+((float)vrSetting*5*0.999/3);
            
            HelloWorldLayer2 * hwLayer2 = (HelloWorldLayer2 *)[self getChildByName:@"hwLayer2" recursively:1];
            [hwLayer2 setEyeDistance:-vrDist]; //will become primary instance (because eye distance < 0, left eye)
            
            HelloWorldLayer2 * hwLayer3 = (HelloWorldLayer2 *)[self getChildByName:@"hwLayer3" recursively:1];
            [hwLayer3 setEyeDistance:vrDist];
            
            //starts textfield input
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] startTextInput];
        } else {
            HelloWorldLayer2 * hwLayer2 = (HelloWorldLayer2 *)[self getChildByName:@"hwLayer2" recursively:1];
            [hwLayer2 setEyeDistance:0]; //basically just tells single instance that it's the primary instance
            
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] removeVRComponents];
        }
    }
}

- (void)touchBegan:(UITouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInView:[[CCDirector sharedDirector] view]];
    [currentTouchesX addObject:[NSNumber numberWithFloat:touchLocation.x]];
    [currentTouchesY addObject:[NSNumber numberWithFloat:touchLocation.y]];
    
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    id mnLayer = [scene getChildByName:@"mnLayer" recursively:YES];
    [mnLayer touchBeganCustom:currentTouchesX :currentTouchesY :((int)[currentTouchesX count]-1)];
    
    /*for (int index = 0; index < [currentTouchesX count]; index++) {
        printf("Touch Start X: %.1f\n",[[currentTouchesX objectAtIndex:index] floatValue]);
    }*/
}

- (void)touchMoved:(UITouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInView:[[CCDirector sharedDirector] view]];
    int indexOfClosestPoint = -1;
    float nearestHypotenuse = 99999;
    for (int index = 0; index < [currentTouchesX count]; index++) {
        float hypoToTest = sqrtf(powf([[currentTouchesX objectAtIndex:index] floatValue]-touchLocation.x, 2.0) + powf([[currentTouchesY objectAtIndex:index] floatValue]-touchLocation.y, 2.0));
        if (hypoToTest < nearestHypotenuse) {
            nearestHypotenuse = hypoToTest;
            indexOfClosestPoint = index;
        }
    }
    
    [currentTouchesX setObject:[NSNumber numberWithFloat:touchLocation.x] atIndexedSubscript:indexOfClosestPoint];
    [currentTouchesY setObject:[NSNumber numberWithFloat:touchLocation.y] atIndexedSubscript:indexOfClosestPoint];
    
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    id mnLayer = [scene getChildByName:@"mnLayer" recursively:YES];
    [mnLayer touchMovedCustom:currentTouchesX :currentTouchesY :indexOfClosestPoint];
    
    /*for (int index = 0; index < [currentTouchesX count]; index++) {
        printf("Touch Moved X: %.1f\n",[[currentTouchesX objectAtIndex:index] floatValue]);
    }*/
}

- (void)touchEnded:(UITouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInView:[[CCDirector sharedDirector] view]];
    int indexOfClosestPoint = -1;
    float nearestHypotenuse = 99999;
    for (int index = 0; index < [currentTouchesX count]; index++) {
        float hypoToTest = sqrtf(powf([[currentTouchesX objectAtIndex:index] floatValue]-touchLocation.x, 2.0) + powf([[currentTouchesY objectAtIndex:index] floatValue]-touchLocation.y, 2.0));
        if (hypoToTest < nearestHypotenuse) {
            nearestHypotenuse = hypoToTest;
            indexOfClosestPoint = index;
        }
    }
    
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    id mnLayer = [scene getChildByName:@"mnLayer" recursively:YES];
    [mnLayer touchEndedCustom:currentTouchesX :currentTouchesY :indexOfClosestPoint];
    
    [currentTouchesX removeObjectAtIndex:indexOfClosestPoint];
    [currentTouchesY removeObjectAtIndex:indexOfClosestPoint];
    
    //printf("Touch Ended X: %.1f\n",touchLocation.x);
}

- (void)touchCancelled:(UITouch *)touch withEvent:(CCTouchEvent *)event { //should be identical to touchEnded
    CGPoint touchLocation = [touch locationInView:[[CCDirector sharedDirector] view]];
    int indexOfClosestPoint = -1;
    float nearestHypotenuse = 99999;
    for (int index = 0; index < [currentTouchesX count]; index++) {
        float hypoToTest = sqrtf(powf([[currentTouchesX objectAtIndex:index] floatValue]-touchLocation.x, 2.0) + powf([[currentTouchesY objectAtIndex:index] floatValue]-touchLocation.y, 2.0));
        if (hypoToTest < nearestHypotenuse) {
            nearestHypotenuse = hypoToTest;
            indexOfClosestPoint = index;
        }
    }
    
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    id mnLayer = [scene getChildByName:@"mnLayer" recursively:YES];
    [mnLayer touchEndedCustom:currentTouchesX :currentTouchesY :indexOfClosestPoint];
    
    [currentTouchesX removeObjectAtIndex:indexOfClosestPoint];
    [currentTouchesY removeObjectAtIndex:indexOfClosestPoint];
    
    //printf("Touch Cancelled X: %.1f\n",touchLocation.x);
}

-(id) init
{
    if( (self=[super init] )) {
        
        currentTouchesX = [[NSMutableArray alloc]init ];
        currentTouchesY = [[NSMutableArray alloc]init ];
        
        ref = [[FIRDatabase database] reference];
        
        //vr mode off/on
        vrModeOn = 1;
        vrModeOnRefresh = -1;
        
        bool isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
        if (isIPad != 0) {
            vrModeOn = 0;
        }
        
        //saves default keyboard settings
        bool keyDefaultsSaved = (bool)[[NSUserDefaults standardUserDefaults] integerForKey:@"keyDefaultsSaved2"];
        if (keyDefaultsSaved == 0) {
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"keyDefaultsSaved"];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"h" forKey:@"key_closeopen_default"];
            [[NSUserDefaults standardUserDefaults] setObject:@"e" forKey:@"key_pickupdrop_default"];
            [[NSUserDefaults standardUserDefaults] setObject:@"r" forKey:@"key_throwinteract_default"];
            [[NSUserDefaults standardUserDefaults] setObject:@"w" forKey:@"key_moveforward_default"];
            [[NSUserDefaults standardUserDefaults] setObject:@"s" forKey:@"key_movebackward_default"];
            [[NSUserDefaults standardUserDefaults] setObject:@"a" forKey:@"key_moveleft_default"];
            [[NSUserDefaults standardUserDefaults] setObject:@"d" forKey:@"key_moveright_default"];
            [[NSUserDefaults standardUserDefaults] setObject:@" " forKey:@"key_jump_default"];
            [[NSUserDefaults standardUserDefaults] setObject:@"," forKey:@"key_rotateleft_default"];
            [[NSUserDefaults standardUserDefaults] setObject:@"." forKey:@"key_rotateright_default"];
            [[NSUserDefaults standardUserDefaults] setObject:@"g" forKey:@"key_exitvr_default"];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"h" forKey:@"key_closeopen"];
            [[NSUserDefaults standardUserDefaults] setObject:@"e" forKey:@"key_pickupdrop"];
            [[NSUserDefaults standardUserDefaults] setObject:@"r" forKey:@"key_throwinteract"];
            [[NSUserDefaults standardUserDefaults] setObject:@"w" forKey:@"key_moveforward"];
            [[NSUserDefaults standardUserDefaults] setObject:@"s" forKey:@"key_movebackward"];
            [[NSUserDefaults standardUserDefaults] setObject:@"a" forKey:@"key_moveleft"];
            [[NSUserDefaults standardUserDefaults] setObject:@"d" forKey:@"key_moveright"];
            [[NSUserDefaults standardUserDefaults] setObject:@" " forKey:@"key_jump"];
            [[NSUserDefaults standardUserDefaults] setObject:@"," forKey:@"key_rotateleft"];
            [[NSUserDefaults standardUserDefaults] setObject:@"." forKey:@"key_rotateright"];
            [[NSUserDefaults standardUserDefaults] setObject:@"g" forKey:@"key_exitvr"];
        }
        
        [self generateNewLevel];
        
        [self schedule:@selector(act) interval:1.0/60.0];
	}
	return self;
}

@end
