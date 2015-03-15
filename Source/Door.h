//
//  Door.h
//  CatsLaw
//
//  Created by Lili Sun on 2/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Door : CCNode

@property (nonatomic, assign) BOOL isUnlocked;

- (void)unlock;
- (void)lock;
- (void)hover;
- (void)unHover;
- (void)open;

@end
