#import "CCSprite.h"

@interface object : CCSprite {
    int _uniqueobjectid;
    int _parentobjectid;
    
    float _pospreXoffset; //used to position vr UI elements
    float _pospreYoffset; //used to position vr UI elements
    float _pospreYoffset2;
    float _pospreZoffset;
    float _posXoffset;
    float _posYoffset;
    float _posZoffset;
    
    float _posX;
    float _posY; //position upwards
    float _posZ; //position FROM view
    
    float _postposX;
    float _postposY;
    float _postposZ;
    
    float _preposX;
    float _preposY;
    float _preposZ;
    
    float _calcX1;
    float _calcY1;
    float _calcZ1; //used to monitor x angle to objects from view
    float _calcZ2;
    float _calcZ3;
    float _finalposX;
    float _finalposY;
    float _objectScaleX;
    float _objectScaleY;
    int _actual2DZorder;
    float _rotationoffsetx; //doesn't affect position
    float _rotationoffsetx2; //does affect position
    float _rotationscalevar1;
    float _rotationscalevar2;
    float _rotationtargetoffsetx2;
    int _randomflipped;
    float _standardScale;
    float _standardHeight;
    bool _dontVaryPerspective; //determines whether to monitor variables for sprite changes based on rotation
    int _texturePerspective;
    int _objecttag;
    int _objectid;
    float _FOVrotationobjectvar1;
    float _FOVrotationobjectvar2;
    float _FOVrotationobjectvar3;
    float _FOVrotationobjectvar4;
    float _posXmomentum;
    float _posYmomentum;
    float _posZmomentum;
    float _FGOposXmomentum;
    float _FGOposYmomentum;
    float _FGOposZmomentum;
    bool _refreshminypos;
    float _hypotenusetoplayer;
    float _angletoplayer;
    float _PREangletoplayer;
    float _objecttoplayerradius;
    float _objecttoobjectradius;
    bool _objectgrabbed;
    bool _spawnpartnerobjects;
    bool _playerusable;
    bool _objectusesgravity;
    int _objectusescollisions; //none, submissive collisions, obtrusive collisions
    bool _objectusessubobjects;
    int _objectdistancetoggle; //used for creating/removing sub-objects at a certain distance
    float _minyposition;
    float _mininitialyposition;
    float _rotationoffsetvar1;
    float _rotationoffsetvar2;
    bool _changescaleX;
    bool _changescaleY; //currently inneffective (USE FOR FLOOR OBJECTS)
    bool _objectinvisible;
    float _objectScaleXOffset; //may or may not be actually in effect
    float _objectScaleYOffset; //may or may not be actually in effect
    bool _parentsubinvisiblewhenscalenegative; //may or may not be actually in effect, intended for 3D objects with solid centers
    bool _objectstackable;
    bool _objectheavy;
    float _collisionyoffset;
    bool _objectonhorizon;
    bool _objectusemode; //throwable, usable
    float _usableposXoffsetanim;
    float _usableposYoffsetanim;
    float _usableposZoffsetanim;
    float _usableanimtoggle;
    bool _isasubobject; //or a non-player-interactable object, like a horizon object
    bool _isahillgradientobject; //for gradual "climbs" to the center of the object (NOT YET FINISHED)
    float _hillHeight;
    int _isanaudioobject; //no, yes-plays once when in range, yes-loops when in range
    float _audiorange; //distance to player
    int _audiolength; //for loops, will be only accurate to current FPS of game
    int _audiolengthcount;
    int _audioid; //links to a specific sound later on
    bool _audioPLAY;
    bool _isinvisibleparentobject; //cancels some calculations
    int _isafloorobject; //no, 1=sprite floor (obsolete), 2=horizontal polygon, 3=vertical polygon
    int _floorzorderoffset;
    bool _isasmallobject;
    int _effectTimer; //unused in chromavera 2
    int _effectTimer2; //unused in chromavera 2
    int _effectType; //unused in chromavera 2
    bool _isaparticle;
    float _particleDilation;
    float _particleDilationRate;
    int _exemptFromPlayerCollisionsTimer;
    int _deleteObject; //serves as a timer
    bool _canbePickedUp; //coins, weapons, etc.
    bool _hasbeenPickedUp; //will be deleted when this is active
    int _polygonSides; //max = 10, min = 2 (lines experimental)
    float _polygonRadius;
    float _polygonColorRed;
    float _polygonColorGreen;
    float _polygonColorBlue;
    float _polygonColorAlpha;
    float _polygonShade; //default value = fully lit/unshaded
    bool _liquidBase; //determines whether being over this (floor) object triggers swimming/floating animations
    float _liquidViscosity; //determines speed & sludginess of traveling through liquid, 1.0 = normal walking speed, 0.0 = stuck
    float _overLiquidViscosity;
    bool _overLiquidBase; //triggers floating animations ONLY IF interactive object w/ collisions
    float _oLBfuncX; //timing of float animations
    float _oLBfuncYoffset; //actual Y offset of object
    bool _overAnotherFloatingObject;
    
    float _customOpacity; //from 0.0 to 1.0
    
    bool _vrUIelement; //turns off 3D positioning, stays a set distance from player
    int _objectBeingSynced;
    
    bool _objectBeingHighlighted;
    
    NSMutableArray *_subObjectComponents;
    int _colorIDrefresh;
    int _colorExposeID; //colorID at which object becomes not-black
}

@property (nonatomic, assign) int uniqueobjectid;
@property (nonatomic, assign) int parentobjectid;
@property (nonatomic, assign) float pospreXoffset;
@property (nonatomic, assign) float pospreYoffset;
@property (nonatomic, assign) float pospreYoffset2;
@property (nonatomic, assign) float pospreZoffset;
@property (nonatomic, assign) float posXoffset;
@property (nonatomic, assign) float posYoffset;
@property (nonatomic, assign) float posZoffset;
@property (nonatomic, assign) float posX;
@property (nonatomic, assign) float posY;
@property (nonatomic, assign) float posZ;
@property (nonatomic, assign) float postposX;
@property (nonatomic, assign) float postposY;
@property (nonatomic, assign) float postposZ;
@property (nonatomic, assign) float preposX;
@property (nonatomic, assign) float preposY;
@property (nonatomic, assign) float preposZ;
@property (nonatomic, assign) float calcX1;
@property (nonatomic, assign) float calcY1;
@property (nonatomic, assign) float calcZ1;
@property (nonatomic, assign) float calcZ2;
@property (nonatomic, assign) float calcZ3;
@property (nonatomic, assign) float finalposX;
@property (nonatomic, assign) float finalposY;
@property (nonatomic, assign) float objectScaleX;
@property (nonatomic, assign) float objectScaleY;
@property (nonatomic, assign) int actual2DZorder;
@property (nonatomic, assign) float rotationoffsetx;
@property (nonatomic, assign) float rotationoffsetx2;
@property (nonatomic, assign) float rotationscalevar1;
@property (nonatomic, assign) float rotationscalevar2;
@property (nonatomic, assign) float rotationtargetoffsetx2;
@property (nonatomic, assign) int randomflipped;
@property (nonatomic, assign) float standardScale;
@property (nonatomic, assign) float standardHeight;
@property (nonatomic, assign) bool dontVaryPerspective;
@property (nonatomic, assign) int texturePerspective;
@property (nonatomic, assign) int objecttag;
@property (nonatomic, assign) int objectid;
@property (nonatomic, assign) float FOVrotationobjectvar1;
@property (nonatomic, assign) float FOVrotationobjectvar2;
@property (nonatomic, assign) float FOVrotationobjectvar3;
@property (nonatomic, assign) float FOVrotationobjectvar4;
@property (nonatomic, assign) float posXmomentum;
@property (nonatomic, assign) float posYmomentum;
@property (nonatomic, assign) float posZmomentum;
@property (nonatomic, assign) bool refreshminypos;
@property (nonatomic, assign) float hypotenusetoplayer;
@property (nonatomic, assign) float PREangletoplayer;
@property (nonatomic, assign) float angletoplayer;
@property (nonatomic, assign) float objecttoplayerradius;
@property (nonatomic, assign) float objecttoobjectradius;
@property (nonatomic, assign) bool objectgrabbed;
@property (nonatomic, assign) bool spawnpartnerobjects;
@property (nonatomic, assign) bool playerusable;
@property (nonatomic, assign) bool objectusesgravity;
@property (nonatomic, assign) int objectusescollisions;
@property (nonatomic, assign) bool objectusessubobjects;
@property (nonatomic, assign) int objectdistancetoggle;
@property (nonatomic, assign) float minyposition;
@property (nonatomic, assign) float mininitialyposition;
@property (nonatomic, assign) float rotationoffsetvar1;
@property (nonatomic, assign) float rotationoffsetvar2;
@property (nonatomic, assign) bool changescaleX;
@property (nonatomic, assign) bool changescaleY;
@property (nonatomic, assign) bool objectinvisible;
@property (nonatomic, assign) float objectScaleXOffset;
@property (nonatomic, assign) float objectScaleYOffset;
@property (nonatomic, assign) bool parentsubinvisiblewhenscalenegative;
@property (nonatomic, assign) bool objectstackable;
@property (nonatomic, assign) bool objectheavy;
@property (nonatomic, assign) float collisionyoffset;
@property (nonatomic, assign) bool objectonhorizon;
@property (nonatomic, assign) bool objectusemode;
@property (nonatomic, assign) float usableposXoffsetanim;
@property (nonatomic, assign) float usableposYoffsetanim;
@property (nonatomic, assign) float usableposZoffsetanim;
@property (nonatomic, assign) float usableanimtoggle;
@property (nonatomic, assign) bool isasubobject;
@property (nonatomic, assign) bool isahillgradientobject;
@property (nonatomic, assign) float hillHeight;
@property (nonatomic, assign) int isanaudioobject;
@property (nonatomic, assign) float audiorange;
@property (nonatomic, assign) int audiolength;
@property (nonatomic, assign) int audiolengthcount;
@property (nonatomic, assign) int audioid;
@property (nonatomic, assign) bool audioPLAY;
@property (nonatomic, assign) bool isinvisibleparentobject;
@property (nonatomic, assign) int isafloorobject;
@property (nonatomic, assign) int floorzorderoffset;
@property (nonatomic, assign) bool isasmallobject;
@property (nonatomic, assign) int effectTimer;
@property (nonatomic, assign) int effectTimer2;
@property (nonatomic, assign) int effectType;
@property (nonatomic, assign) bool isaparticle;
@property (nonatomic, assign) float particleDilation;
@property (nonatomic, assign) float particleDilationRate;
@property (nonatomic, assign) int exemptFromPlayerCollisionsTimer;
@property (nonatomic, assign) int deleteObject;
@property (nonatomic, assign) bool canbePickedUp;
@property (nonatomic, assign) bool hasbeenPickedUp;
@property (nonatomic, assign) int polygonSides;
@property (nonatomic, assign) float polygonRadius;
@property (nonatomic, assign) float polygonColorRed;
@property (nonatomic, assign) float polygonColorGreen;
@property (nonatomic, assign) float polygonColorBlue;
@property (nonatomic, assign) float polygonColorAlpha;
@property (nonatomic, assign) float polygonShade;
@property (nonatomic, assign) bool liquidBase;
@property (nonatomic, assign) float liquidViscosity;
@property (nonatomic, assign) float overLiquidViscosity;
@property (nonatomic, assign) bool overLiquidBase;
@property (nonatomic, assign) float oLBfuncX;
@property (nonatomic, assign) float oLBfuncYoffset;
@property (nonatomic, assign) bool overAnotherFloatingObject;
@property (nonatomic, assign) float FGOposXmomentum;
@property (nonatomic, assign) float FGOposYmomentum;
@property (nonatomic, assign) float FGOposZmomentum;
@property (nonatomic, assign) bool vrUIelement;
@property (nonatomic, assign) float customOpacity;
@property (nonatomic, assign) int objectBeingSynced;
@property (nonatomic, assign) bool objectBeingHighlighted;
@property (nonatomic, retain) NSMutableArray *subObjectComponents;
@property (nonatomic, assign) int colorIDrefresh;
@property (nonatomic, assign) int colorExposeID;

@end

@interface vr1 : object {
}
+(id)vrElement1;
@end

@interface vr1_1 : object {
}
+(id)vrElement1_1;
@end

@interface vr1_2 : object {
}
+(id)vrElement1_2;
@end

@interface vr2 : object {
}
+(id)vrElement2;
@end

@interface vr3 : object {
}
+(id)vrElement3;
@end

@interface vr4 : object {
}
+(id)vrElement4;
@end

@interface vr5 : object {
}
+(id)vrElement5;
@end

@interface vr6 : object {
}
+(id)vrElement6;
@end

@interface vr6_2 : object {
}
+(id)vrElement6_2;
@end

@interface vr_k : object {
}
+(id)vrKey;
@end

@interface vr_kw1 : object {
}
+(id)vrKeyText1;
@end

@interface vr_kw2 : object {
}
+(id)vrKeyResetButton;
@end

@interface vr_kw3 : object {
}
+(id)vrEyeDist;
@end

@interface vr_kw4 : object {
}
+(id)vrEyeDistBar;
@end

@interface vr_kw5 : object {
}
+(id)vrEyeDistTicker;
@end

@interface pool1 : object {
}
+(id)pool1test;
@end

@interface pool2 : object {
}
+(id)pool2test;
@end

@interface pool3 : object {
}
+(id)pool3test;
@end

@interface arrow1 : object {
}
+(id)arrowHelp1;
@end

@interface spaceEnv1 : object {
}
+(id)spaceShine;
@end

@interface rock3 : object {
}
+(id)rockAsteroid1;
@end

@interface rock4 : object {
}
+(id)rockAsteroid2;
@end

@interface star1 : object {
}
+(id)star1White;
@end

@interface spaceEnv2 : object {
}
+(id)spaceShine2;
@end

@interface part1 : object {
}
+(id)particleDistCloud;
@end

@interface star2 : object {
}
+(id)star2Planet;
@end

@interface star2ring : object {
}
+(id)star2PlanetRing;
@end

@interface part2 : object {
}
+(id)particleWaterParticle;
@end

@interface rock5 : object {
}
+(id)rockAsteroid3;
@end

@interface rock6 : object {
}
+(id)rockAsteroid4;
@end

@interface vr7 : object {
}
+(id)vrElement7;
@end

@interface vr7_2 : object {
}
+(id)vrElement7_2;
@end

@interface chair1 : object {
}
+(id)chairRed1;
@end

@interface wheel1 : object {
}
+(id)wheelDriver1;
@end

@interface gun1 : object {
}
+(id)gunPart1;
@end

@interface gun2 : object {
}
+(id)gunMissile;
@end

@interface expl1 : object {
}
+(id)explParticle1;
@end

@interface rock7 : object {
}
+(id)rockFinishFlag;
@end

@interface vr8 : object {
}
+(id)vrElement8;
@end

@interface vr9 : object {
}
+(id)vrElement9;
@end
