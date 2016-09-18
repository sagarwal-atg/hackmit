#import "CCSprite.h"

@interface inventoryObject : CCSprite {
    float _IVOposX;
    float _IVOposY;
    int _IVOid;
    int _IVOactionid; //normal, electricity
    int _IVOslotid; //position in slide bar
    float _IVOslotidposition; //used for position transitions
    bool _IVOAddedToInventory;
    float _IVOinitialscale;
    float _IVOscale;
    float _IVOinitialopacity;
    float _IVOopacity;
    float _IVOradius;
    float _IVOdilationVar1;
    float _IVOdilationVar2;
    float _IVOdilationVar3;
    bool _IVObeingdeleted;
    int _IVOuses; //number of times an item can be used
    int _IVOwastable; //determines whether an object can be "used up" --- 0=permanent, 1=expirable, 2=can be reloaded
}

@property (nonatomic, assign) float IVOposX;
@property (nonatomic, assign) float IVOposY;
@property (nonatomic, assign) int IVOid;
@property (nonatomic, assign) int IVOactionid;
@property (nonatomic, assign) int IVOslotid;
@property (nonatomic, assign) float IVOslotidposition;
@property (nonatomic, assign) bool IVOAddedToInventory;
@property (nonatomic, assign) float IVOinitialscale;
@property (nonatomic, assign) float IVOscale;
@property (nonatomic, assign) float IVOinitialopacity;
@property (nonatomic, assign) float IVOopacity;
@property (nonatomic, assign) float IVOradius;
@property (nonatomic, assign) float IVOdilationVar1;
@property (nonatomic, assign) float IVOdilationVar2;
@property (nonatomic, assign) float IVOdilationVar3;
@property (nonatomic, assign) bool IVObeingdeleted;
@property (nonatomic, assign) int IVOuses;
@property (nonatomic, assign) int IVOwastable;

@end

@interface blank : inventoryObject {
}
+(id)blankIVO;
@end

@interface handIV : inventoryObject {
}
+(id)handIVO;
@end

@interface electricIV : inventoryObject {
}
+(id)electricIVO;
@end

@interface recIV : inventoryObject {
}
+(id)recordIVO;
@end

@interface playIV : inventoryObject {
}
+(id)playIVO;
@end

@interface learnIV : inventoryObject {
}
+(id)learnIVO;
@end

@interface learnplayIV : inventoryObject {
}
+(id)learnplayIVO;
@end

@interface vrIV : inventoryObject {
}
+(id)vrIVO;
@end