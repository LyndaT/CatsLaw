//
//  Tutorial.m
//  CatsLaw
//
//  Created by Lynda Tang on 3/8/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Tutorial.h"

@implementation Tutorial {
    CCAnimationManager* animationManager;
    
    CCNode *tutorialAnim;
    
    NSString *tutorialAnimString;
}

- (void)didLoadFromCCB {
    animationManager = self.animationManager;
    self.physicsBody.collisionType = @"tutorial";
    self.physicsBody.sensor = TRUE; //so cat can overlap with it
    
    
    tutorialAnimString = [NSString stringWithFormat:@"assets/animations/tutorial/%@", tutorialAnimString];
    tutorialAnim = [CCBReader load:tutorialAnimString owner: self];
    [self addChild:tutorialAnim];
    tutorialAnim.visible = false;
}

- (void)runTutorial {
    
    CCLOG(tutorialAnimString);
    tutorialAnim.visible = true;
}

@end
