//
//  ASTMyScene.h
//  Bubble
//

//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASTBubble.h"
#import "ASTVillan.h"
#import "ASTDisplayNode.h"
#import "ASTMathUtils.h"

@interface ASTGame : SKScene <SKPhysicsContactDelegate>

@property (nonatomic,strong) NSMutableArray *projectiles;

@property (nonatomic,strong) SKSpriteNode *bottom;
@property (nonatomic,strong) SKSpriteNode *canon;
@property (nonatomic,strong) ASTVillan *villan;
@property (nonatomic,strong) ASTDisplayNode *display;

-(void)launchProjectile;
-(void)launchMissile;
-(void)hit:(SKNode*)node;

@end
