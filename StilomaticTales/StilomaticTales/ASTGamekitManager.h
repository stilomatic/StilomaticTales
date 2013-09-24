//
//  ASTGamekitManager.h
//  StilomaticTales
//
//  Created by Antonio_Stilo on 9/24/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface ASTGamekitManager : NSObject

@property (nonatomic,strong) UIViewController *currentViewController;

-(NSArray*)retriveBestScores;
-(void)submitScore:(NSInteger)score;
-(void)login;

+ (ASTGamekitManager *)sharedInstance;

@end
