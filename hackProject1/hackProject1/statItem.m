#import "statItem.h"
#define CC_RETINA_DISPLAY_FILENAME_SUFFIX @"-hd"

@implementation statItem
@end

@implementation ground
+ (id)groundItem {
    statItem *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"ground1.png"])) {
        item.statitemid = 0;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            item.scaleX = 6.4;
            item.scaleY = 3.0;
        } else {
            item.scaleX = 3.2;
            item.scaleY = 2.4;
        }
        
        //chromavera-specific
        item.colorExposeIDsi = 3;
    }
    return item;
}
@end

@implementation sky
+ (id)skyItem {
    statItem *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"sky1.png"])) {
        item.statitemid = 1;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            item.scaleX = 6.4;
            item.scaleY = 3.0;
        } else {
            item.scaleX = 3.2;
            item.scaleY = 2.4;
        }
        
        //chromavera-specific
        item.colorExposeIDsi = 2;
    }
    return item;
}
@end

@implementation ground2
+ (id)groundItem2 {
    statItem *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"floorshade.png"])) {
        item.statitemid = 2;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            item.scaleX = 6.4;
            item.scaleY = 4.4;
        } else {
            item.scaleX = 3.2;
            item.scaleY = 2.4;
        }
        
    }
    return item;
}
@end

@implementation ground_3
+ (id)groundItemSpace {
    statItem *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"ground3_2.png"])) {
        item.statitemid = 0;
        item.statitemsubid = 2;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            item.scaleX = 6.4;
            item.scaleY = 3.0;
        } else {
            item.scaleX = 3.2;
            item.scaleY = 2.4;
        }
        
        //chromavera-specific
        item.colorExposeIDsi = 2;
    }
    return item;
}
@end

@implementation sky_3
+ (id)skyItemSpace {
    statItem *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"sky3_2.png"])) {
        item.statitemid = 1;
        item.statitemsubid = 2;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            item.scaleX = 6.4;
            item.scaleY = 3.0;
        } else {
            item.scaleX = 3.2;
            item.scaleY = 2.4;
        }
        
        //chromavera-specific
        item.colorExposeIDsi = 2;
    }
    return item;
}
@end
