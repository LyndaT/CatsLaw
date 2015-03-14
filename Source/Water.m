//
//  Water.m
//  CatsLaw
//
//  Created by Jenny Lin on 3/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Water.h"
#import "GamePlay.h"

@implementation Water

//called upon cat water collision
//should put game in gameOver state
- (void) callOnCollision:(Cat*)cat gameplayHolder:(GamePlay *)gameplay{
    [gameplay gameOver: @"water"];
}


//probably shouldn't be called since cat is dead…
- (void) callOnSeperation:(Cat*)cat gameplayHolder:(GamePlay *)gameplay{
    CCLOG(@"leaving water");
}

@end
