//
//  Ground.m
//  CatsLaw
//
//  Created by Jenny Lin on 3/8/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Ground.h"

@implementation Ground

//called upon cat water collision
//should put game in gameOver state
- (void) callOnCollision:(Cat*)cat gameplayHolder:(GamePlay *)gameplay{
    cat.onGround = YES;
}


//probably shouldn't be called since cat is dead…
- (void) callOnSeperation:(Cat*)cat gameplayHolder:(GamePlay *)gameplay{
    cat.onGround = NO;
}

@end
