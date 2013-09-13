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
        
        score = gm.score;
        energy = gm.playerEnergy;
        valueEnergy = gm.playerEnergy;
        valueScore = gm.score;
        
        [gm addObserver:self forKeyPath:@"playerEnergy" options:NSKeyValueObservingOptionNew context:nil];
        [gm addObserver:self forKeyPath:@"lifes" options:NSKeyValueObservingOptionNew context:nil];
        [gm addObserver:self forKeyPath:@"level" options:NSKeyValueObservingOptionNew context:nil];
        [gm addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionNew context:nil];
        
        SKSpriteNode *bck = [SKSpriteNode spriteNodeWithImageNamed:@"bck.png"];
        bck.position = CGPointMake(160, 0);
        [self addChild:bck];
        
        lifesLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        lifesLabel.text = [NSString stringWithFormat:@"Lifes: %u",gm.lifes];
        lifesLabel.position = CGPointMake(12.0, 2.0);
        lifesLabel.fontSize = 11.0;
        [self addChild:lifesLabel];
        
        energyLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        energyLabel.text = [NSString stringWithFormat:@"Energy: %u",valueEnergy];
        energyLabel.position = CGPointMake(72.0, 2.0);
        energyLabel.fontSize = 11.0;
        [self addChild:energyLabel];
        
        levelLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        levelLabel.text = [NSString stringWithFormat:@"Level: %u",gm.level];
        levelLabel.position = CGPointMake(132.0, 2.0);
        levelLabel.fontSize = 11.0;
        [self addChild:levelLabel];
        
        scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %u",valueScore];
        scoreLabel.position = CGPointMake(232.0, 2.0);
        scoreLabel.fontSize = 11.0;
        [self addChild:scoreLabel];
    
    }
    
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    NSInteger value = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
    if ([keyPath isEqualToString:@"playerEnergy"]) {
        energy = value;
    }else if ([keyPath isEqualToString:@"lifes"]) {
        lifesLabel.text = [NSString stringWithFormat:@"Lifes: %u",value];
    }else if ([keyPath isEqualToString:@"level"]) {
        levelLabel.text = [NSString stringWithFormat:@"Level: %u",value];
    }else if ([keyPath isEqualToString:@"score"]) {
        score = value;
    }
}

-(void)update
{
    
    if (valueScore < score) {
        valueScore++;
    }
    
    if (valueEnergy > energy) {
        valueEnergy--;
    }
    
    energyLabel.text = [NSString stringWithFormat:@"Energy: %u",valueEnergy];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %u",valueScore];
}

@end
