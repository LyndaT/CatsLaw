//
//  Level.m
//  CatsLaw
//
//  Created by Lynda Tang on 2/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Level.h"

@implementation Level {
    CCNode *catStartNode;
    CCNode *doorNode;
    
    float levelRotation;
    int numCakes;
    int nextLevel;
    BOOL isCutsceneNext;
    
}

- (void)didLoadFromCCB {
    
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
