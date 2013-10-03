//
//  ASTMyScene.h
//  Bubble
//

//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASTShield.h"
#import "ASTVillan.h"
#import "ASTDisplayNode.h"
#import "ASTMathUtils.h"
#import "ASTSceneChangeDelegate.h"

@interface ASTGameScene : SKScene <SKPhysicsContactDelegate,ASTSceneChangeDelegate>


@property (nonatomic,strong) NSDictionary *levelProperties;
@property (nonatomic,strong) NSMutableArray *projectiles;

@property (nonatomic,strong) SKSpriteNode *bottom;
@property (nonatomic,strong) SKSpriteNode *canon;
@property (nonatomic,strong) ASTVillan *villan;
@property (nonatomic,strong) ASTDisplayNode *display;

-(id)initWithSize:(CGSize)size andProperties:(NSDictionary*)level;
-(void)launchProjectile;
-(void)launchMissile;
-(void)hit:(SKNode*)node;

@end
