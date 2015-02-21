//
//  Cake.m
//  CatsLaw
//
//  Created by Lili Sun on 2/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Cake.h"

@implementation Cake{
    CCAnimationManager* animationManager;
}

@synthesize isGone;

- (void)didLoadFromCCB
{
    animationManager = self.animationManager;
    self.physicsBody.collisionType = @"cake";
    self.physicsBody.sensor = TRUE; //so cat can overlap with it
    isGone=NO;
}

- (void)pulse{
    [animationManager runAnimationsForSequenceNamed:@"pulse"];
}

- (void)gone{
    self.visible=false;
}

- (BOOL)eat{
    if (!isGone && self.visible){
        [animationManager runAnimationsForSequenceNamed:@"eat"];
        isGone=YES;
        return YES;
    }else {
        return NO;
    }
}

@end
