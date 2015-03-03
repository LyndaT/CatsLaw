//
//  Tile.h
//  CatsLaw
//
//  Created by Jenny Lin on 3/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Cat.h"
#import "GamePlay.h"

@interface Tile : CCNode

- (void) callOnCollision:(Cat*) cat gameplayHolder:(GamePlay*) gameplay;
- (void) callOnSeperation:(Cat*) cat gameplayHolder:(GamePlay*) gameplay;

@end
