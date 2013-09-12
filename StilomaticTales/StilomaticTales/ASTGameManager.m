//
//  ASTGameManager.m
//  Bubble
//
//  Created by Antonio Stilo on 12.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTGameManager.h"

@implementation ASTGameManager
@synthesize level,score,lifes,playerEnergy,villanEnergy;

-(void)gameOver
{


}

-(void)matchOver
{
    self.lifes--;
    if (self.lifes <= 0) {
        [self gameOver];
    }

}
-(void)matchWin
{
    self.lifes++;
    self.level++;
}

-(void)newPlayer{
    
    self.playerEnergy = 20;
}

-(void)newVillan
{

    self.villanEnergy = self.level * 20;

}

#pragma mark PUBLIC METHODS

-(void)newLevel
{
    
    [self newPlayer];
    [self newVillan];
    
}

-(void)villanHited
{
    self.villanEnergy--;
    if (self.villanEnergy <= 0) {
        [self matchWin];
    }
}

-(void)playerHited
{
    self.playerEnergy--;
    if (self.playerEnergy <= 0) {
        [self matchOver];
    }
}

+ (ASTGameManager *)sharedInstance
{
    static ASTGameManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ASTGameManager alloc] init];
        sharedInstance.level = 1;
        sharedInstance.score = 0;
        sharedInstance.lifes = 3;
    });
    return sharedInstance;
}

@end
