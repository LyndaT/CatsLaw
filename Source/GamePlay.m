//
//  GamePlay.m
//  CatsLaw
//
//  Created by Lili Sun on 2/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlay.h"
#import <CoreMotion/CoreMotion.h>

int rotation = 0;
CGFloat gravitystrength = 2000;

@implementation GamePlay{
    CCNode *currentLevel;
    CCNode *cat;
    
    //from SpriteBuilder
    CCPhysicsNode *_physNode;
    CCNode *_levelNode;
    
    
    //for accelerometer
    //Please only create one motion manager.
    CMMotionManager *_motionManager;
}

/*
 * Initialization.
 */
- (id)init {
    if (self = [super init]) {
        _motionManager = [[CMMotionManager alloc] init];        //initiates the MotionManager
    }
    return self;
}

/*
 * Called when this file is loaded from CCB.
 */
- (void)didLoadFromCCB {
    currentLevel = [CCBReader load:@"Levels/TestLevel"];
    cat = [CCBReader load:@"Sprites/Cat"];
    cat.scaleX=0.3;
    cat.scaleY=0.3;
    
    [_levelNode addChild:currentLevel];
    [_physNode addChild:cat];
}

/*
 * Update function called once per frame.
 */
- (void)update:(CCTime)delta {
    
    CMAccelerometerData *accelerometerData = _motionManager.accelerometerData;
    CMAcceleration acceleration = accelerometerData.acceleration;
    
    [self changeGravity:acceleration.x :acceleration.y];
    
}


/*
 * changeGravity takes in accelerometer values and changes gravity accordingly.
 * It checks if the cat is nyooming, if not, then it changes gravity.
 *
 * @xaccel: the accelerometer.x value
 * @yaccel: the accelerometer.y value
 *
 * gravityleft: -0.5 < accel.x < 0.5 && accel.y < -0.5
 * gravitydown: 0.5 < accel.x && -0.5 < accel.y < 0.5
 * gravityright: -0.5 < accel.x < 0.5 && 0.5 < accel.y
 * gravityup: accel.x < -0.5 && -0.5 < accel.y <0.5
 */

- (void)changeGravity:(CGFloat)xaccel :(CGFloat)yaccel {
    //if (![self isCatNyooming]) {          //implement when there's a cat...
        int prevRotation = rotation;
        if (xaccel < 0.5 && xaccel > -0.5 && yaccel < -0.5)
        {
            rotation = 90;
        }
        if (yaccel < 0.5 && yaccel > -0.5 && xaccel >0.5)
        {
            rotation = 0;
        }
        if (xaccel < 0.5 && xaccel > -0.5 && yaccel> 0.5)
        {
            rotation = 270;
        }
        if (yaccel < 0.5 && yaccel > -0.5 && xaccel<-0.5)
        {
            rotation = 180;
        }
    
        [self updateGravity:rotation];
        if (prevRotation!= rotation) {
            cat.physicsBody.velocity = ccp(0,0);
        }
    //}
    
}

/*
 * updateGravity takes in the rotation of the phone and updates the gravity in the physics
 * node.
 *
 * @rotation: the rotation of the phone
 */
- (void)updateGravity:(int)rotation {
    if (rotation == 270) {                                      //gravity right
        _physNode.gravity= ccp(1*gravitystrength,0);
    }
    else if (rotation == 180) {                                 //gravity up
        _physNode.gravity= ccp(0,1*gravitystrength);
    }
    else if (rotation == 90) {                                  //gravity left
        _physNode.gravity= ccp(-1*gravitystrength,0);
    }
    else {                                                      //gravity down
        rotation = 0;
        _physNode.gravity= ccp(0,-1*gravitystrength);
    }
}



@end
