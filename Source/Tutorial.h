//
//  Tutorial.h
//  CatsLaw
//
//  Created by Lynda Tang on 3/8/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Cat.h"
#import "GamePlay.h"

@interface Tutorial : CCNode

- (void)callOnCollision:(Cat*) cat gameplayHolder:(GamePlay*) gameplay;

- (void)door;
- (void)turn;
- (void)cling;

@end
