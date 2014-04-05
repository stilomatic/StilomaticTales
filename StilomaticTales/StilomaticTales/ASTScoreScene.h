//
//  ASTScoreScene.h
//  StilomaticTales
//
//  Created by Antonio_Stilo on 10/3/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASTSceneChangeDelegate.h"
#import "ASTGameConstants.h"

@interface ASTScoreScene : SKScene <ASTSceneChangeDelegate>
{
    SKLabelNode *lifesLabel;
    SKLabelNode *levelLabel;
    SKLabelNode *energyLabel;
    SKLabelNode *scoreLabel;
    
    NSInteger life;
    NSInteger energy;
    NSInteger score;
    NSInteger valueEnergy;
    NSInteger valueScore;

}

@end
