//
//  Globals.h
//  CatsLaw
//
//  Created by Lili Sun on 2/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject{
}

@property (nonatomic, assign) int highestLevel;
@property (nonatomic, assign) int currentLevelNumber;
@property (nonatomic, assign) BOOL isMusicOn;
@property (nonatomic, assign) BOOL isSFXOn;
@property (nonatomic, assign) OALSimpleAudio *audio;
@property (nonatomic, assign) int totalLevels;
@property (nonatomic, retain) NSString *currentSceneName;
@property (nonatomic, assign) CGSize screenSize;


+ (id)globalManager;
- (void)setLevel:(int)levelNumber;
- (NSString*)getCurrentLevelName;
- (void)setMusicOn:(BOOL)setting vol:(int)v;
- (void)setSFXOn:(BOOL)setting vol:(int)v;
- (void)setHighestLevel:(int)highestLevel;
- (NSInteger)getHighestLevel;
- (float)clampRotation:(float)rot1;

@end
