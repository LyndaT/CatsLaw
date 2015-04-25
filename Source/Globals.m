//
//  Globals.m
//  CatsLaw
//
//  Created by Lili Sun on 2/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Globals.h"

@implementation Globals

@synthesize highestLevel;
@synthesize currentLevelNumber;
@synthesize isMusicOn;
@synthesize isSFXOn;
@synthesize audio;
@synthesize totalLevels;
@synthesize currentSceneName;
@synthesize screenSize;

- (id)init {
    if (self = [super init]) {
        NSUInteger highest = 26; //TODO TAKE THIS OUT...IT'S CHEATING
        //NSUInteger highest = [[NSUserDefaults standardUserDefaults] integerForKey:@"highestLevel"];
        if (highest == nil || highest==1) {
            CCLOG(@"new game");
            [self setHighestLevel:1];
        } else {
//            CCLOG(@"saved game %i", highest);
            highestLevel=highest;
        }
        currentLevelNumber = 1;
        isMusicOn=YES;
        isSFXOn=YES;
        audio = [OALSimpleAudio sharedInstance];
        screenSize = [CCDirector sharedDirector].viewSize;
    
        totalLevels = 26;
    }
    return self;
}

#pragma mark Singleton Methods

//call this inside the init for any class that is touching globals
+ (id)globalManager {
    static Globals *sharedGlobals = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGlobals = [[self alloc] init];
    });
    return sharedGlobals;
}

- (void)setLevel:(int)levelNumber {
    currentLevelNumber = levelNumber;
    if (currentLevelNumber > highestLevel) {
        [self setHighestLevel:currentLevelNumber];
    }
}

- (NSString*)getCurrentLevelName {
    return [NSString stringWithFormat:@"levels/Level%i", currentLevelNumber];
}

- (void)setMusicOn:(BOOL)setting vol:(int)v {
    isMusicOn = setting;
    [audio setBgVolume:v];
}

- (void)setSFXOn:(BOOL)setting vol:(int)v{
    isSFXOn = setting;
    [audio setEffectsVolume:v];
}

- (void)setHighestLevel:(int)highest {
    highestLevel = highest;
    [[NSUserDefaults standardUserDefaults] setInteger:highestLevel forKey:@"highestLevel"];
}

- (NSInteger)getHighestLevel {
    highestLevel=[[NSUserDefaults standardUserDefaults] integerForKey:@"highestLevel"];
    return highestLevel;
}

//----------dumb helper methods

/*
 * you dumbasses be inconsistent about angles so now I have to sanitize the input
 * I HOPE YOU'RE ALL HAPPY
 */
- (float) clampRotation:(float)rot1 {
    while (rot1 < 0) {
        rot1 = rot1 + 360;
    }
    while (rot1 >= 360) {
        rot1 = rot1 - 360;
    }
    
    return rot1;
}

@end
