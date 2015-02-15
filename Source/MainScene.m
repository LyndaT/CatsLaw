#import "MainScene.h"
#import "Globals.h"

@implementation MainScene {
    Globals *globals;
    BOOL isFirstTime;
}

- (id)init {
    if (self = [super init]) {
        globals = [Globals globalManager];
    }
    return self;
}

- (void)didLoadFromCCB {
    if (globals.highestLevel == nil || globals.highestLevel == 1) {
        isFirstTime=YES;
    }else
    {
        isFirstTime=NO;
    }
    
    // play background sound
//    [_globals.audio playBg:@"assets/music/MenuMusic.mp3" loop:TRUE];
}


- (void)play {
    if (isFirstTime){
        globals.currentSceneName = @"scenes/GamePlay";//[CCBReader loadAsScene:@"scenes/GamePlay"];
        CCLOG(@"gameplay");
    }
    else {
        globals.currentSceneName = @"scenes/LevelSelect";//[CCBReader loadAsScene:@"scenes/LevelSelect"];
        CCLOG(@"levelsel");
    }
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:globals.currentSceneName]];
}

@end
