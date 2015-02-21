//
//  Cake.h
//  CatsLaw
//
//  Created by Lili Sun on 2/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Cake : CCNode

@property (nonatomic, assign) BOOL isGone;

- (void)pulse;
- (void)eat;

@end
