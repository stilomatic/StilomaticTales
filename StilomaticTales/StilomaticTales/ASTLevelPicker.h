//
//  ASTLevelPicker.h
//  StilomaticTales
//
//  Created by Antonio_Stilo on 10/3/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASTSceneChangeDelegate.h"

@interface ASTLevelPicker : SKSpriteNode

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,unsafe_unretained) id<ASTSceneChangeDelegate> controller;

@end
