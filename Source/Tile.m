//
//  Tile.m
//  CatsLaw
//
//  Created by Jenny Lin on 3/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Tile.h"
#import "Cat.h"
#import "GamePlay.h"

@implementation Tile


//to be called anytime a Tile collides with the Cat
//abstract classes don't exist, so instead this stub will throw an exception
- (void) callOnCollision:(Cat *)cat gameplayHolder:(GamePlay *)gameplay {
    @throw [NSException exceptionWithName:@"subclassOverwrite" reason:@"class callOnCollision must be overridden by subclass" userInfo:nil ];
}

//to be called anytime a Tile collides with the Cat
//abstract classes don't exist, so instead this stub will throw an exception
- (void) callOnSeperation:(Cat *)cat gameplayHolder:(GamePlay *)gameplay{
    @throw [NSException exceptionWithName:@"subclassOverwrite" reason:@"class callOnSeperation must be overridden by subclass" userInfo:nil ];
}

@end
