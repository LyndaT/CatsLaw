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
    CCNode *bubble;
    
    BOOL hasPlayed; //so tutorial only plays once when you collide
    BOOL shouldPause; //to differentiate between actual popups and just overlay text
    BOOL isPlaying; //if the tutorial is currently playing
    
    BOOL hasCompleted; //if player did what the tutorial wants them to. used for cling and turn
}

- (id) init {
    if (self = [super init]) {
        globals = [Globals globalManager];
        hasPlayed = NO;
        isPlaying = NO;
        hasCompleted = NO;
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
    
    bubble = [CCBReader load:@"tutorial/bubble" owner:self];
    bubble.position = ccp(globals.screenSize.width/2, globals.screenSize.height/2);
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
    isPlaying = YES;
    [game addChild:tutorialAnim];
}

- (void)close {
    CCLOG(@"close tut");
    isPlaying = NO;
    [game removeChild:tutorialAnim];
    if (shouldPause){
        [player goCat];
        
        //shows questionmark bubble after 10 sec
        [self scheduleOnce:@selector(openBubble) delay:10.0f];
    }
}

//opens the question mark bubble for players to tap
- (void)openBubble {
    if (!hasCompleted){
        CCLOG(@"open tha bubbz");
        isPlaying = YES;
        [player stopCat];
        [game addChild:bubble];
        //TODO: place bubble above player
        //smth with if player orientation = blah, position = (x+dx, y+dy)
    }
}

- (void)bubbleClick {
    [game removeChild:bubble];
    [self runTutorial];
}

//-----------------------------methods for player verification
//called by gameplay when the player does the required move

//door tut done when cat goes through door
- (void)door {
    [self close];
}

//turn done first time player changes gravity on that level
- (void)turn {
    CCLOG(@"turn done");
    if (!isPlaying){
        hasCompleted = YES;
    }
}

//cling done when player does a 180 WHILE clinging
- (void)cling {
    CCLOG(@"cling done");
    if (!isPlaying){
        hasCompleted = YES;
    }
}

@end
