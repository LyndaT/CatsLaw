#import "MainScene.h"

@implementation MainScene

- (id)init {
    if (self = [super init]) {
        //init stuff
    }
    return self;
}

- (void)didLoadFromCCB {
    
}

- (void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"scenes/GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
