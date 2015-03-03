//
//  LevelButton.m
//  CatsLaw
//
//  Created by Lili Sun on 3/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LevelButton.h"
#import "Globals.h"

@implementation LevelButton{
    CCLabelTTF* label;
    
    int level;
    Globals *globals;
}

- (id)init {
    if (self = [super init]) {
        globals = [Globals globalManager];
    }
    return self;
}

- (void)setLevel: (int)lvl {
    level=lvl;
    label.string = [NSString stringWithFormat:@"%i",(level+1)];
}

- (void)play {
    [globals setLevel:(level+1)];
    globals.currentSceneName = @"scenes/GamePlay";
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:globals.currentSceneName]];
}

@end
