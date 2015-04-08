//
//  Cutscene.m
//  CatsLaw
//
//  Created by Lili Sun on 3/30/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Cutscene.h"
#import "Globals.h"

@implementation Cutscene{
    Globals *globals;
    
    //from spritebuilder
    float levelRotation;
    int nextLevel;
    BOOL isCutsceneNext;
}

- (id) init {
    if (self = [super init]) {
        globals = [Globals globalManager];
    }
    return self;
}

- (void)next{
    CCLOG(@"cutscene over");
    [globals setLevel:nextLevel];
    CCScene *gameplayScene = [CCBReader loadAsScene:@"scenes/GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
