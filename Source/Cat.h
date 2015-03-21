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
- (void) tryToCling;
- (void) endCling;
- (BOOL) isNyooming;
- (void) setIsKnocking: (BOOL)set;
- (void) setDirection: (int)dir;
- (void) stopCat;
- (void) goCat;

- (void)blink;
- (void)walk;
- (void)cling;
- (void)knock;
- (void)stand;
- (void)sit;
- (void)lay;

@end
