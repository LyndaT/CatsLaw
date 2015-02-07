//
//  GamePlay.m
//  CatsLaw
//
//  Created by Lili Sun on 2/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay{
    CCPhysicsNode *_physNode;
    CCNode *_levelNode;
}

- (id)init {
    if (self = [super init]) {
        //init stuff
    }
    return self;
}

- (void)didLoadFromCCB {
    CCNode *currentLevel = [CCBReader load:@"Levels/Level1"];
    
    [_levelNode addChild:currentLevel];
}

@end
