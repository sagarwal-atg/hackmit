#import "inventoryObject.h"
#define CC_RETINA_DISPLAY_FILENAME_SUFFIX @"-hd"

@implementation inventoryObject
@end

@implementation blank
+ (id)blankIVO {
    inventoryObject *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"blankIVO.png"])) {
        item.IVOid = 0;
        item.IVOactionid = -1;
        item.IVOradius = 84;
        item.IVOinitialscale = 0.3;
        item.scale = 0.0;
        item.IVOinitialopacity = 255;
        item.opacity = 0.0;
        
        //default uses
        item.IVOuses = 1;
        item.IVOwastable = 1;
    }
    return item;
}
@end

@implementation handIV
+ (id)handIVO {
    inventoryObject *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"handIVO.png"])) {
        item.IVOid = 1;
        item.IVOactionid = 0;
        item.IVOradius = 84;
        item.IVOinitialscale = 0.3;
        item.scale = 0.0;
        item.IVOinitialopacity = 255;
        item.opacity = 0.0;
        
        //default uses
        item.IVOuses = 1;
        item.IVOwastable = 0;
    }
    return item;
}
@end

@implementation electricIV
+ (id)electricIVO {
    inventoryObject *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"electricityIVO.png"])) {
        item.IVOid = 2;
        item.IVOactionid = 1;
        item.IVOradius = 84;
        item.IVOinitialscale = 0.3;
        item.scale = 0.0;
        item.IVOinitialopacity = 255;
        item.opacity = 0.0;
        
        //default uses
        item.IVOuses = 1;
        item.IVOwastable = 1;
    }
    return item;
}
@end

@implementation recIV
+ (id)recordIVO {
    inventoryObject *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"recIVO.png"])) {
        item.IVOid = 3;
        item.IVOactionid = 2;
        item.IVOradius = 84;
        item.IVOinitialscale = 0.3;
        item.scale = 0.0;
        item.IVOinitialopacity = 255;
        item.opacity = 0.0;
        
        //default uses
        item.IVOuses = 1;
        item.IVOwastable = 0;
    }
    return item;
}
@end

@implementation playIV
+ (id)playIVO {
    inventoryObject *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"playIVO.png"])) {
        item.IVOid = 4;
        item.IVOactionid = 3;
        item.IVOradius = 84;
        item.IVOinitialscale = 0.3;
        item.scale = 0.0;
        item.IVOinitialopacity = 255;
        item.opacity = 0.0;
        
        //default uses
        item.IVOuses = 1;
        item.IVOwastable = 0;
    }
    return item;
}
@end

@implementation learnIV
+ (id)learnIVO {
    inventoryObject *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"learnIVO.png"])) {
        item.IVOid = 5;
        item.IVOactionid = 4;
        item.IVOradius = 84;
        item.IVOinitialscale = 0.3;
        item.scale = 0.0;
        item.IVOinitialopacity = 255;
        item.opacity = 0.0;
        
        //default uses
        item.IVOuses = 1;
        item.IVOwastable = 0;
    }
    return item;
}
@end

@implementation learnplayIV
+ (id)learnplayIVO {
    inventoryObject *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"learnplayIVO.png"])) {
        item.IVOid = 6;
        item.IVOactionid = 5;
        item.IVOradius = 84;
        item.IVOinitialscale = 0.3;
        item.scale = 0.0;
        item.IVOinitialopacity = 255;
        item.opacity = 0.0;
        
        //default uses
        item.IVOuses = 1;
        item.IVOwastable = 0;
    }
    return item;
}
@end

@implementation vrIV
+ (id)vrIVO {
    inventoryObject *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"launchvrIVO.png"])) {
        item.IVOid = 7;
        item.IVOactionid = 6;
        item.IVOradius = 84;
        item.IVOinitialscale = 0.3;
        item.scale = 0.0;
        item.IVOinitialopacity = 255;
        item.opacity = 0.0;
        
        //default uses
        item.IVOuses = 1;
        item.IVOwastable = 0;
    }
    return item;
}
@end