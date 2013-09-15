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
    [self setValue:[NSNumber numberWithInt:self.lifes] forKey:@"lifes"];

}
-(void)matchWin
{
    NSLog(@"\n\n MATCH WIN \n\n");
    self.lifes++;
    self.level++;
    [self setValue:[NSNumber numberWithInt:self.lifes] forKey:@"lifes"];
    [self setValue:[NSNumber numberWithInt:self.level] forKey:@"level"];
}

-(void)newPlayer{
    
    self.playerEnergy = 20;
    [self setValue:[NSNumber numberWithInt:self.playerEnergy] forKey:@"playerEnergy"];

}

-(void)newVillan
{

    self.villanEnergy = self.level * 20;
    [self setValue:[NSNumber numberWithInt:self.villanEnergy] forKey:@"villanEnergy"];


}

#pragma mark PUBLIC METHODS

-(void)playerScore:(NSInteger)value
{
    self.score += value;
    [self setValue:[NSNumber numberWithInt:self.score] forKey:@"score"];
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
    self.playerEnergy--;
    if (self.playerEnergy <= 0) {
        [self matchOver];
    }
    [self setValue:[NSNumber numberWithInt:self.playerEnergy] forKey:@"playerEnergy"];
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
