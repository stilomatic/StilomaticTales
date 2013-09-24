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
    self.lifes--;
    if (self.lifes <= 0) {
        [self gameOver];
    }
    [self setValue:[NSNumber numberWithInt:self.lifes] forKey:@"lifes"];

}
-(void)matchWin
{
    self.lifes++;
    self.level++;
    [self setValue:[NSNumber numberWithInt:self.lifes] forKey:@"lifes"];
    [self setValue:[NSNumber numberWithInt:self.level] forKey:@"level"];
    
    [currentViewController.navigationController popToRootViewControllerAnimated:YES];
}

-(void)newPlayer{
    
    self.playerEnergy = [NSNumber numberWithInt:20];
    [self setValue:self.playerEnergy forKey:@"playerEnergy"];

}

-(void)newVillan
{

    self.villanEnergy = self.level * 20;
    [self setValue:[NSNumber numberWithInt:self.villanEnergy] forKey:@"villanEnergy"];


}

#pragma mark PUBLIC METHODS

-(void)playerScore:(NSInteger)value
{
    int current = [self.score integerValue];
    current += value;
    score = [NSNumber numberWithInt:current];
    [self setValue:self.score forKey:@"score"];
}

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
    [self setValue:[NSNumber numberWithInt:self.villanEnergy] forKey:@"villanEnergy"];
}

-(void)playerHited
{
    int current = [self.playerEnergy integerValue];
    current--;
    if (current <= 0) {
        [self matchOver];
    }
    self.playerEnergy = [NSNumber numberWithInt:current];
    [self setValue:self.playerEnergy forKey:@"playerEnergy"];
    
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
