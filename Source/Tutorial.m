//
//  Tutorial.m
//  CatsLaw
//
//  Created by Lynda Tang on 3/8/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Tutorial.h"
#import "Globals.h"
#import "Cat.h"
#import "GamePlay.h"

@implementation Tutorial {
    CCAnimationManager* animationManager;
    Globals *globals;
    GamePlay* game;
    Cat* player;
    
    CCNode *tutorialAnim;
    NSString *tutorialAnimString;
    
    BOOL hasPlayed; //so tutorial only plays once
    BOOL shouldPause; //to differentiate between actual popups and just overlay text
}

- (id) init {
    if (self = [super init]) {
        globals = [Globals globalManager];
        hasPlayed = NO;
    }
    return self;
}

- (void)didLoadFromCCB {
    animationManager = self.animationManager;
    self.physicsBody.collisionType = @"tutorial";
    self.physicsBody.sensor = TRUE; //so cat can overlap with it
    
    tutorialAnimString = [NSString stringWithFormat:@"tutorial/%@", tutorialAnimString];
    tutorialAnim = [CCBReader load:tutorialAnimString owner:self];
    tutorialAnim.position = ccp(globals.screenSize.width/2, globals.screenSize.height/2);
}

- (void) callOnCollision:(Cat*)cat gameplayHolder:(GamePlay *)gameplay{
    CCLOG(@"TUTORIAL!!!");
    if (!hasPlayed){
        if (shouldPause){
            [cat stopCat];
        }
        player = cat;
        game = gameplay;
        [self runTutorial];
    }
}

- (void)runTutorial {
    CCLOG(@"%@",tutorialAnimString);
    hasPlayed = YES;
    [game addChild:tutorialAnim];
}

- (void)close {
    CCLOG(@"close tut");
    [game removeChild:tutorialAnim];
    if (shouldPause){
        [player goCat];
    }
}

//opens the question mark bubble for players to tap
- (void)openBubble {
    if (shouldPause){
        [player stopCat];
    }
}

- (void)bubbleClick {
    [self runTutorial];
}

//-----------------------------methods for player verification

//door tut done when cat goes through door
- (void)door {
    [self close];
}

//turn done first time player changes gravity on that level
- (void)turn {
    
}

//cling done when player does a 180 WHILE clinging
- (void)cling {
    
}

@end
