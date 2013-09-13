//
//  ASTDsiplayNode.m
//  StilomaticTales
//
//  Created by Antonio Stilo on 13.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTDisplayNode.h"
#import "ASTGameManager.h"

@implementation ASTDisplayNode


-(id)init
{
    self = [super init];
    if(self){
        
        ASTGameManager *gm = [ASTGameManager sharedInstance];
        
        SKSpriteNode *bck = [SKSpriteNode spriteNodeWithImageNamed:@"bck.png"];
        [self addChild:bck];
        
        lifesLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        lifesLabel.text = [NSString stringWithFormat:@"Lifes: %u",gm.lifes];
        lifesLabel.position = CGPointMake(2.0, 2.0);
        lifesLabel.fontSize = 11.0;
        [self addChild:lifesLabel];
        
        energyLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        energyLabel.text = [NSString stringWithFormat:@"Energy: %u",gm.playerEnergy];
        energyLabel.position = CGPointMake(62.0, 2.0);
        energyLabel.fontSize = 11.0;
        [self addChild:energyLabel];
        
        levelLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        levelLabel.text = [NSString stringWithFormat:@"Level: %u",gm.level];
        levelLabel.position = CGPointMake(122.0, 2.0);
        levelLabel.fontSize = 11.0;
        [self addChild:levelLabel];
    
    }
    
    return self;
}

@end
