//
//  ASTGameManager.h
//  Bubble
//
//  Created by Antonio Stilo on 12.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASTGameManager : NSObject

@property (nonatomic) NSInteger level;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger lifes;
@property (nonatomic) NSInteger playerEnergy;
@property (nonatomic) NSInteger villanEnergy;

-(void)newLevel;
-(void)villanHited;
-(void)playerHited;
-(void)playerScore:(NSInteger)value;
+ (ASTGameManager *)sharedInstance;

@end
