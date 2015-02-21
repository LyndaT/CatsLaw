//
//  Door.m
//  CatsLaw
//
//  Created by Lili Sun on 2/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Door.h"

@implementation Door{
    CCAnimationManager* animationManager;
}

@synthesize isUnlocked;

- (void)didLoadFromCCB
{
    animationManager = self.animationManager;
    self.physicsBody.collisionType = @"door";
    self.physicsBody.sensor = TRUE; //so cat can overlap with it
    isUnlocked=NO;
}

- (void)unlock{
    isUnlocked=YES;
    [animationManager runAnimationsForSequenceNamed:@"unlock"];
}

- (void)lock{
    isUnlocked=NO;
    [animationManager runAnimationsForSequenceNamed:@"lock"];
}

- (void)hover{
    [animationManager runAnimationsForSequenceNamed:@"hover"];
}

- (void)open{
    [animationManager runAnimationsForSequenceNamed:@"open"];}

@end
