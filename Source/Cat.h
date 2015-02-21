//
//  Cat.h
//  CatsLaw
//
//  Created by Jenny Lin on 2/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Cat : CCSprite

@property (nonatomic, assign) BOOL isClinging;

- (void) moveCat: (CCTime) delta directionOfGravity: (int) orientation;
- (void) tryToCling;
- (void) endCling;
- (BOOL) isNyooming;

@end
