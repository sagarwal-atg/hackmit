#import "CCSprite.h"

@interface statItem : CCSprite {
    float _statitemposx;
    float _statitemposy;
    float _statitemscalex;
    float _statitemscaley;
    int _statitemid;
    int _statitemsubid;
    int _colorExposeIDsi;
    int _colorIDrefreshsi;
}

@property (nonatomic, assign) float statitemposx;
@property (nonatomic, assign) float statitemposy;
@property (nonatomic, assign) float statitemscalex;
@property (nonatomic, assign) float statitemscaley;
@property (nonatomic, assign) int statitemid;
@property (nonatomic, assign) int statitemsubid;
@property (nonatomic, assign) int colorExposeIDsi;
@property (nonatomic, assign) int colorIDrefreshsi;

@end

@interface ground : statItem {
}
+(id)groundItem;
@end

@interface sky : statItem {
}
+(id)skyItem;
@end

@interface ground2 : statItem {
}
+(id)groundItem2;
@end

@interface ground_3 : statItem {
}
+(id)groundItemSpace;
@end

@interface sky_3 : statItem {
}
+(id)skyItemSpace;
@end
