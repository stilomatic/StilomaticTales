//
//  ASTDsiplayNode.h
//  StilomaticTales
//
//  Created by Antonio Stilo on 13.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASTGameConstants.h"

@interface ASTDisplayNode : SKNode
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

-(id)init;
-(void)update;

@end
