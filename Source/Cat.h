//
//  Cat.h
//  CatsLaw
//
//  Created by Jenny Lin on 2/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Cat : CCSprite

@property (nonatomic, assign) BOOL canCling;
@property (nonatomic, assign) BOOL isClinging;
@property (nonatomic, assign) BOOL onGround;
@property (nonatomic, assign) int catOrientation;//the cat's perspective of which way's down

- (void) moveCat: (int) orientation timeStep: (CCTime) delta;
- (void) rotate: (int) orientation;
- (void) tryToCling;
- (void) endCling:(int)orientation;
- (BOOL) isNyooming;
- (BOOL) getIsKnocking;
- (void) setIsKnocking: (BOOL)set;
- (void) setDirection: (int)dir;
- (void) stopCat;
- (void) goCat;
- (BOOL) didClingTutorial;

- (void)blink;
- (void)walk;
- (void)cling;
- (void)knock;
- (void)stand;
- (void)sit;
- (void)lay;

@end
