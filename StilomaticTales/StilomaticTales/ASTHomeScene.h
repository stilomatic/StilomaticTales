//
//  ASTHomeScene.h
//  StilomaticTales
//
//  Created by Antonio_Stilo on 10/3/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASTSceneChangeDelegate.h"

@interface ASTHomeScene : SKScene <ASTSceneChangeDelegate>

@property (nonatomic,strong) NSArray *levelPropreties;
@property (nonatomic,strong) SKNode *container;
@property (nonatomic,assign) CGPoint containerPosition;
@property (nonatomic,assign) CGPoint touchPosition;
@property (nonatomic,assign) CGFloat containerWidth;

-(id)initWithSize:(CGSize)size;

@end
