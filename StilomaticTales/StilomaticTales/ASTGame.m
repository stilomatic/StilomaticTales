//
//  ASTMyScene.m
//  Bubble
//
//  Created by Antonio Stilo on 10.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTGame.h"
#import "ASTBubble.h"
#import "ASTGameManager.h"

@implementation ASTGame
@synthesize canon,projectile,villan,display;


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        self.physicsWorld.gravity = CGPointMake(0.0, 0.5);
        self.physicsWorld.speed = 10.0;
        self.physicsWorld.contactDelegate = self;
        
        int row = 0;
        int column = 0;
        
        for(int i = 0; i < 80; i++){
            
            int random = (int)[ASTMathUtils getRandom:6];
            if (random == 0) {
                ASTBubble *bubble = [[ASTBubble alloc] initWithImageNamed:@"bubble.png" isDynamic:NO];
                bubble.position = CGPointMake(30+(30*row), -(30*column)+430);
                [self addChild:bubble];
            }
            
            row++;
            if (row % 10 ==0) {
                column++;
                row = 0;
            }

        }
        
        villan = [[ASTVillan alloc] initWithImageNamed:@"villan_0.png"];
        villan.position = CGPointMake(160, 300);
        [self addChild:villan];
        
        canon = [[SKSpriteNode alloc] initWithImageNamed:@"cannon.png"];
        canon.position = CGPointMake(160, 30);
        canon.zRotation = M_PI;
        canon.anchorPoint = CGPointMake(0.5, 1.0);
        [self addChild:canon];
        
        ASTGameManager *gm = [ASTGameManager sharedInstance];
        [gm newLevel];
        
        display = [[ASTDisplayNode alloc] init];
        display.position = CGPointMake(0, 440);
        [self addChild:display];
        
    }
    return self;
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }

    if ((firstBody.categoryBitMask & bubbleCategory) != 0 || (firstBody.categoryBitMask & projectileCategory) != 0 )
    {
        
        ASTGameManager *gm = [ASTGameManager sharedInstance];
        [gm playerScore:10];
        
        ASTBubble *buble = (ASTBubble*)firstBody.node;
        [buble runAction:[SKAction scaleBy:1.5 duration:0.5]];
        [buble runAction:[SKAction fadeOutWithDuration:0.5] completion:^{
            [buble removeFromParent];
        }];
    }
    
    if ((firstBody.categoryBitMask & villanCategory) != 0 || (firstBody.categoryBitMask & projectileCategory) != 0 )
    {
        
        ASTGameManager *gm = [ASTGameManager sharedInstance];
        [gm playerScore:20];
        [gm villanHited];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        canon.zRotation = -atan2(canon.position.x-location.x, canon.position.y-location.y);
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    projectile = [[ASTBubble alloc] initWithImageNamed:@"bubble.png" isDynamic:NO];
    projectile.position = CGPointMake(160, 80);
    [self addChild:projectile];
    projectile.physicsBody.dynamic = YES;
    projectile.physicsBody.contactTestBitMask = bubbleCategory | wallCategory;
    projectile.physicsBody.categoryBitMask = projectileCategory;
    CGFloat missileLaunchImpulse = -4.0;
    CGFloat angle = (M_PI/2)+canon.zRotation;
    projectile.physicsBody.velocity = CGVectorMake(missileLaunchImpulse,missileLaunchImpulse);
    [projectile.physicsBody applyImpulse: CGVectorMake(missileLaunchImpulse*cosf(angle),
                                                   missileLaunchImpulse*sinf(angle))];

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        canon.zRotation = -atan2(canon.position.x-location.x, canon.position.y-location.y);
    }


}

-(void)update:(CFTimeInterval)currentTime {
    [display update];
    [villan update];
}

@end
