//
//  Cake.m
//  CatsLaw
//
//  Created by Lili Sun on 2/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Cake.h"
#import "Globals.h"

@implementation Cake{
    Globals *globals;
    CCAnimationManager* animationManager;
}

- (void)didLoadFromCCB
{
    animationManager = self.animationManager;
    self.physicsBody.collisionType = @"cake";
    self.physicsBody.sensor = TRUE; //so cat can overlap with it
}

- (void)pulse{
    [animationManager runAnimationsForSequenceNamed:@"pulse"];
}

- (void)gone{
    [self removeFromParentAndCleanup:YES];
}

- (void)eat{
    //[globals.audio playEffect:@"assets/music/cakeget.mp3"];
    [animationManager runAnimationsForSequenceNamed:@"eat"];
}

@end
