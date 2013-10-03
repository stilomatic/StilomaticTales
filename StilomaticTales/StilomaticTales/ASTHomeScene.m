//
//  ASTHomeScene.m
//  StilomaticTales
//
//  Created by Antonio_Stilo on 10/3/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTHomeScene.h"
#import "ASTLevelPicker.h"
#import "ASTGameScene.h"

@implementation ASTHomeScene
@synthesize container,levelPropreties,containerPosition,touchPosition,containerWidth;

-(id)initWithSize:(CGSize)size
{
    
    if (self = [super initWithSize:size]) {
        
        
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"levels" ofType:@"plist"];
        levelPropreties = [NSArray arrayWithContentsOfFile:plistPath];
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
        SKSpriteNode *bck = [[SKSpriteNode alloc] initWithImageNamed:@"bckHome.png"];
        bck.anchorPoint = CGPointMake(0.0, 0.0);
        [self addChild:bck];
        
        SKSpriteNode *title = [[SKSpriteNode alloc] initWithImageNamed:@"title-iphone.png"];
        title.anchorPoint = CGPointMake(0.0, 0.0);
        title.position = CGPointMake(0.0, 300);
        [self addChild:title];
        
        SKSpriteNode *detail = [[SKSpriteNode alloc] initWithImageNamed:@"homedetail-iphone.png"];
        //detail.anchorPoint = CGPointMake(0.0, 0.0);
        detail.position = CGPointMake(160.0, 40);
        detail.xScale = detail.yScale = 0.5;
        [self addChild:detail];
    
        container = [[SKNode alloc] init];
        container.userInteractionEnabled = YES;
        containerPosition = CGPointMake(160.0, 0.0);
        container.position = CGPointMake(320.0, 0.0);
        [levelPropreties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ASTLevelPicker *villan = [[ASTLevelPicker alloc] initWithImageNamed:[(NSDictionary*)obj objectForKey:@"villan"]];
            villan.index = idx;
            villan.controller = self;
            villan.position = CGPointMake(320.0*idx, size.height/2);
            villan.xScale = villan.yScale = 0.7;
            [container addChild:villan];
        }];
        containerWidth = 320.0 * levelPropreties.count;
        [self addChild:container];
        
    }
    return self;
}

-(void)sceneChange:(SKScene *)scene andIndex:(NSInteger)index
{
    SKTransition *reveal = [SKTransition fadeWithDuration:1.0];
    ASTGameScene *newScene = [[ASTGameScene alloc] initWithSize:self.frame.size andProperties:[levelPropreties objectAtIndex:index]];
    newScene.scaleMode = SKSceneScaleModeAspectFill;
    reveal.pausesIncomingScene = YES;
    [self.scene.view presentScene:newScene transition: reveal];

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    touchPosition = [touch locationInNode:self];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchNewPosition = [touch locationInNode:self];
    
    CGFloat leftOrRight = (touchPosition.x-touchNewPosition.x);
    NSInteger sign = 1;
    if (leftOrRight < 0) {
        sign = -1;
    }
    CGPoint newLocation = CGPointMake(containerPosition.x-(320.0*sign), 0.0);
    if (newLocation.x <= 160.0 && newLocation.x > -(containerWidth-320)) {
        containerPosition = newLocation;
    }
}

-(void)update:(NSTimeInterval)currentTime
{
    CGFloat x = container.position.x;
    x -= (x - containerPosition.x)/6;
    container.position = CGPointMake(x, 0.0);

}

@end
