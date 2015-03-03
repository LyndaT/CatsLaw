//
//  LevelSelect.m
//  CatsLaw
//
//  Created by Lili Sun on 3/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LevelSelect.h"
#import "Globals.h"
#import "LevelButton.h"

@implementation LevelSelect{
    Globals *globals;
}

- (id)init {
    if (self = [super init]) {
        globals = [Globals globalManager];
    }
    return self;
}

- (void)didLoadFromCCB {
    [self setButtons];
}

- (void)setButtons {
    int levelCount=0;
    for (int i=0; i<2; i++) {
        //two rows of buttons
        for (int j=0; j<5; j++) {
            //5 columns of buttons

            CCNode* level = [CCBReader load:@"Sprites/emptyLevel"];
            if (levelCount < globals.highestLevel-1) {
                level = [CCBReader load:@"Sprites/doneLevel"];
                [(LevelButton*)level setLevel:0];
            }else if (levelCount < globals.highestLevel){
                level = [CCBReader load:@"Sprites/nextLevel"];
                [(LevelButton*)level setLevel:1];
            }
            level.position= ccp(65+110*j,190-110*i);
            
            if (levelCount < globals.totalLevels) {
                [self addChild:level];
            }
            
            levelCount++;
        }
        
    }
}

- (void)play{
    globals.currentSceneName = @"scenes/GamePlay";
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:globals.currentSceneName]];
}

@end
