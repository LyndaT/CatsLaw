//
//  GamePlay.m
//  CatsLaw
//
//  Created by Lili Sun on 2/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay{
    CCNode *currentLevel;
    CCNode *cat;
    
    //from SpriteBuilder
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
    currentLevel = [CCBReader load:@"Levels/TestLevel"];
    cat = [CCBReader load:@"Sprites/Cat"];
    cat.scaleX=0.3;
    cat.scaleY=0.3;
    
    [_levelNode addChild:currentLevel];
    [_physNode addChild:cat];
}

@end
