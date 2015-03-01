//
//  LevelSelect.m
//  CatsLaw
//
//  Created by Lili Sun on 3/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LevelSelect.h"
#import "Globals.h"

@implementation LevelSelect{
    Globals *globals;
}

- (id)init {
    if (self = [super init]) {
        globals = [Globals globalManager];
    }
    return self;
}

- (void)play{
    globals.currentSceneName = @"scenes/GamePlay";
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:globals.currentSceneName]];
}

@end
