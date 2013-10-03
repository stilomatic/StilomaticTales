//
//  ASTGameManager.m
//  Bubble
//
//  Created by Antonio Stilo on 12.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTGameManager.h"

@implementation ASTGameManager
@synthesize level,score,lifes,playerEnergy,villanEnergy,delegate;

-(void)gameOver
{

    [delegate sceneChange:nil andIndex:-1];

}

-(void)matchOver
{
    lifes--;
    [self newPlayer];
    if (lifes <= 0) {
        [self gameOver];
    }
    [self setValue:[NSNumber numberWithInteger:lifes] forKey:@"lifes"];

}
-(void)matchWin
{
    lifes++;
    level++;
    [delegate sceneChange:nil andIndex:0];
    [self setValue:[NSNumber numberWithInteger:lifes] forKey:@"lifes"];
    [self setValue:[NSNumber numberWithInteger:level] forKey:@"level"];
}

-(void)newPlayer{
    
    playerEnergy = 20;
    [self setValue:[NSNumber numberWithInteger:playerEnergy] forKey:@"playerEnergy"];

}

-(void)newVillan
{

    villanEnergy = level * 20;
    [self setValue:[NSNumber numberWithInteger:villanEnergy] forKey:@"villanEnergy"];


}

#pragma mark PUBLIC METHODS

-(void)playerScore:(NSInteger)_value
{
    score += _value;
    [self setValue:[NSNumber numberWithInteger:score] forKey:@"score"];
}

-(void)newLevel
{
    lifes = 3;
    [self newPlayer];
    [self newVillan];
    
}

-(void)villanHited
{
    villanEnergy--;
    if (villanEnergy <= 0) {
        [self matchWin];
    }
    [self setValue:[NSNumber numberWithInteger:villanEnergy] forKey:@"villanEnergy"];
}

-(void)playerHited
{
    playerEnergy--;
    if (playerEnergy <= 0) {
        [self matchOver];
    }
    [self setValue:[NSNumber numberWithInteger:playerEnergy] forKey:@"playerEnergy"];
    
}

+ (ASTGameManager *)sharedInstance
{
    static ASTGameManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ASTGameManager alloc] init];
        sharedInstance.level = 1;
        sharedInstance.score = 0;
        [sharedInstance newLevel];
    });
    return sharedInstance;
}

@end
