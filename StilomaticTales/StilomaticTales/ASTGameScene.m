//
//  ASTMyScene.m
//  Bubble
//
//  Created by Antonio Stilo on 10.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTGameScene.h"
#import "ASTShield.h"
#import "ASTGameManager.h"
#import "ASTMissile.h"
#import "SKEmitterNode+SKEmitterNode_Utils.h"
#import <Foundation/Foundation.h>
#import "ASTScoreScene.h"

@implementation ASTGameScene
@synthesize projectiles,canon,villan,display,bottom,levelProperties;


-(id)initWithSize:(CGSize)size andProperties:(NSDictionary*)level
{

    if (self = [super initWithSize:size]) {
        
        ASTGameManager *gm = [ASTGameManager sharedInstance];
        [gm newLevel];
        [gm setDelegate:self];
        
        levelProperties = level;
        
        projectiles = [NSMutableArray array];
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        SKSpriteNode *bck = [[SKSpriteNode alloc] initWithImageNamed:@"bck-iphone2.png"];
        bck.anchorPoint = CGPointMake(0.0, 0.0);
        [self addChild:bck];
        
        CGFloat gravity = [[levelProperties objectForKey:@"worldGravity"] floatValue] * -0.5;
        self.physicsWorld.gravity = CGVectorMake(0.0, gravity);
        self.physicsWorld.speed = [[levelProperties objectForKey:@"worldSpeed"] floatValue];
        self.physicsWorld.contactDelegate = self;

        
    
        int row = 0;
        int column = 0;
        
        for(int i = 0; i < [[levelProperties objectForKey:@"shields"] integerValue]; i++){
            
            int random = (int)[ASTMathUtils getRandom:6];
            if (random == 0) {
                ASTShield *shield = [[ASTShield alloc] initWithImageNamed:@"bubble.png"];
                shield.position = CGPointMake(30+(30*row), -(30*column)+460);
                [self addChild:shield];
            }
            
            row++;
            if (row % 10 ==0) {
                column++;
                row = 0;
            }

        }
        
        villan = [[ASTVillan alloc] initWithImageNamed:[levelProperties objectForKey:@"villan"]];
        villan.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:villan];
        
        canon = [[SKSpriteNode alloc] initWithImageNamed:@"cannon.png"];
        canon.position = CGPointMake(size.width/2, 30);
        canon.zRotation = M_PI;
        canon.anchorPoint = CGPointMake(0.5, 1.0);
        [self addChild:canon];
        
        bottom = [[SKSpriteNode alloc] initWithImageNamed:@"ground.png"];
        bottom.position = CGPointMake(160.0, 30.0);
        bottom.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(-160.0, -30.0, 320.0, 44.0)];
        bottom.physicsBody.categoryBitMask = wallCategory;
        bottom.physicsBody.collisionBitMask =  missileCategory;
        bottom.physicsBody.contactTestBitMask = missileCategory;
        bottom.physicsBody.restitution = 0.5;
        bottom.physicsBody.dynamic = NO;
        bottom.blendMode = SKBlendModeMultiply;
        [self addChild:bottom];
        
        display = [[ASTDisplayNode alloc] init];
        display.position = CGPointMake(0, 440);
        [self addChild:display];
        
    }
    return self;
}

-(void)sceneChange:(SKScene *)scene andIndex:(NSInteger)index
{
    SKTransition *reveal = [SKTransition fadeWithDuration:1.0];
    ASTScoreScene *newScene = [[ASTScoreScene alloc] initWithSize:self.frame.size];
    newScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene:newScene transition: reveal];
    
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
    
    if ((firstBody.categoryBitMask & shieldCategory)  != 0)
    {
        [gm playerScore:10];
        [self hit:firstBody.node];
    }
    
    if ((secondBody.categoryBitMask & villanCategory) != 0)
    {
        [gm playerScore:20];
        [gm villanHited];
        [self explode:villan];
        if(gm.villanEnergy <= 0){
            [villan setIsDead:YES];
        }
    }
    
    if ((firstBody.categoryBitMask & projectileCategory) != 0)
    {
        [self hit:firstBody.node];
        
        if((secondBody.categoryBitMask & missileCategory) != 0){
            [self hit:secondBody.node];
            [self explode:secondBody.node];
        }
    }
    
    if ((firstBody.categoryBitMask & missileCategory) != 0)
    {
        [self hit:firstBody.node];
        
        if((secondBody.categoryBitMask & wallCategory) != 0){
            [gm playerHited];
            [self explode:firstBody.node];
        }
    }
}


-(void)explode:(SKNode*)node
{
    SKEmitterNode *emitter = [SKEmitterNode ast_emitterNodeWithEmitterNamed:@"BokeParticles"];
    emitter.position = node.position;
    emitter.alpha = 0.5;
    [emitter runAction:[SKAction fadeOutWithDuration:1.0] completion:^{
        [emitter removeFromParent];
    }];
    [self addChild:emitter];

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
    if (!villan.isDead) {
        [self launchProjectile];
    }
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
        SKSpriteNode *projectile = (SKSpriteNode*)obj;
        if (projectile.position.x < 0.0 || projectile.position.x > 320.0) {
            [projectile removeFromParent];
            [projectiles removeObject:projectile];
            projectile = nil;
        }
    }];
    
    [display update];
    [villan update];
    
    if (!villan.isDead && [ASTMathUtils getRandom:[[levelProperties objectForKey:@"missileFrequency"] floatValue]] == 0) {
        [self launchMissile];
    }
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
}

-(void)launchProjectile
{
    SKSpriteNode *tmpProjectile = [[SKSpriteNode alloc] initWithImageNamed:@"bubble.png"];
    tmpProjectile.position = CGPointMake(160.0, 80.0);
    tmpProjectile.xScale = tmpProjectile.yScale = 0.3;
    tmpProjectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:tmpProjectile.size.width*0.5];
    tmpProjectile.physicsBody.dynamic = YES;
    tmpProjectile.physicsBody.categoryBitMask = projectileCategory;
    tmpProjectile.physicsBody.contactTestBitMask = villanCategory | shieldCategory | wallCategory;
    tmpProjectile.physicsBody.collisionBitMask = villanCategory | shieldCategory | wallCategory;
    CGFloat missileLaunchImpulse = [[levelProperties objectForKey:@"projectileImpulse"] floatValue];
    CGFloat angle = (M_PI/2) - canon.zRotation;
    CGVector vector = CGVectorMake(missileLaunchImpulse*cosf(angle), missileLaunchImpulse*sinf(angle));
    tmpProjectile.physicsBody.velocity = vector;
    [tmpProjectile.physicsBody applyImpulse:vector];
    [self addChild:tmpProjectile];
    [projectiles addObject:tmpProjectile];
    canon.zPosition = self.children.count-1;
}


@end
