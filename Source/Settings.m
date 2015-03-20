//
//  Settings.m
//  CatsLaw
//
//  Created by Lili Sun on 3/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Settings.h"
#import "Globals.h"

@implementation Settings{
    Globals *globals;
    
    CCButton *musicButton;
    CCButton *SFXButton;
}

- (id)init {
    if (self = [super init]) {
        globals = [Globals globalManager];
    }
    return self;
}

- (void)didLoadFromCCB {
    if (globals.isMusicOn)
    {
        [musicButton setTitle:@"ON"];
    }else
    {
        [musicButton setTitle:@"OFF"];
    }
    
    if (globals.isSFXOn)
    {
        [SFXButton setTitle:@"ON"];
    }else
    {
        [SFXButton setTitle:@"OFF"];
    }
}

- (void)music {
    CCLOG(@"music");
    
    if (globals.isMusicOn) //it was on, turn it off
    {
        [musicButton setTitle:@"OFF"];
        [globals setMusicOn:NO vol:0];
    }else
    {
        [musicButton setTitle:@"ON"];
        [globals setMusicOn:YES vol:1];
    }
}

- (void)sfx {
    CCLOG(@"sfx");
    
    if (globals.isSFXOn) //it was on, turn it off
    {
        [SFXButton setTitle:@"OFF"];
        [globals setSFXOn:NO vol:0];
    }else
    {
        [SFXButton setTitle:@"ON"];
        [globals setSFXOn:YES vol:1];
    }
}

- (void)resetData {
    [globals setHighestLevel:1];
    [globals setLevel:1];
}

- (void)credits {
    CCLOG(@"credits");
    globals.currentSceneName = @"scenes/Credits";
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:globals.currentSceneName]];
}

- (void)menu {
    globals.currentSceneName = @"MainScene";
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:globals.currentSceneName]];
}

@end
