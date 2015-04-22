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
    
    CCNode *tutorialAnim;
    NSString *tutorialAnimString;
    CCNode *bubble;
    CCNode* game;
    Cat* player;
    
    //from spriteb
    BOOL shouldPause; //to differentiate between actual popups and just overlay text
    BOOL shouldRotate; //for whether the cat should move during tut or not
    
    BOOL hasPlayed; //so tutorial only plays once when you collide
    BOOL isPlaying; //if the tutorial is currently playing
    BOOL bubbleOpen;
    
    BOOL hasCompleted; //if player did what the tutorial wants them to. used for cling and turn
}

- (id) init {
    if (self = [super init]) {
        globals = [Globals globalManager];
        hasPlayed = NO;
        isPlaying = NO;
        hasCompleted = NO;
        bubbleOpen = NO;
    }
    return self;
}

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"tutorial";
    self.physicsBody.sensor = TRUE; //so cat can overlap with it
    
    tutorialAnimString = [NSString stringWithFormat:@"tutorial/%@", tutorialAnimString];
    tutorialAnim = [CCBReader load:tutorialAnimString owner:self];
    animationManager = tutorialAnim.animationManager;
    
    bubble = [CCBReader load:@"tutorial/bubble" owner:self];
    bubble.scale = 0.75;
    bubble.position = ccp(0, 0-globals.screenSize.height/4);
}

- (void) callOnCollision:(Cat*)cat gameplayHolder:(GamePlay *)gameplay tutNode:(CCNode *)tut{
    CCLOG(@"TUTORIAL!!!");
    if (!hasPlayed){
        if (shouldPause){
            [cat stopCat];
        }
        player = cat;
        game = tut;
        [self runTutorial];
    }
}

- (void)runTutorial {
    CCLOG(@"%@",tutorialAnimString);
    if (!hasPlayed){
        hasPlayed = YES;
        [game addChild:tutorialAnim];
    }else {
        tutorialAnim.visible = YES;
    }
    isPlaying = YES;
    [animationManager runAnimationsForSequenceNamed:@"Default Timeline"];
}

- (void)close {
    CCLOG(@"close tut");
    if (isPlaying){
        isPlaying = NO;
        tutorialAnim.visible = NO;
        [game removeChild:tutorialAnim];
        if (shouldPause){
            [player goCat];
            
            //shows questionmark bubble after 10 sec
            //        [self scheduleOnce:@selector(openBubble) delay:10.0f];
        }
    }
}

//opens the question mark bubble for players to tap
- (void)openBubble {
    if (!hasCompleted){
        CCLOG(@"open tha bubbz");
        isPlaying = YES;
        bubbleOpen = YES;
//        [player stopCat];
        [game addChild:bubble];
    }
}

- (void)bubbleClick {
    [game removeChild:bubble];
    bubbleOpen = NO;
    if (shouldPause){
        [player stopCat];
    }
    [self runTutorial];
}

//-----------------------------methods for player verification
//called by gameplay when the player does the required move

//door tut done when cat goes through door
- (void)door {
    [self close];
}

//we want the cat to remain on the ground during part of the cling tutorial
//so this is for that
- (BOOL)shouldRotate {
    if (hasCompleted){
        return YES;
    }
    return shouldRotate;
}

//turn done first time player changes gravity on that level
- (void)turn {
    CCLOG(@"turn done");
    [self close];
    hasCompleted = YES;
    if (bubbleOpen){
        [game removeChild:bubble];
        bubbleOpen = NO;
    }
}

//cling done when player does a 180 WHILE clinging
- (void)cling {
    CCLOG(@"cling done");
    [self close];
    hasCompleted = YES;
    if (bubbleOpen){
        [game removeChild:bubble];
        bubbleOpen = NO;
    }
}

- (void)clingHold {
    CCLOG(@"cling hold");
    if (isPlaying){
        [game removeChild:tutorialAnim];
        tutorialAnim = [CCBReader load:@"tutorial/clingTurn" owner:self];
        [game addChild:tutorialAnim];
    }
}

@end
