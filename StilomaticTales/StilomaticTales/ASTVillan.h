//
//  ASTCanon.h
//  Bubble
//
//  Created by Antonio Stilo on 10.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASTVillan : SKSpriteNode

@property (nonatomic,assign) BOOL isDead;
@property (nonatomic,assign) BOOL isLastAnim;

-(void)update;

@end
