//
//  Grass.m
//  CatsLaw
//
//  Created by Lili Sun on 3/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Grass.h"
#import "GamePlay.h"
#import "Cat.h"

@implementation Grass{
    BOOL isRight; //to tell which direction the grass should send you in
}

- (void)didLoadFromCCB
{
    self.physicsBody.sensor = TRUE; //so cat can overlap with it
}

//called upon cat water collision
//should put game in gameOver state
- (void) callOnCollision:(Cat*)cat gameplayHolder:(GamePlay *)gameplay{
    CCLOG(@"entering grass");
    if (isRight){
        [cat setDirection:1];
    }else{
        [cat setDirection:-1];
    }
}

@end
