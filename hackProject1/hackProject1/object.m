#import "object.h"
#define CC_RETINA_DISPLAY_FILENAME_SUFFIX @"-hd"

@implementation object
@end

@implementation vr1

+ (id)vrElement1 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"vrConnectKeyboard.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 20;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = 140;
        
        //physical random properties
        object.objectScaleX = 0.9;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr1_1

+ (id)vrElement1_1 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"vrTurnOffVR.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 20;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = 18;
        
        //physical random properties
        object.objectScaleX = 0.45;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr1_2

+ (id)vrElement1_2 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"vrHhelpcontrols.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 23;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = -170;
        
        //physical random properties
        object.objectScaleX = 0.39;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr2

+ (id)vrElement2 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"crosshairwhite.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 18;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = 0;
        
        //physical random properties
        object.objectScaleX = 0.17;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.5;
        
        object.vrUIelement = 1;
    }
    return object;
}

@end

@implementation vr3

+ (id)vrElement3 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"vrHUDbg.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 19;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = 0;
        
        //physical random properties
        object.objectScaleX = 1.8;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -55; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr4

+ (id)vrElement4 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"title_cands.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 19;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = 160;
        
        //physical random properties
        object.objectScaleX = 0.36;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr5

+ (id)vrElement5 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"title_instr1.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 19;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = 128;
        
        //physical random properties
        object.objectScaleX = 0.39;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr6

+ (id)vrElement6 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"controls_scroll.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 19;
        
        //vr UI element posisioning
        object.pospreXoffset = -195;
        object.pospreYoffset = 150;
        
        //physical random properties
        object.objectScaleX = 0.31;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr6_2

+ (id)vrElement6_2 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"controls_moveslider.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 19;
        
        //vr UI element posisioning
        object.pospreXoffset = 195;
        object.pospreYoffset = 150;
        
        //physical random properties
        object.objectScaleX = 0.31;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr_k

+ (id)vrKey {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"controls_emptykey.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 22;
        
        //vr UI element posisioning
        object.pospreXoffset = -100;
        object.pospreYoffset = 70;
        
        //physical random properties
        object.objectScaleX = 0.5;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr_kw1

+ (id)vrKeyText1 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"text_closeopen.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 22;
        
        //vr UI element posisioning
        object.pospreXoffset = 28;
        object.pospreYoffset = 70;
        
        //physical random properties
        object.objectScaleX = 0.45;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr_kw2

+ (id)vrKeyResetButton {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"resettodefault.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 22;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = 60;
        
        //physical random properties
        object.objectScaleX = 0.6;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr_kw3

+ (id)vrEyeDist {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"title_eyedist.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 22;
        
        //vr UI element posisioning
        object.pospreXoffset = -158;
        object.pospreYoffset = 63;
        
        //physical random properties
        object.objectScaleX = 0.4;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr_kw4

+ (id)vrEyeDistBar {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"sliderbar.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 22;
        
        //vr UI element posisioning
        object.pospreXoffset = 51;
        object.pospreYoffset = 63;
        
        //physical random properties
        object.objectScaleX = 0.35;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr_kw5

+ (id)vrEyeDistTicker {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"slider.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 22;
        
        //vr UI element posisioning
        object.pospreXoffset = 51;
        object.pospreYoffset = 70;
        
        //physical random properties
        object.objectScaleX = 0.23;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -56; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation pool1

+ (id)pool1test {
    object *object = nil;
    if ((object = [[super alloc] init])) {
        object.refreshminypos = 1;
        object.actual2DZorder = 0;
        object.objectid = 4;
        
        //physical random properties
        object.objectScaleX = 1.0;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = 0;
        object.minyposition = object.standardHeight/2; //objects without sprite use standard height
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        
        object.isafloorobject = 2;
        
        object.polygonSides = 12;
        object.polygonRadius = 105;
        object.polygonColorRed = 115.0;
        object.polygonColorGreen = 115.0;
        object.polygonColorBlue = 145.0;
        object.polygonColorAlpha = 1.0;
    }
    return object;
}

@end

@implementation pool2

+ (id)pool2test {
    object *object = nil;
    if ((object = [[super alloc] init])) {
        object.refreshminypos = 1;
        object.actual2DZorder = 0;
        object.objectid = 4;
        
        //physical random properties
        object.objectScaleX = 1.0;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = 0;
        object.minyposition = object.standardHeight/2; //objects without sprite use standard height
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        
        object.isafloorobject = 2;
        
        object.polygonSides = 12;
        object.polygonRadius = 60;
        object.polygonColorRed = 50.0;
        object.polygonColorGreen = 120.0;
        object.polygonColorBlue = 200.0;
        object.polygonColorAlpha = 1.0;
    }
    return object;
}

@end

@implementation pool3

+ (id)pool3test {
    object *object = nil;
    if ((object = [[super alloc] init])) {
        object.refreshminypos = 1;
        object.actual2DZorder = 0;
        object.objectid = 4;
        
        //physical random properties
        object.objectScaleX = 1.0;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = 0;
        object.minyposition = object.standardHeight/2; //objects without sprite use standard height
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        
        object.isafloorobject = 2;
        
        object.polygonSides = 12;
        object.polygonRadius = 70;
        object.polygonColorRed = 50.0;
        object.polygonColorGreen = 120.0;
        object.polygonColorBlue = 200.0;
        object.polygonColorAlpha = 1.0;
    }
    return object;
}

@end

@implementation arrow1

+ (id)arrowHelp1 {
    object *object = nil;
    if ((object = [[super alloc] init])) {
        object.objectid = 21;
        
        //physical random properties
        object.objectScaleX = 1.0;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = 140;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        
        object.isafloorobject = 4; //custom type
        object.polygonSides = 4;
        object.polygonRadius = 20;
        object.polygonColorRed = 255.0;
        object.polygonColorGreen = 255.0;
        object.polygonColorBlue = 255.0;
        object.polygonColorAlpha = 1.0;
    }
    return object;
}

@end

@implementation spaceEnv1

+ (id)spaceShine{
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"shine1.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 60.0;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 39;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.1;
        
        object.standardScale = 1.0;
        object.standardHeight = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 0;
        object.isasmallobject = 0;
        object.objectonhorizon = 1;
    }
    return object;
}

@end

@implementation rock3

+ (id)rockAsteroid1 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"asteroid1_2.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.08;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 40;
        object.objecttoplayerradius = 35.0;
        object.objecttoobjectradius = 16.0;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = (440*(object.objectScaleY));
        object.playerusable = 0;
        object.objectusesgravity = 0;
        object.objectusescollisions = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.objectstackable = 0;
        
        //chromavera-specific
        object.colorExposeID = 5;
    }
    return object;
}

@end

@implementation rock4

+ (id)rockAsteroid2 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"asteroid2_2.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.08;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 41;
        object.objecttoplayerradius = 35.0;
        object.objecttoobjectradius = 16.0;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = (440*(object.objectScaleY));
        object.playerusable = 0;
        object.objectusesgravity = 0;
        object.objectusescollisions = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.objectstackable = 0;
        
        //chromavera-specific
        object.colorExposeID = 5;
    }
    return object;
}

@end

@implementation star1

+ (id)star1White {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"star.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 20.0;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 42;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 0;
        object.isasmallobject = 0;
        object.objectonhorizon = 1;
        
        //chromavera-specific
        object.colorExposeID = 2;
    }
    return object;
}

@end

@implementation spaceEnv2

+ (id)spaceShine2{
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"shine1.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.25;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 43;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.05;
        
        object.standardScale = 1.0;
        object.standardHeight = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 0;
        object.isasmallobject = 0;
        object.objectonhorizon = 0;
    }
    return object;
}

@end

@implementation part1

+ (id)particleDistCloud{
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"dust.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.10;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 44;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.7;
        
        object.standardScale = 1.0;
        object.standardHeight = (50*(object.objectScaleY));
        object.objectusesgravity = 0;
        object.objectusescollisions = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.isasmallobject = 0;
        
        //particle effects
        object.opacity = 0;
        object.isaparticle = 1;
        object.particleDilationRate = 11.0;
        object.particleDilation = 1.0;
        
        //chromavera-specific
        object.colorExposeID = 7;
    }
    return object;
}

@end

@implementation star2

+ (id)star2Planet{
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"planet1.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.3;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 45;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 0;
        object.isasmallobject = 0;
        object.objectonhorizon = 0;
    }
    return object;
}

@end

@implementation star2ring

+ (id)star2PlanetRing{
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"planet1ring.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.3;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 46;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.6;
        
        object.standardScale = 1.0;
        object.standardHeight = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 0;
        object.isasmallobject = 0;
        object.objectonhorizon = 0;
    }
    return object;
}

@end

@implementation part2

+ (id)particleWaterParticle{
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"waterball.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.05;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 47;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.7;
        
        object.standardScale = 1.0;
        object.standardHeight = (110*(object.objectScaleY));
        object.objectusesgravity = 1;
        object.objectusescollisions = 1;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.isasmallobject = 0;
        
        //particle effects
        object.opacity = 0;
        object.isaparticle = 1;
        object.particleDilationRate = 15.0;
        object.particleDilation = 1.0;
        
        //chromavera-specific
        object.colorExposeID = 2;
    }
    return object;
}

@end

@implementation rock5

+ (id)rockAsteroid3 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"asteroid3_2.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.065;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 48;
        object.objecttoplayerradius = 35.0;
        object.objecttoobjectradius = 16.0;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = (515*(object.objectScaleY));
        object.playerusable = 0;
        object.objectusesgravity = 0;
        object.objectusescollisions = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.objectstackable = 0;
        
        //chromavera-specific
        object.colorExposeID = 5;
    }
    return object;
}

@end

@implementation rock6

+ (id)rockAsteroid4 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"asteroid4_2.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.065;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 49;
        object.objecttoplayerradius = 35.0;
        object.objecttoobjectradius = 16.0;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = (515*(object.objectScaleY));
        object.playerusable = 0;
        object.objectusesgravity = 0;
        object.objectusescollisions = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.objectstackable = 0;
        
        //chromavera-specific
        object.colorExposeID = 5;
    }
    return object;
}

@end

@implementation vr7

+ (id)vrElement7 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"spaceshipinterior1_2.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 17;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = 0;
        
        //physical random properties
        object.objectScaleX = 0.4;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -50; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr7_2

+ (id)vrElement7_2 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"spaceshipinterior1_1.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 17;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = 0;
        
        //physical random properties
        object.objectScaleX = 0.4;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -50; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation chair1

+ (id)chairRed1{
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"chair1.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.054;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 50;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = (400*(object.objectScaleY));
        object.playerusable = 0;
        object.objectusesgravity = 0;
        object.objectusescollisions = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.objectstackable = 0;
    }
    return object;
}

@end

@implementation wheel1

+ (id)wheelDriver1{
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"wheel1.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.065;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 50;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = (510*(object.objectScaleY));
        object.playerusable = 0;
        object.objectusesgravity = 0;
        object.objectusescollisions = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.objectstackable = 0;
    }
    return object;
}

@end

@implementation gun1

+ (id)gunPart1{
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"gunpart1.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.08;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 51;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = (250*(object.objectScaleY));
        object.playerusable = 0;
        object.objectusesgravity = 0;
        object.objectusescollisions = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.objectstackable = 0;
    }
    return object;
}

@end

@implementation gun2

+ (id)gunMissile{
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"whitecircle.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.07;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 52;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = (360*(object.objectScaleY));
        object.playerusable = 0;
        object.objectusesgravity = 0;
        object.objectusescollisions = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.objectstackable = 0;
    }
    return object;
}

@end

@implementation expl1

+ (id)explParticle1{
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"whitecircle.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.04;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 53;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = (360*(object.objectScaleY));
        object.playerusable = 0;
        object.objectusesgravity = 0;
        object.objectusescollisions = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.objectstackable = 0;
        
        object.isaparticle = 1;
        object.particleDilation = 1.0;
        object.particleDilationRate = 22.0;
    }
    return object;
}

@end

@implementation rock7

+ (id)rockFinishFlag {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"finishflag.png"])) {
        object.refreshminypos = 1;
        object.objectScaleX = 0.25;
        object.objectScaleY = object.objectScaleX;
        object.actual2DZorder = 0;
        object.objectid = 54;
        
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.standardScale = 1.0;
        object.standardHeight = (240*(object.objectScaleY));
        object.playerusable = 0;
        object.objectusesgravity = 0;
        object.objectusescollisions = 0;
        object.minyposition = object.standardHeight/2;
        object.mininitialyposition = object.minyposition;
        object.dontVaryPerspective = 1;
        object.objectstackable = 0;
    }
    return object;
}

@end

@implementation vr8

+ (id)vrElement8 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"redwarning.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 16;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = 0;
        
        //physical random properties
        object.objectScaleX = 5.0;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 0.5;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -50; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end

@implementation vr9

+ (id)vrElement9 {
    object *object = nil;
    if ((object = [[super alloc] initWithImageNamed:@"congrats.png"])) {
        object.actual2DZorder = 0;
        object.objectid = 15;
        
        //vr UI element posisioning
        object.pospreXoffset = 0;
        object.pospreYoffset = 0;
        
        //physical random properties
        object.objectScaleX = 0.24;
        object.objectScaleY = object.objectScaleX;
        object.objectScaleXOffset = 1.0;
        object.objectScaleYOffset = 1.0;
        object.customOpacity = 1.0;
        
        object.vrUIelement = 1;
        object.actual2DZorder = -50; //< -50 places vr UI object above all other objects
    }
    return object;
}

@end
