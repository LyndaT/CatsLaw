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
        NSUInteger highest = [[NSUserDefaults standardUserDefaults] integerForKey:@"highestLevel"];
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
        
        totalLevels = 13;
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

@end
