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

@implementation ASTScoreScene

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        SKSpriteNode *bck = [[SKSpriteNode alloc] initWithImageNamed:@"bckHome.png"];
        bck.anchorPoint = CGPointMake(0.0, 0.0);
        [self addChild:bck];
        
        ASTButtonSprite *button = [[ASTButtonSprite alloc] initWithImageNamed:@"playBtn-iphone.png"];
        button.position = CGPointMake(self.size.width*0.5, 40);
        button.userInteractionEnabled = YES;
        button.delegate = self;
        button.xScale = button.yScale = 0.2;
        [self addChild:button];
        [button runAction:[SKAction scaleTo:1.0 duration:1.0]];
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

@end
