//
//  ASTGameManager.m
//  Bubble
//
//  Created by Antonio Stilo on 12.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTGameManager.h"

@implementation ASTGameManager
@synthesize level,score,lifes,playerEnergy,villanEnergy,currentViewController;

-(void)gameOver
{

    [currentViewController.navigationController popToRootViewControllerAnimated:YES];

}

-(void)matchOver
{
    lifes--;
    if (lifes <= 0) {
        [self gameOver];
    }
    [self setValue:[NSNumber numberWithInteger:lifes] forKey:@"lifes"];

}
-(void)matchWin
{
    lifes++;
    level++;
    [self setValue:[NSNumber numberWithInteger:lifes] forKey:@"lifes"];
    [self setValue:[NSNumber numberWithInteger:level] forKey:@"level"];
    
    [currentViewController.navigationController popToRootViewControllerAnimated:YES];
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
        sharedInstance.lifes = 3;
        [sharedInstance newLevel];
    });
    return sharedInstance;
}

@end
