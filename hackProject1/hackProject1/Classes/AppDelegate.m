#import "AppDelegate.h"
#import "IntroLayer.h"
#import "HelloWorldLayer.h"
#import "HelloWorldLayer2.h"
#import "OALAudioSession.h"

// -----------------------------------------------------------------------

@implementation AppDelegate

// -----------------------------------------------------------------------
// This is where your app starts. It takes two steps
// 1) Setting up Cocos2D, which is done with setupCocos2dWithOptions
// 2) Call your first scene, which is done by overriding startScene

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Cocos2D takes a dictionary to start ... yeah I know ... but it does, and it is kind of neat
    NSMutableDictionary *startUpOptions = [NSMutableDictionary dictionary];
    
    // Let's add some setup stuff
    
    // File extensions
    // You can use anything you want, and completely dropping extensions will in most cases automatically scale the artwork correct
    // To make it easy to understand what resolutions I am using, I have changed this for this demo to -4x -2x and -1x
    // Notice that I deliberately added some of the artwork without extensions
    [CCFileUtils sharedFileUtils].suffixesDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                  @"", CCFileUtilsSuffixiPad,
                                                  @"", CCFileUtilsSuffixiPadHD,
                                                  @"", CCFileUtilsSuffixiPhone,
                                                  @"", CCFileUtilsSuffixiPhoneHD,
                                                  @"", CCFileUtilsSuffixiPhone5,
                                                  @"", CCFileUtilsSuffixiPhone5HD,
                                                  @"", CCFileUtilsSuffixDefault,
                                                  nil];
    
    // Show FPS
    // We really want this when developing an app
    [startUpOptions setObject:@(NO) forKey:CCSetupShowDebugStats];
    
    // A acouple of other examples
    
    // Use a 16 bit color buffer
    // This will lower the color depth from 32 bits to 16 bits for that extra performance
    // Most will want 32, so we disbaled it
    // ---
    // [startUpOptions setObject:kEAGLColorFormatRGB565 forKey:CCSetupPixelFormat];
    
    // Use a simplified coordinate system that is shared across devices
    // Normally you work in the coordinate of the device (an iPad is 1024x768, an iPhone 4 480x320 and so on)
    // This feature makes it easier to use the same setup for all devices (easier is a relative term)
    // Most will want to handle iPad and iPhone exclusively, so it is disabled by default
    // ---
    // [startUpOptions setObject:CCScreenModeFixed forKey:CCSetupScreenMode];
    
    // All the supported keys can be found in CCConfiguration.h
    
    [startUpOptions setObject:@(GL_DEPTH24_STENCIL8_OES) forKey:CCSetupDepthFormat];
    
    // We are done ...
    // Lets get this thing on the road!
    [self setupCocos2dWithOptions:startUpOptions];
    
    [[[CCDirector sharedDirector] view] setClipsToBounds:1];
    
    windowWidth = [[CCDirector sharedDirector] viewSize].width;
    windowHeight = [[CCDirector sharedDirector] viewSize].height;
    
    tf = [[UITextField alloc] initWithFrame:CGRectMake(1, 1, 1, 1)];
    tf.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    tf.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    tf.backgroundColor=[UIColor whiteColor];
    tf.text=@"";
    [tf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [tf setSpellCheckingType:UITextSpellCheckingTypeNo];
    [tf setKeyboardType:UIKeyboardTypeAlphabet];
    [tf setAutocorrectionType:UITextAutocorrectionTypeNo];
    [tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [tf addTarget:self action:@selector(textFieldNotFocused:) forControlEvents:UIControlEventEditingDidEnd];
    currentchar = @"";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-100, -100, 10, 10)];
    [view addSubview:tf];
    
    [[[CCDirector sharedDirector] view] addSubview:view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    OALAudioSession *session = [OALAudioSession sharedInstance];
    [session setAllowIpod:YES];
    [session setUseHardwareIfAvailable:NO];
    [session setHonorSilentSwitch:YES];
    
    // Stay positive. Always return a YES :)
    return YES;
}

-(void)updateVRModeAD:(int)mode {
    vrModeOnAD = mode;
}

-(void)startTextInput {
    if (vrModeOnAD != 0) {
        [tf becomeFirstResponder];
    }
}

-(void)textFieldDidChange :(UITextField *) textField{
    if (vrModeOnAD != 0) {
        currentchar = [textField.text lowercaseString];
        //printf("txt: %s\n",[currentchar UTF8String]);
        textField.text = @"";
        
        CCScene *scene = [[CCDirector sharedDirector] runningScene];
        id layer = [scene getChildByName:@"hwLayer2" recursively:YES];
        id layer2 = [scene getChildByName:@"hwLayer3" recursively:YES];
        
        if ([currentchar isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveforward"]]) {
            [layer moveZposition:3.5];
            [layer2 moveZposition:3.5];
        } else if ([currentchar isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_movebackward"]]) {
            [layer moveZposition:-3.5];
            [layer2 moveZposition:-3.5];
        } else if ([currentchar isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveleft"]]) {
            [layer moveXposition:-3.5];
            [layer2 moveXposition:-3.5];
        } else if ([currentchar isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_moveright"]]) {
            [layer moveXposition:3.5];
            [layer2 moveXposition:3.5];
        } else if ([currentchar isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"key_closeopen"]] || [currentchar isEqualToString:@"h"] || [currentchar isEqualToString:@"H"]) {
            [layer toggleVRmenuInterface:-1];
            [layer2 toggleVRmenuInterface:-1];
        }
        
        
        //dev controls
        if ([currentchar isEqualToString:@"j"] || [currentchar isEqualToString:@"J"]) {
          [layer lookDirection:-120.0 :0.0];
          [layer lookStop];
          [layer2 lookDirection:-120.0 :0.0];
          [layer2 lookStop];
          } else if ([currentchar isEqualToString:@"l"] || [currentchar isEqualToString:@"L"]) {
          [layer lookDirection:120.0 :0.0];
          [layer lookStop];
          [layer2 lookDirection:120.0 :0.0];
          [layer2 lookStop];
          } else if ([currentchar isEqualToString:@"i"] || [currentchar isEqualToString:@"I"]) {
          [layer lookDirection:0.0 :160.0];
          [layer lookStop];
          [layer2 lookDirection:0.0 :160.0];
          [layer2 lookStop];
          } else if ([currentchar isEqualToString:@"k"] || [currentchar isEqualToString:@"K"]) {
          [layer lookDirection:0.0 :-160.0];
          [layer lookStop];
          [layer2 lookDirection:0.0 :-160.0];
          [layer2 lookStop];
          }
        
        //failsafe menu navigation controls
        [layer navigateMenu:currentchar];
        [layer2 navigateMenu:currentchar];
    }
}

-(void)textFieldNotFocused :(UITextField *) textField{
    if (vrModeOnAD != 0) {
        //printf("tf not focused\n");
        [tf becomeFirstResponder];
    }
}

- (void) keyboardWillShow:(NSNotification *)notification{
    if (vrModeOnAD != 0) {
        //printf("KEYBOARD SHOWING\n");
        
        CCScene *scene = [[CCDirector sharedDirector] runningScene];
        id layer = [scene getChildByName:@"hwLayer2" recursively:YES];
        id layer2 = [scene getChildByName:@"hwLayer3" recursively:YES];
        [layer bluetoothConnectivityChange:1];
        [layer2 bluetoothConnectivityChange:1];
        
        /*NSDictionary* userInfo = [notification userInfo];
         CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
         [[[CCDirector sharedDirector] view] setBounds:CGRectMake(0,50,windowWidth,windowHeight/2.0)];
         [[[CCDirector sharedDirector] view] setFrame:CGRectMake(0,50,windowWidth,windowHeight/2.0)];*/
    }
}

- (void) keyboardWillHide:(NSNotification *)notification{
    if (vrModeOnAD != 0) {
        //printf("KEYBOARD HIDING\n");
        //[[[CCDirector sharedDirector] view] setBounds:CGRectMake(0,0,windowWidth,windowHeight)];
        
        CCScene *scene = [[CCDirector sharedDirector] runningScene];
        id layer = [scene getChildByName:@"hwLayer2" recursively:YES];
        id layer2 = [scene getChildByName:@"hwLayer3" recursively:YES];
        [layer bluetoothConnectivityChange:0];
        [layer2 bluetoothConnectivityChange:0];
    }
}

// -----------------------------------------------------------------------
// This method should return the very first scene to be run when your app starts.

- (void)addVRComponents {
    /*tf = [[UITextField alloc] initWithFrame:CGRectMake(1, 1, 1, 1)];
     tf.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
     tf.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
     tf.backgroundColor=[UIColor whiteColor];
     tf.text=@"";
     [tf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
     [tf setSpellCheckingType:UITextSpellCheckingTypeNo];
     [tf setKeyboardType:UIKeyboardTypeAlphabet];
     [tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [tf addTarget:self action:@selector(textFieldNotFocused:) forControlEvents:UIControlEventEditingDidEnd];
     currentchar = @"";
     
     UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-100, -100, 10, 10)];
     [view addSubview:tf];
     
     [[[CCDirector sharedDirector] view] addSubview:view];*/
    
    //printf("ADD VR COMPONENTS\n");
}

- (void)removeVRComponents {
    [tf resignFirstResponder];
    /*if ([[[CCDirector sharedDirector] view] subviews].count-1 > 0) {
     [[[CCDirector sharedDirector] view] willRemoveSubview:[[[[CCDirector sharedDirector] view] subviews] objectAtIndex:[[[CCDirector sharedDirector] view] subviews].count-1]];
     }*/
    //printf("REMOVE VR COMPONENTS\n");
}

- (CCScene *)startScene
{
    return [IntroLayer new];
}

// -----------------------------------------------------------------------

@end

