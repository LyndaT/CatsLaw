//
//  Level.m
//  CatsLaw
//
//  Created by Lynda Tang on 2/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Level.h"
#import "Door.h"
#import "Cat.h"

@implementation Level {
    CCNode *catStartNode;
    CCNode *objectNode;
    Door* door;
    
    float levelRotation;
    int numCakes;
    int nextLevel;
    BOOL isCutsceneNext;
    
    //not from spritebuilder
    int cakeCount;
    
}

- (void)didLoadFromCCB {

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
    if (cakeCount == numCakes){
        [door unlock];
    }
}

- (BOOL)isDoorUnlocked{
    return door.isUnlocked;
}

//plays door open animation
- (void)openDoor{
    [door open];
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
 * adds the cat to the spawn node
 */
- (void)addCatToLevel:(Cat*) cat {
    [cat removeFromParentAndCleanup:YES];
    [catStartNode addChild:cat];
    cat.position = ccp(0, 0);
}

/*
 * removes the cat from the spawn node
 */
- (void)removeCatFromLevel:(Cat*) cat {
    [cat removeFromParentAndCleanup:YES];
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
    return door.position;
}

/*
 * Returns a CGPoint that gives the door location
 */
- (float)getDoorRotation {
    return door.rotation;
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
