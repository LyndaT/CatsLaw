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

- (void)callOnCollision:(Cat*) cat gameplayHolder:(GamePlay*) gameplay tutNode:(CCNode *)tut;

- (void)door;
- (BOOL)shouldRotate;
- (void)turn;
- (void)cling;
- (void)clingHold;

@end
