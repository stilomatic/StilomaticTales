//
//  ASTScoreScene.m
//  StilomaticTales
//
//  Created by Antonio_Stilo on 10/3/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTScoreScene.h"
#import "ASTHomeScene.h"
#import "ASTButtonSprite.h"
#import "ASTGameManager.h"

@implementation ASTScoreScene

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        SKSpriteNode *bck = [[SKSpriteNode alloc] initWithImageNamed:@"bckHome.png"];
        bck.anchorPoint = CGPointMake(0.0, 0.0);
        [self addChild:bck];
        
        ASTGameManager *gm = [ASTGameManager sharedInstance];
        score = gm.score;
        energy = gm.playerEnergy;
        valueEnergy = 0.0;
        valueScore = 0.0;
        
        ASTButtonSprite *button = [[ASTButtonSprite alloc] initWithImageNamed:@"playBtn-iphone.png"];
        button.position = CGPointMake(self.size.width*0.5, 40);
        button.userInteractionEnabled = YES;
        button.delegate = self;
        button.xScale = button.yScale = 0.2;
        [self addChild:button];
        [button runAction:[SKAction scaleTo:1.0 duration:1.0]];
        
        lifesLabel = [SKLabelNode labelNodeWithFontNamed:font];
        lifesLabel.text = [NSString stringWithFormat:@"Lifes: %u",gm.lifes];
        lifesLabel.position = CGPointMake(120.0, 140.0);
        lifesLabel.fontSize = 24.0;
        lifesLabel.fontColor = [SKColor blackColor];
        [self addChild:lifesLabel];
        
        energyLabel = [SKLabelNode labelNodeWithFontNamed:font];
        energyLabel.text = [NSString stringWithFormat:@"Energy: %u",valueEnergy];
        energyLabel.position = CGPointMake(120.0, 180.0);
        energyLabel.fontSize = 24.0;
        energyLabel.fontColor = [SKColor blackColor];
        [self addChild:energyLabel];
        
        levelLabel = [SKLabelNode labelNodeWithFontNamed:font];
        levelLabel.text = [NSString stringWithFormat:@"Level: %u",gm.level];
        levelLabel.position = CGPointMake(120.0, 200.0);
        levelLabel.fontSize = 24.0;
        levelLabel.fontColor = [SKColor blackColor];
        [self addChild:levelLabel];
        
        scoreLabel = [SKLabelNode labelNodeWithFontNamed:font];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %u",valueScore];
        scoreLabel.position = CGPointMake(120.0, 240.0);
        scoreLabel.fontSize = 32.0;
        scoreLabel.fontColor = [SKColor blackColor];
        [self addChild:scoreLabel];
    }
    
    return self;
}

-(void)sceneChange:(SKScene *)scene andIndex:(NSInteger)index
{
    SKTransition *reveal = [SKTransition fadeWithDuration:1.0];
    ASTHomeScene *newScene = [[ASTHomeScene alloc] initWithSize:self.frame.size];
    newScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene:newScene transition: reveal];
    
}


-(void)update:(CFTimeInterval)currentTime {
    if (valueScore <= score) {
        valueScore++;
    }
    
    if (valueEnergy >= energy) {
        valueEnergy--;
    }else{
        valueEnergy = energy;
    }
    
    energyLabel.text = [NSString stringWithFormat:@"Energy: %u",valueEnergy];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %u",valueScore];
}

@end
