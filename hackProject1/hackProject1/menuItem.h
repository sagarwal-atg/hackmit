#import "CCSprite.h"

@interface menuItem : CCSprite {
    int _itemposx;
    int _itemposy;
    int _itemid;
    float _hypotenusetoitem;
    float _hypotenusetoitem2;
    float _itemopacity;
    float _itemscale;
    float _iteminitialscale;
    bool _itemtappedinitially;
    float _iteminitialposx;
    float _iteminitialposy;
    float _itemScaleOffset;
    float _itemPosXOffset;
    float _itemPosYOffset;
}

@property (nonatomic, assign) int itemposX;
@property (nonatomic, assign) int itemposY;
@property (nonatomic, assign) int itemid;
@property (nonatomic, assign) float hypotenusetoitem;
@property (nonatomic, assign) float hypotenusetoitem2;
@property (nonatomic, assign) float itemopacity;
@property (nonatomic, assign) float itemscale;
@property (nonatomic, assign) float iteminitialscale;
@property (nonatomic, assign) bool itemtappedinitially;
@property (nonatomic, assign) float iteminitialposx;
@property (nonatomic, assign) float iteminitialposy;
@property (nonatomic, assign) float itemScaleOffset;
@property (nonatomic, assign) float itemPosXOffset;
@property (nonatomic, assign) float itemPosYOffset;

@end

@interface joystickbg : menuItem {
}
+(id)joystickbgItem;
@end

@interface joystick : menuItem {
}
+(id)joystickItem;
@end

@interface action : menuItem {
}
+(id)actionbuttonItem;
@end

@interface jump : menuItem {
}
+(id)jumpbuttonItem;
@end

@interface iovBG : menuItem {
}
+(id)iovBGarrow;
@end

@interface vrButton : menuItem {
}
+(id)vrButtonItem;
@end