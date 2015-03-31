//
//  Cutscene.m
//  CatsLaw
//
//  Created by Lili Sun on 3/30/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Cutscene.h"

@implementation Cutscene{
    
    //from spritebuilder
    float levelRotation;
    int nextLevel;
    BOOL isCutsceneNext;
}

- (void)next{
    CCLOG(@"cutscene over");
    CCScene *gameplayScene = [CCBReader loadAsScene:@"scenes/GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
