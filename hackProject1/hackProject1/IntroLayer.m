#import "IntroLayer.h"
#import "HelloWorldLayer.h"

@implementation IntroLayer

-(void) makeTransition {
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer new] withTransition:[CCTransition transitionFadeWithDuration:0.4]];
}

-(id) init {
    self = [super init];
    
    [self scheduleOnce:@selector(makeTransition) delay:1.1];
    
	return self;
}

@end
