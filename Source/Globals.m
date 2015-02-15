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

- (id)init {
    if (self = [super init]) {
        highestLevel = 1; //TODO: get this data to persist
        currentLevelNumber = 1;
        isMusicOn=YES;
        isSFXOn=YES;
        audio = [OALSimpleAudio sharedInstance];
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
}

- (void)setMusicOn:(BOOL)setting {
    isMusicOn = setting;
}

- (void)setSFXOn:(BOOL)setting {
    isSFXOn = setting;
}

@end
