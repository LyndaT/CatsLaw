//
//  Settings.m
//  CatsLaw
//
//  Created by Lili Sun on 3/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Settings.h"
#import "Globals.h"

@implementation Settings{
    Globals *globals;
}

- (id)init {
    if (self = [super init]) {
        globals = [Globals globalManager];
    }
    return self;
}

- (void)menu {
    globals.currentSceneName = @"MainScene";
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:globals.currentSceneName]];
}

@end
