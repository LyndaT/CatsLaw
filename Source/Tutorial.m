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
        [cat stopCat];
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
    [player goCat];
}

@end
