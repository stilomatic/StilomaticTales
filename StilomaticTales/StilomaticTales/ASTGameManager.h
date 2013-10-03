//
//  ASTGameManager.h
//  Bubble
//
//  Created by Antonio Stilo on 12.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASTSceneChangeDelegate.h"

@interface ASTGameManager : NSObject
{


}
@property (nonatomic) NSInteger level;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger lifes;
@property (nonatomic) NSInteger playerEnergy;
@property (nonatomic) NSInteger villanEnergy;
@property (nonatomic,unsafe_unretained) id<ASTSceneChangeDelegate> delegate;

-(void)newLevel;
-(void)villanHited;
-(void)playerHited;
-(void)playerScore:(NSInteger)_value;
+ (ASTGameManager *)sharedInstance;

@end
