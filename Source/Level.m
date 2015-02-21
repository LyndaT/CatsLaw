//
//  Level.m
//  CatsLaw
//
//  Created by Lynda Tang on 2/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Level.h"
#import "Door.h"

@implementation Level {
    CCNode *catStartNode;
    CCNode *doorNode;
    
    float levelRotation;
    int numCakes;
    int nextLevel;
    BOOL isCutsceneNext;
    
    //not from spritebuilder
    int cakeCount;
    Door* door;
    
}

- (void)didLoadFromCCB {
    door = (Door *)[CCBReader load:@"Sprites/Door"];
    door.scaleX= 0.3;
    door.scaleY = 0.3;
    door.position = doorNode.position;
    [self addChild:door];

    cakeCount=0;
    
    if (cakeCount == numCakes){
        //basically if numcakes==0 the door is unlocked
        [door unlock];
    }
}


//increases cake count
//if cake count == numcakes, unlocks door
- (void)incrementCakeCount{
    cakeCount++;
    [door unlock];
}

- (BOOL)isDoorUnlocked{
    return door.isUnlocked;
}

/*
 * Returns a CGPoint that gives the cat's starting position
 */
- (CGPoint)getCatStartPosition {
    return catStartNode.position;
}

/*
 * Returns a float that gives the cat's starting rotation
 */
- (float)getCatStartRotation {
    return catStartNode.rotation;
}

/*
 * Returns a float that gives the rotation of the level
 */
- (float)getLevelRotation {
    return levelRotation;
}

/*
 * Returns the number of cakes in the level
 */
- (int)getNumberOfCakes {
    return numCakes;
}

/*
 * Returns a CGPoint that gives the door position
 */
- (CGPoint)getDoorPosition {
    return doorNode.position;
}

/*
 * Returns a CGPoint that gives the door location
 */
- (float)getDoorRotation {
    return doorNode.rotation;
}

/*
 * Returns an int that gives the number of the next level
 */
- (int)getNextLevel {
    return nextLevel;
}

/*
 * Returns a boolean that determines whether or not a cutscene is next
 */
- (BOOL)isCutsceneNext {
    return isCutsceneNext;
}


@end
