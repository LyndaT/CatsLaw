//
//  DeathScreen.m
//  CatsLaw
//
//  Created by Lili Sun on 3/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DeathScreen.h"

@implementation DeathScreen{
    CCAnimationManager* animationManager;
}

- (void)didLoadFromCCB
{
    animationManager = self.animationManager;
}

- (void)cake{
    [animationManager runAnimationsForSequenceNamed:@"cake"];
}

- (void)water{
    [animationManager runAnimationsForSequenceNamed:@"water"];
}

@end
