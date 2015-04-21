//
//  Cat.m
//  CatsLaw
//
//  Created by Jenny Lin on 2/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Cat.h"
#import "Globals.h"


@implementation Cat {
    Globals *globals;
    int speed;
    BOOL isKnocking;
    CCAnimationManager* animationManager;
    int direction; //either 1 or -1. 1 is it goes right, -1 is left
    BOOL canMove; //used for pausing the cat but not the game
    
    BOOL madeTurnWithCling; //for cling tutorial verification
    int startOrientation; //for cling tutorial verification
}

@synthesize canCling;
@synthesize isClinging;
@synthesize onGround;
@synthesize catOrientation;


- (id) init {
    if (self = [super init]) {
        globals = [Globals globalManager];
        speed = 30;
        isKnocking = NO;
        direction = 1;
        canMove= YES;
        madeTurnWithCling = NO;
    }
    return self;
}

/*
 * Called when this file is loaded from CCB.
 */
- (void)didLoadFromCCB {
    animationManager = self.animationManager;
    self.scaleX = 0.3;
    self.scaleY = 0.3;
    canCling = YES;
    isClinging = NO;
    onGround = NO;
}

/*
 * Checks cat velocity to see if it's nyooming
 * Threshold dependent on current movement
 */
- (BOOL) isNyooming {
    float s =sqrt(pow(self.physicsBody.velocity.x,2) + pow(self.physicsBody.velocity.y,2));
    return (sqrt(pow(self.physicsBody.velocity.x,2) + pow(self.physicsBody.velocity.y,2)) > speed + 20);
}

- (BOOL)getIsKnocking {
    return isKnocking;
}

//Tries to make the cat cling
- (void) tryToCling {
    if (canCling && canMove) {
        isClinging = YES;
        if (catOrientation == 0) {
            self.physicsBody.velocity = ccp(0, self.physicsBody.velocity.y);
        }
        else if (catOrientation == 90) {
            self.physicsBody.velocity = ccp(self.physicsBody.velocity.x, 0);
        }
        else if (catOrientation == 180) {
            self.physicsBody.velocity = ccp(0, self.physicsBody.velocity.y);
        }
        else if (catOrientation == 270) {
            self.physicsBody.velocity = ccp(self.physicsBody.velocity.x, 0);
            //self.position = ccp(self.position.x, self.position.y + delta*speed);
        }
        //tut stuff
        startOrientation = catOrientation;
        CCLOG(@"current orientation %i", startOrientation);
        madeTurnWithCling = NO;
        
        //cling animation
        [self cling];
    }
}

//Stop the cat from clinging
- (void) endCling:(int)orientation {
    if (isClinging){
        CCLOG(@"start %i end %i",startOrientation,orientation);
        if (orientation == startOrientation+180 || orientation == startOrientation-180){
            madeTurnWithCling = YES;
        }
        isClinging = NO;
        [self walk];
    }
}

//A method to move the cat, requires an orientation to determine right way to move
//Called everytime the gravity tries to change
//Operates under assumption that orientation is always 0, 90, 180 or 270

- (void) moveCat:(int)orientation timeStep:(CCTime)delta{
    if (isKnocking || !canMove) {
//        CCLOG(@"not moving");
        self.physicsBody.velocity = ccp(0,0);
        self.physicsBody.angularVelocity = 0;
        return;
        
    }
    if (!isClinging) {
        catOrientation = orientation;
        if (orientation == 0) {
            self.physicsBody.velocity = ccp(speed*direction, self.physicsBody.velocity.y);
        }
        else if (orientation == 90) {
            self.physicsBody.velocity = ccp(self.physicsBody.velocity.x, -1*speed*direction);
        }
        else if (orientation == 180) {
            self.physicsBody.velocity = ccp(-1*speed*direction, self.physicsBody.velocity.y);
        }
        else if (orientation == 270) {
            self.physicsBody.velocity = ccp(self.physicsBody.velocity.x, speed*direction);
            //self.position = ccp(self.position.x, self.position.y + delta*speed);
        }
    }
    [self rotate:orientation];
    
    
//    CCLOG(@"rotation %f", self.rotation);
    //if (self.rotation != orientation) {
//    CCLOG(@"onGround %d", onGround);
    //self.rotation = orientation;
    
    
    
    //float desiredAngularVelocity = rotationToGo*10.0;
    
    
    //return;
    //float torque = cpmomentFor(self.physicsBody)*desiredAngularVelocity/(1/60.0);
    //[self.physicsBody applyTorque:torque];
    
    
}

- (void)rotate: (int)orientation{
    float currentAngle = self.rotation;
    float futureAngle = [globals clampRotation:(currentAngle + self.physicsBody.angularVelocity/10.0)];
    float rotationToGo = currentAngle-catOrientation;
    float desiredAngularVelocity = 0;
    if (rotationToGo > 180) {
        rotationToGo = rotationToGo - 360;
    }
    else if (rotationToGo < -180) {
        rotationToGo = rotationToGo + 360;
    }
    if (rotationToGo > 0) {
        desiredAngularVelocity = rotationToGo*30.0/180.0;
    }
    else if (rotationToGo < 0) {
        desiredAngularVelocity = rotationToGo*30.0/180;
    }
    self.physicsBody.angularVelocity = desiredAngularVelocity;
}

//stops the cat from moving
- (void)stopCat{
    canMove = NO;
    [self sit];
}

//lets the cat move again
- (void)goCat{
    canMove = YES;
    [self walk];
}

- (void)setIsKnocking: (BOOL)set {
    isKnocking = set;
}

- (void)setDirection: (int)dir {
    direction = dir;
}

- (BOOL)didClingTutorial {
    return madeTurnWithCling;
}

//------------------ animations

- (void)blink {
    [animationManager runAnimationsForSequenceNamed:@"hover"];
}

- (void)walk {
    [animationManager runAnimationsForSequenceNamed:@"walk"];
}

- (void)cling {
    [animationManager runAnimationsForSequenceNamed:@"cling"];
}

- (void)knock {
    isKnocking=YES;
    [animationManager runAnimationsForSequenceNamed:@"knock"];
}

- (void)stand {
    [animationManager runAnimationsForSequenceNamed:@"stand"];
}

- (void)sit {
    [animationManager runAnimationsForSequenceNamed:@"sit"];
}

- (void)lay {
    [animationManager runAnimationsForSequenceNamed:@"lay"];
}


@end
