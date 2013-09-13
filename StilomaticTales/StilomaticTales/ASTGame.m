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
@synthesize canon,projectile,display;


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        //self.physicsWorld = [[SKPhysicsWorld alloc] init];
        
        self.physicsWorld.gravity = CGPointMake(0, 0.0);
        self.physicsWorld.speed = 10.0;
        self.physicsWorld.contactDelegate = self;
        
        SKNode *bottom = [[SKNode alloc] init];
        bottom.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(320, 44)];
        bottom.physicsBody.density = 1.0;
        
        
        int row = 0;
        int column = 0;
        
        for(int i = 0; i < 80; i++){
            int random = (int)[ASTMathUtils getRandom:3];
            
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
        
        canon = [[SKSpriteNode alloc] initWithImageNamed:@"cannon.png"];
        canon.position = CGPointMake(160, 40);
        canon.zRotation = 0.0;
        [self addChild:canon];
        
        display = [[ASTDisplayNode alloc] init];
        display.position = CGPointMake(0, 440);
        [self addChild:display];
        
        ASTGameManager *gm = [ASTGameManager sharedInstance];
        [gm newLevel];

    }
    return self;
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
   // NSLog(@"\n\n ++ CONTACT++++++++++++++++++++++++++++++++++++++++++++\n\n");
    
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
    
   // NSLog(@"**CONTACT TYPE %i",((firstBody.categoryBitMask & bubbleCategory) != 0));
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
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    projectile = [[ASTBubble alloc] initWithImageNamed:@"bubble.png" isDynamic:NO];
    projectile.position = CGPointMake(160, 40);
    [self addChild:projectile];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    projectile.physicsBody.dynamic = YES;
    projectile.physicsBody.contactTestBitMask = bubbleCategory | wallCategory;
    projectile.physicsBody.categoryBitMask = projectileCategory;
    CGFloat missileLaunchImpulse = -6.0;
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
}

@end
