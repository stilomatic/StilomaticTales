//
//  ASTCanon.m
//  Bubble
//
//  Created by Antonio Stilo on 10.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTVillan.h"
#import "ASTMathUtils.h"
#import "ASTGameScene.h"

@implementation ASTVillan
@synthesize isDead,isLastAnim;

-(id)initWithImageNamed:(NSString *)name
{
    self = [super initWithImageNamed:name];
    if (self) {
        self.xScale = self.yScale = 0.5;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/3];
        self.physicsBody.density = 100.0;
        self.physicsBody.velocity = CGVectorMake(0.0, 0.0);
        self.physicsBody.mass = 100.0;
        self.physicsBody.friction = 1000.0;
        self.physicsBody.linearDamping = 100.0;
        self.physicsBody.categoryBitMask = villanCategory;
        self.physicsBody.contactTestBitMask = projectileCategory;
        self.physicsBody.collisionBitMask = projectileCategory;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        isDead = NO;
        isLastAnim = NO;
    }
    
    return self;
}

-(void)update
{
    if (!isDead) {
        if ([ASTMathUtils getRandom:10] == 0 && !self.hasActions) {
            [self runAction:[SKAction moveToX:[ASTMathUtils getRandom:320] duration:1.5]];
            [self runAction:[SKAction moveToY:(140+[ASTMathUtils getRandom:320]) duration:1.5]];
            [self runAction:[SKAction scaleTo:(0.3+[ASTMathUtils getRandom:0.7]) duration:1.5]];
        }
    }else{
        //[self removeAllActions];
        if (!isLastAnim) {
            isLastAnim = YES;
            [self runAction:[SKAction scaleTo:1.5 duration:1]];
            [self runAction:[SKAction fadeOutWithDuration:1]];
            [self runAction:[SKAction rotateByAngle:(M_PI*4) duration:1]];
        }
    }

}

@end
