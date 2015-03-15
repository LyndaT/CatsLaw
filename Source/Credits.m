//
//  Credits.m
//  CatsLaw
//
//  Created by Lili Sun on 3/8/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Credits.h"
#import "Globals.h"

@implementation Credits{
    Globals *globals;
}

- (id)init {
    if (self = [super init]) {
        globals = [Globals globalManager];
    }
    return self;
}


- (void)back{
    globals.currentSceneName = @"scenes/Settings";
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:globals.currentSceneName]];
}

@end
