//
//  Trap.m
//  CatsLaw
//
//  Created by Lili Sun on 3/30/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap.h"
#import "GamePlay.h"
#import "Cat.h"
#import "Globals.h"

@implementation Trap{
    Globals *globals;
}

- (void)didLoadFromCCB
{
    self.physicsBody.sensor = FALSE; //true = cat can overlap, false = cat bumps into
}

//called upon cat collision
//determine if cat is nyooming and do appropriate response
- (void) callOnCollision:(Cat*)cat gameplayHolder:(GamePlay *)gameplay{
    if ([cat isNyooming]){
        self.physicsBody.sensor = TRUE;
        //[globals.audio playEffect:@"assets/music/falltrap.mp3"];
    }else {
        self.physicsBody.sensor = FALSE;
    }
}


//
- (void) callOnSeperation:(Cat*)cat gameplayHolder:(GamePlay *)gameplay{
}

@end
