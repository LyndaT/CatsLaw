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
    
    int rows;
    int cols;
    int pages;
    int screenWidth;
    
    CCNode* buttons;
    
    int startX;
    int deltaX;
    BOOL isTouching;
    int currentPage;
    BOOL isSwipeRight;
    int lastTouchPos;
}

- (id)init {
    if (self = [super init]) {
        self.userInteractionEnabled = TRUE; //activate touches
        globals = [Globals globalManager];
        rows = 2;
        cols = 5;
        screenWidth=568;
        isTouching=NO;
        currentPage=0;
        isSwipeRight=NO;
    }
    return self;
}

- (void)didLoadFromCCB {
    pages = ceil(globals.totalLevels / (rows * cols));
    [self setButtons];
}

- (void)setButtons {
    int levelCount=0;
    for (int k=0; k<=pages; k++) {
        for (int i=0; i<rows; i++) {
            for (int j=0; j<cols; j++) {

                CCNode* level = [CCBReader load:@"sprites/emptyLevel"];
                if (levelCount < globals.highestLevel-1) {
                    level = [CCBReader load:@"sprites/doneLevel"];
                    [(LevelButton*)level setLevel:levelCount];
                }else if (levelCount < globals.highestLevel){
                    level = [CCBReader load:@"sprites/nextLevel"];
                    [(LevelButton*)level setLevel:levelCount];
                }
                level.position= ccp(65+110*j + (screenWidth*k),195-110*i);
                
                if (levelCount < globals.totalLevels) {
                    [buttons addChild:level];
                }
                
                levelCount++;
            }
            
    }
    }
}

/*
 * Update function called once per frame.
 */
- (void)update:(CCTime)delta {
    if (isTouching) {
//        CCLOG(@"deltax %i", deltaX);
        buttons.position = ccp(buttons.position.x-(deltaX/4), 0);
        isTouching=NO;
        deltaX=0;
    }
}

//-------------------touch stuff

/*
 * Handling tap/hold/clench using touches
 */
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint touchPos = [touch locationInNode:self];
    startX = touchPos.x;
    lastTouchPos=startX;
    deltaX=0;
    CCLOG(@"touch start %i", startX);
}

- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint touchPos = [touch locationInNode:self];
    CCLOG(@"old %f new %f", lastTouchPos,touchPos.x);
    if (lastTouchPos != touchPos.x){
        
        //changed swipe direction
        if (lastTouchPos < touchPos.x && isSwipeRight){
            isSwipeRight=NO;
            startX = touchPos.x;
        }else if (lastTouchPos > touchPos.x && !isSwipeRight){
            isSwipeRight=YES;
            startX=touchPos.x;
        }
        
        isTouching=YES;
        deltaX = startX - touchPos.x;
        lastTouchPos=touchPos.x;
    }
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchPos = [touch locationInNode:self];
    deltaX = startX - touchPos.x;
    if (deltaX > screenWidth/3) {
        //snap to next page
        if (currentPage<globals.totalLevels){
            currentPage++;
        }
    } else if (deltaX < -screenWidth/3) {
        //snap to prev page
        if (currentPage>0){
            currentPage--;
        }
    } else {
        //snap to current page
    }
    [buttons runAction:[CCActionMoveTo actionWithDuration:0.15f
                                                 position:ccp(-screenWidth*currentPage,0)]];
    isTouching=NO;
}
- (void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    isTouching=NO;
}

@end
