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
        
        self.alpha = 0.6;
        ASTGameManager *gm = [ASTGameManager sharedInstance];
        
        score = gm.score;
        energy = gm.playerEnergy;
        valueEnergy = gm.playerEnergy;
        valueScore = gm.score;
    
        [gm addObserver:self forKeyPath:@"playerEnergy" options:NSKeyValueObservingOptionNew context:nil];
        [gm addObserver:self forKeyPath:@"lifes" options:NSKeyValueObservingOptionNew context:nil];
        [gm addObserver:self forKeyPath:@"level" options:NSKeyValueObservingOptionNew context:nil];
        [gm addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionNew context:nil];

        
        
        SKSpriteNode *bck = [SKSpriteNode spriteNodeWithImageNamed:@"display.png"];
        bck.position = CGPointMake(160, 0);
        bck.blendMode = SKBlendModeAdd;
        //bck.yScale = 0.8;
        //bck.xScale = 1.6;
        [self addChild:bck];
        
        lifesLabel = [SKLabelNode labelNodeWithFontNamed:font];
        lifesLabel.text = [NSString stringWithFormat:@"Lifes: %u",gm.lifes];
        lifesLabel.position = CGPointMake(42.0, 8.0);
        lifesLabel.fontSize = 12.0;
        lifesLabel.fontColor = [SKColor blackColor];
        [self addChild:lifesLabel];
        
        energyLabel = [SKLabelNode labelNodeWithFontNamed:font];
        energyLabel.text = [NSString stringWithFormat:@"Energy: %u",valueEnergy];
        energyLabel.position = CGPointMake(102.0, 8.0);
        energyLabel.fontSize = 12.0;
        energyLabel.fontColor = [SKColor blackColor];
        [self addChild:energyLabel];
        
        levelLabel = [SKLabelNode labelNodeWithFontNamed:font];
        levelLabel.text = [NSString stringWithFormat:@"Level: %u",gm.level];
        levelLabel.position = CGPointMake(182.0, 8.0);
        levelLabel.fontSize = 12.0;
        levelLabel.fontColor = [SKColor blackColor];
        [self addChild:levelLabel];
        
        scoreLabel = [SKLabelNode labelNodeWithFontNamed:font];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %u",valueScore];
        scoreLabel.position = CGPointMake(242.0, 8.0);
        scoreLabel.fontSize = 12.0;
        scoreLabel.fontColor = [SKColor blackColor];
        [self addChild:scoreLabel];
    
    }
    
    return self;
}

-(void)dealloc
{
    ASTGameManager *gm = [ASTGameManager sharedInstance];
    [gm removeObserver:self forKeyPath:@"playerEnergy"];
    [gm removeObserver:self forKeyPath:@"lifes"];
    [gm removeObserver:self forKeyPath:@"level"];
    [gm removeObserver:self forKeyPath:@"score"];
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
    
    if (valueScore <= score) {
        valueScore++;
    }
    
    if (valueEnergy > energy) {
        valueEnergy--;
    }else{
        valueEnergy = energy;
    }
    
    energyLabel.text = [NSString stringWithFormat:@"Energy: %u",valueEnergy];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %u",valueScore];
}

@end
