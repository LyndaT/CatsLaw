//
//  Cat.m
//  CatsLaw
//
//  Created by Jenny Lin on 2/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Cat.h"

@implementation Cat {
    int speed;
}

- (id) init {
    if (self = [super init]) {
        speed = 30;
    }
    return self;
}

/*
 * Called when this file is loaded from CCB.
 */
- (void)didLoadFromCCB {
    self.scaleX=0.3;
    self.scaleY=0.3;
}


- (BOOL) isNyooming {
    return (sqrt(pow(self.physicsBody.velocity.x,2) + pow(self.physicsBody.velocity.y,2)) > speed + 10);
}


//A method to move the cat, requires an orientation to determine right way to move
//Operates under assumption that orientation is always 0, 90, 180 or 270
- (void) moveCat:(CCTime)delta directionOfGravity:(int)orientation {
    self.rotation = orientation;
    if (orientation == 0) {
        self.position = ccp(self.position.x + delta*speed, self.position.y);
    }
    else if (orientation == 90) {
        self.position = ccp(self.position.x, self.position.y - delta*speed);
    }
    else if (orientation == 180) {
        self.position = ccp(self.position.x - delta*speed, self.position.y);
    }
    else if (orientation == 270) {
        self.position = ccp(self.position.x, self.position.y + delta*speed);
    }
}

@end
