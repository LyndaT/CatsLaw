//
//  Level.h
//  CatsLaw
//
//  Created by Lynda Tang on 2/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Door.h"

@interface Level : CCNode

- (void)incrementCakeCount;
- (CGPoint)getCatStartPosition;
- (float)getCatStartRotation;
- (float)getLevelRotation;
- (int)getNumberOfCakes;
- (CGPoint)getDoorPosition;
- (float)getDoorRotation;
- (int)getNextLevel;
- (BOOL)isCutsceneNext;
    
@end
