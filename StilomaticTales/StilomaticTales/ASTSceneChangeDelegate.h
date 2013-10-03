//
//  ASTSceneChangeDelegate.h
//  StilomaticTales
//
//  Created by Antonio_Stilo on 10/3/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKScene;

@protocol ASTSceneChangeDelegate <NSObject>

-(void)sceneChange:(SKScene*)scene andIndex:(NSInteger)index;

@end
