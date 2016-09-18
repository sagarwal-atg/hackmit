#import "menuItem.h"
#define CC_RETINA_DISPLAY_FILENAME_SUFFIX @"-hd"

@implementation menuItem
@end

@implementation joystickbg

+ (id)joystickbgItem {
    menuItem *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"joystickbg.png"])) {
        item.itemid = 0;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            item.scale = 2.1;
        } else {
            item.scale = 1.4;
        }
        item.opacity = 90.0/255.0;
        item.itemopacity = item.opacity;
    }
    return item;
}

@end

@implementation joystick

+ (id)joystickItem {
    menuItem *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"joystick.png"])) {
        item.itemid = 1;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            item.scale = 1.05;
        } else {
            item.scale = 0.7;
        }
        item.opacity = 255.0/255.0;
        item.itemopacity = item.opacity;
    }
    return item;
}

@end

@implementation action

+ (id)actionbuttonItem {
    menuItem *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"buttonaction.png"])) {
        item.itemid = 2;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            item.scale = 1.0;
        } else {
            item.scale = 0.75;
        }
        item.opacity = 160.0/255.0;
        item.itemopacity = item.opacity;
    }
    return item;
}

@end

@implementation jump

+ (id)jumpbuttonItem {
    menuItem *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"buttonjump.png"])) {
        item.itemid = 3;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            item.scale = 1.0;
        } else {
            item.scale = 0.75;
        }
        item.opacity = 160.0/255.0;
        item.itemopacity = item.opacity;
    }
    return item;
}

@end

@implementation iovBG

+ (id)iovBGarrow {
    menuItem *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"IVarrow.png"])) {
        item.itemid = 4;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            item.scale = 0.15;
        } else {
            item.scale = 0.12;
        }
        item.opacity = 150.0/255.0;
        item.itemopacity = item.opacity;
    }
    return item;
}

@end

@implementation vrButton

+ (id)vrButtonItem {
    menuItem *item = nil;
    if ((item = [[super alloc] initWithImageNamed:@"buttonvr.png"])) {
        item.itemid = 5;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            item.scale = 0.6;
        } else {
            item.scale = 0.75*0.6;
        }
        item.opacity = 160.0/255.0;
        item.itemopacity = item.opacity;
    }
    return item;
}

@end