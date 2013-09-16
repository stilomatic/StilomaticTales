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
#import "ASTMissile.h"

@implementation ASTGame
@synthesize projectiles,missiles,canon,villan,display,bottom;


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        projectiles = [NSMutableArray array];
        missiles = [NSMutableArray array];
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        self.physicsWorld.gravity = CGPointMake(0.0, -0.5);
        self.physicsWorld.speed = 6.0;
        self.physicsWorld.contactDelegate = self;

        
        bottom = [[SKSpriteNode alloc] initWithImageNamed:@"wall.png"];
        bottom.position = CGPointMake(160.0, 10.0);
        bottom.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        bottom.physicsBody.categoryBitMask = wallCategory;
        bottom.physicsBody.collisionBitMask =  missileCategory;
        bottom.physicsBody.contactTestBitMask = missileCategory;
        bottom.physicsBody.restitution = 0.5;
        bottom.physicsBody.dynamic = NO;
        [self addChild:bottom];
        
    
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
    ASTGameManager *gm = [ASTGameManager sharedInstance];
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
    
    if ((firstBody.categoryBitMask & bubbleCategory)  != 0)
    {
        [gm playerScore:10];
        [self hit:firstBody.node];
    }
    
    if ((firstBody.categoryBitMask & villanCategory) != 0)
    {
        [gm playerScore:20];
        [gm villanHited];
    }
    
    if ((firstBody.categoryBitMask & wallCategory) != 0)
    {
        NSLog(@"** WALL HIT ***");
        //[self hit:firstBody.node];
        [self hit:secondBody.node];
    }
    
    if ((firstBody.categoryBitMask & missileCategory) != 0)
    {
        NSLog(@"** MISSILE HIT ***");
        //[self hit:firstBody.node];
        //[self hit:secondBody.node];
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
    ASTBubble *tmpProjectile = [[ASTBubble alloc] initWithImageNamed:@"bubble.png" isDynamic:NO];
    tmpProjectile.position = CGPointMake(160.0, 80.0);
    tmpProjectile.physicsBody.dynamic = YES;
    tmpProjectile.physicsBody.categoryBitMask = projectileCategory;
    tmpProjectile.physicsBody.contactTestBitMask = villanCategory | bubbleCategory | wallCategory;
    tmpProjectile.physicsBody.collisionBitMask = villanCategory | bubbleCategory | wallCategory;
    CGFloat missileLaunchImpulse = 4.0;
    CGFloat angle = (M_PI/2) + canon.zRotation;
    tmpProjectile.physicsBody.velocity = CGVectorMake(missileLaunchImpulse,missileLaunchImpulse*100);
    [tmpProjectile.physicsBody applyImpulse: CGVectorMake(missileLaunchImpulse*cosf(angle),
                                                   missileLaunchImpulse*sinf(angle))];
    [self addChild:tmpProjectile];
    [projectiles addObject:tmpProjectile];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        canon.zRotation = -atan2(canon.position.x-location.x, canon.position.y-location.y);
    }

}

-(void)update:(CFTimeInterval)currentTime {
    
    [projectiles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ASTBubble *projectile = (ASTBubble*)obj;
        if (projectile.position.x < 0.0 || projectile.position.x > 320.0) {
            [projectile removeFromParent];
            [projectiles removeObject:projectile];
            projectile = nil;
        }
    }];
    
    [missiles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ASTMissile *missile = (ASTMissile*)obj;
        if (missile.position.y < 10.0 || missile.position.y > 480.0) {
            [missile removeFromParent];
            [missiles removeObject:missile];
            missile = nil;
        }
    }];
    
    [display update];
    [villan update];
    if ([ASTMathUtils getRandom:50]==0) {
        [self launchMissile];
    }
    
    NSLog(@"*** Bottom %@",bottom);
}

-(void)hit:(SKNode*)node
{
    [node runAction:[SKAction scaleBy:1.5 duration:0.5]];
    [node runAction:[SKAction fadeOutWithDuration:0.5] completion:^{
        [node removeFromParent];
    }];

}

-(void)launchMissile
{
    
    ASTMissile *tmpMissile = [[ASTMissile alloc] initWithImageNamed:@"missile.png" andPosition:villan.position];
    [self addChild:tmpMissile];
    [missiles addObject:tmpMissile];
}


@end
