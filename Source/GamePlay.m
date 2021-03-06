//
//  GamePlay.m
//  CatsLaw
//
//  Created by Lili Sun on 2/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlay.h"
#import "Cat.h"
#import "Cake.h"
#import "Tile.h"
#import "Level.h"
#import <CoreMotion/CoreMotion.h>
#import "Globals.h"
#import "Tutorial.h"
#import "DeathScreen.h"

CGFloat gravitystrength = 2000;
CGFloat immuneTime = 3.0f;

@implementation GamePlay{
    Globals *globals;
    Level *currentLevel;
    Cat *cat;
    Tutorial *tutorial;
    
    BOOL isPaused;
    BOOL isGameOver;
    BOOL isAtDoor;
    BOOL isCatImmune;
    BOOL isTutorial;
    
    CCNode *pauseMenu;
    DeathScreen *deadMenu;
    CCNode *nextLevelMenu;
    CCLabelTTF *pauseLabel;
    CCLabelTTF *levelLabel;
    
    //from SpriteBuilder
    CCPhysicsNode *physNode;
    CCNode *levelNode;
    CCNode *menuNode;
    CCNode *tutorialNode;
    CCButton *pauseButton;
    
    int rotation;
    
    //for accelerometer
    //Please only create one motion manager.
    CMMotionManager *motionManager;
}

/*
 * Initialization.
 */
- (id)init {
    if (self = [super init]) {
        globals = [Globals globalManager];
        self.userInteractionEnabled = TRUE; //activate touches
        motionManager = [[CMMotionManager alloc] init];        //initiates the MotionManager
        isPaused = NO;
        isGameOver = NO;
        isCatImmune = YES;
    }
    return self;
}

/*
 * Called when this file is loaded from CCB.
 */
- (void)didLoadFromCCB {
    cat = (Cat *)[CCBReader load:@"sprites/Cat"];
    
    rotation = 0;
    
    //loads pause menu and sets owner as gameplay so that the buttons on the menu work
    pauseMenu = [CCBReader load:@"Paused" owner:self];
    [menuNode addChild:pauseMenu];
    pauseMenu.visible=false;
    
    deadMenu = (DeathScreen *)[CCBReader load:@"Dead" owner:self];
    [menuNode addChild:deadMenu];
    deadMenu.visible = false;
    
    nextLevelMenu = [CCBReader load:@"NextLevel" owner:self];
    [menuNode addChild:nextLevelMenu];
    nextLevelMenu.visible=false;
    
    physNode.collisionDelegate = self;
    cat.physicsBody.collisionType = @"cat";
    
    [self loadLevel: NO];
}

/*
 * Update function called once per frame.
 */
- (void)fixedUpdate:(CCTime)delta {
    
    CMAccelerometerData *accelerometerData = motionManager.accelerometerData;
    CMAcceleration acceleration = accelerometerData.acceleration;
    
    //for cling tutorial stuff
    BOOL shouldRotate = YES;
    if (isTutorial) {
        shouldRotate = [tutorial shouldRotate];
    }
    
    if (!isCatImmune) {
        if (shouldRotate){
            [cat moveCat:rotation timeStep:delta];
        }else{
            if ([[globals getCurrentLevelName] isEqualToString:@"levels/Level4"]){
                [cat rotate:180];
            }
            if ([[globals getCurrentLevelName] isEqualToString:@"levels/Level2"]){
                [cat rotate:rotation];
            }
        }
        [self changeGravity:acceleration.x :acceleration.y :shouldRotate];
        
        if (isAtDoor){
            [self tryDoor];
        }
    }
}


/*
 * changeGravity takes in accelerometer values and changes gravity accordingly.
 * It checks if the cat is nyooming, if not, then it changes gravity.
 *
 * @xaccel: the accelerometer.x value
 * @yaccel: the accelerometer.y value
 *
 * gravityleft: -0.5 < accel.x < 0.5 && accel.y < -0.5
 * gravitydown: 0.5 < accel.x && -0.5 < accel.y < 0.5
 * gravityright: -0.5 < accel.x < 0.5 && 0.5 < accel.y
 * gravityup: accel.x < -0.5 && -0.5 < accel.y <0.5
 */

- (void)changeGravity:(CGFloat)xaccel :(CGFloat)yaccel :(BOOL)shouldRotate{
    if (![cat isNyooming]) {          //implement when there's a cat...
        int prevRotation = rotation;
        if (xaccel < 0.5 && xaccel > -0.5 && yaccel < -0.5)
        {
            rotation = 90;
        }
        if (yaccel < 0.5 && yaccel > -0.5 && xaccel >0.5)
        {
            rotation = 0;
        }
        if (xaccel < 0.5 && xaccel > -0.5 && yaccel> 0.5)
        {
            rotation = 270;
        }
        if (yaccel < 0.5 && yaccel > -0.5 && xaccel<-0.5)
        {
            rotation = 180;
        }
    
        if (shouldRotate){
            [self updateGravity:rotation];
        }
        if (prevRotation!= rotation) {
            //cat.physicsBody.velocity = ccp(0,0);
            if ([[globals getCurrentLevelName] isEqualToString:@"levels/Level2"]){
                [tutorial turn];
            }
//            CCLOG(@"gravity changed");
        }
    }
    
}

/*
 * updateGravity takes in the rotation of the phone and updates the gravity in the physics
 * node.
 *
 * @phoneRotation: the rotation of the phone
 */
- (void)updateGravity:(int)phoneRotation {
    if (!cat.isClinging) {
        if (phoneRotation == 270) {                                      //gravity right
            physNode.gravity= ccp(1*gravitystrength,0);
        }
        else if (phoneRotation == 180) {                                 //gravity up
            physNode.gravity= ccp(0,1*gravitystrength);
        }
        else if (phoneRotation == 90) {                                  //gravity left
            physNode.gravity= ccp(-1*gravitystrength,0);
        }
        else {                                                      //gravity down
            phoneRotation = 0;
            physNode.gravity= ccp(0,-1*gravitystrength);
        }
    }
}


//call when entering the game over state
-(void)gameOver: (NSString *)method {
    if ([method isEqualToString:@"cake"]){
        //[globals.audio playEffect:@"assets/music/cakesmoosh.mp3"];
        [deadMenu cake];
    }else if ([method isEqualToString:@"water"]){
        //[globals.audio playEffect:@"assets/music/water.mp3"];
        [deadMenu water];
    }
    isGameOver = YES;
    [[CCDirector sharedDirector] pause];
    isPaused=YES;
    CCLOG(@"rotation: %i",rotation);
    deadMenu.rotation = rotation;
    deadMenu.visible=true;
    pauseButton.visible = NO;
    pauseButton.enabled = NO;
}

//call when exiting game over state
//assumes unpause is called first
-(void)revive {
    isGameOver = NO;
    [[CCDirector sharedDirector] resume];
    isPaused=NO;
    [self clearLevel];
    [self loadLevel: YES];
    deadMenu.visible=false;
    pauseButton.visible = YES;
    pauseButton.enabled = YES;
}

//plays the door open anim and then loads next level
- (void)openDoor{
    [cat knock];
    [currentLevel openDoor];
    
    //call showNextLevelMenu in one second
    [self scheduleOnce:@selector(showNextLevelMenu) delay:1.0f];
}

- (void)tryDoor{
    if ([currentLevel isDoorUnlocked]){
        //trying to open the door
        if ([globals clampRotation:cat.catOrientation] == [globals clampRotation:[currentLevel getDoorRotation]]) {
            //if you're the right door orientation
            CCLOG(@"opening the door");
            isAtDoor=NO;
            //for tutorial stuff
            if ([[globals getCurrentLevelName] isEqualToString:@"levels/Level1"]){
                [tutorial door];
            }
            if ([[globals getCurrentLevelName] isEqualToString:@"levels/Level4"]){
                [tutorial cling];
            }
            
            [self openDoor];
        }
        else {
            CCLOG(@"cat orient: %f", cat.rotation);
            CCLOG(@"door orient: %f", [currentLevel getDoorRotation]);
        }
    }
}

//-------------------collision stuff

/*
 * Colliding with cake
 * called when cat is at cake
 */
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(CCNode *)Cat cake:(Cake *)Cake
{
    if ([cat isNyooming]) {
        CCLOG(@"SMOOSH");
        [self gameOver: @"cake"];
    }
    else {
        [Cake eat];
        [currentLevel incrementCakeCount];
    }
    return TRUE;
}

/*
 * Colliding with tiles
 * called when cat touches a new tile
 */
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(Cat *)Cat tile:(Tile *)Tile
{
    [Tile callOnCollision:Cat gameplayHolder:self];
    return TRUE;
}

/*
 * End colliding with tiles
 * called when cat leaves a tile
 */
-(BOOL)ccPhysicsCollisionEnd:(CCPhysicsCollisionPair *)pair cat:(Cat *)Cat tile:(Tile *)Tile
{
    [Tile callOnSeperation:Cat gameplayHolder:self];
    return TRUE;
}

/*
 * Colliding with door
 * just maintains isAtDoor
 */
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(CCNode *)Cat door:(Door *)Door
{
    isAtDoor=YES;
    [Door hover];
    return TRUE;
}
/*
 * end colliding w/door
 */
-(BOOL)ccPhysicsCollisionSeparate:(CCPhysicsCollisionPair *)pair cat:(CCNode *)Cat door:(Door *)Door
{
    isAtDoor=NO;
    [Door unHover];
    return TRUE;
}

//-------------------tutorial stuff

/*
 * Colliding with the tutorial collider
 */
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(Cat *)Cat tutorial:(Tutorial *)Tutorial
{
    CCLOG(@"tutorial triggered");
    [Tutorial callOnCollision:Cat gameplayHolder:self tutNode:tutorialNode];
    tutorial = Tutorial;
    return TRUE;
}

//-------------------menu stuff

/*
 * if !isPaused, pauses game, shows pause menu
 * if isPaused, calls unpause
 */
- (void)pause {
    if (!isPaused){
        [[CCDirector sharedDirector] pause];
//        AppController *app = (AppController*)[UIApplication sharedApplication].delegate;
//        app.userPaused = YES;
        isPaused=YES;
        CCLOG(@"rotation: %i",rotation);
        pauseMenu.rotation = rotation;
        pauseMenu.visible=true;
        pauseLabel.string=[NSString stringWithFormat:@"Paused\nLevel %i", globals.currentLevelNumber];
        tutorialNode.visible=NO;
    }
    else{
        [self unpause];
    }
}

/*
 * right now, unpauses game and gets rid of pause menu
 */
- (void)unpause {
//    AppController *app = (AppController*)[UIApplication sharedApplication].delegate;
//    app.userPaused = NO;
//    [_globals.audio playEffect:@"assets/music/button.mp3"];
    tutorialNode.visible=YES;
    isPaused=NO;
    [[CCDirector sharedDirector] resume];
    pauseMenu.visible=false;
}

/*
 * reloads gameplay scene
 */
- (void)restart {
    if (isPaused) {
        [self unpause];
    }
    CCScene *gameplayScene = [CCBReader loadAsScene:@"scenes/GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

/*
 * loads menu scene
 */
- (void)toMenu {
    if (isPaused) {
        [self unpause];
    }
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}


//-------------------level loading stuff

//Puts the cat in a temporary immune state
//Should be called everytime the level is loaded (or reloaded)
- (void) startCatImmunity {
    [cat blink];
    isCatImmune = YES;
    physNode.gravity = ccp(0, 0);
    cat.rotation = [currentLevel getLevelRotation];
    cat.physicsBody.velocity = ccp(0, 0);
    cat.physicsBody.angularVelocity = 0;
    [self scheduleOnce:@selector(endCatImmunity) delay:immuneTime];
    CCLOG(@"starting immune");
}

//Ends the cat's immune state
//Called automatically after a certain amount of time or after a tap
- (void) endCatImmunity {
    if (isCatImmune) {
        isCatImmune = NO;
        [self updateGravity:[currentLevel getLevelRotation]];
        [cat walk];
        CCLOG(@"ending immune");
    }
}

//isReload used if the next level is a cutscene but you're just trying to reload the current level.
- (void)loadLevel: (BOOL)isReload {
    if (!currentLevel.isCutsceneNext || isReload){
        currentLevel = (Level *)[CCBReader load:[globals getCurrentLevelName]];
        if ([[globals getCurrentLevelName] isEqualToString:@"levels/Level4"] ||
            [[globals getCurrentLevelName] isEqualToString:@"levels/Level2"]) {
            //it's the cling tutorial or turn tutorial
            isTutorial = YES;
        }
        [levelNode addChild:currentLevel];
        [currentLevel addCatToLevel:cat];
        if (!isTutorial){
            [self startCatImmunity];
        }else{
            isCatImmune=NO;
            [self updateGravity:[currentLevel getLevelRotation]];
            [cat walk];
        }
        CCLOG(@"rotation at start %i",rotation);
    }else {
        NSString* cutName = [NSString stringWithFormat:@"cutscenes/cutscene%i", [currentLevel getNextLevel]];
        CCScene *cutScene = [CCBReader loadAsScene:cutName];
        [[CCDirector sharedDirector] replaceScene:cutScene];
    }
}

- (void)clearLevel{
    [cat setDirection:1];
    [currentLevel removeCatFromLevel:cat];
    [levelNode removeChild:currentLevel];
}

- (void)incrementLevel {
    [globals setLevel:[currentLevel getNextLevel]];
}

- (void)showNextLevelMenu {
    nextLevelMenu.rotation = rotation;
    nextLevelMenu.visible=true;
    levelLabel.string=[NSString stringWithFormat:@"Level %i\nComplete!", globals.currentLevelNumber];
    [[CCDirector sharedDirector] pause];
    isPaused=YES;
    pauseButton.visible = NO;
    pauseButton.enabled = NO;
}

- (void)toNextLevel {
    nextLevelMenu.visible=false;
    [[CCDirector sharedDirector] resume];
    isPaused=NO;
    pauseButton.visible = YES;
    pauseButton.enabled = YES;
    [cat setIsKnocking:NO];
    [self incrementLevel];
    [self clearLevel];
    [self loadLevel: NO];
}


//-------------------touch stuff

/*
 * Handling tap/hold/clench using touches
 */
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{

    if (!isPaused){
        if (isCatImmune) {
            //ending hover and getting cat to start at beginning of level
            [self endCatImmunity];
        }
        else if (![cat getIsKnocking]){
            //try to cling
            [cat tryToCling];
            if ([[globals getCurrentLevelName] isEqualToString:@"levels/Level4"]){
                [tutorial clingHold];
            }
        }
    }
}
- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [cat endCling:rotation];
    if ([[globals getCurrentLevelName] isEqualToString:@"levels/Level4"]){
        if ([cat didClingTutorial]){
            CCLOG(@"good job you clung");
            [tutorial cling];
        }
    }
}
- (void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    [self pause];
}


//------------------------ for accelerometer

/*
 * onEnter and onExit call to start and stop the accelerometer on the phone
 */
- (void)onEnter
{
    [super onEnter];
    
    [motionManager startAccelerometerUpdates];
}

- (void)onExit
{
    [super onExit];
    
    [motionManager stopAccelerometerUpdates];
}





@end
