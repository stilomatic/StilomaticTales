//
//  ASTMissile.m
//  StilomaticTales
//
//  Created by Antonio Stilo on 16.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTMissile.h"
#import "ASTMathUtils.h"
#import "SKEmitterNode+SKEmitterNode_Utils.h"

@implementation ASTMissile
@synthesize emitter;


-(id)initWithImageNamed:(NSString *)name andPosition:(CGPoint)position
{
    self = [super initWithImageNamed:name];
    if (self) {
        self.position = CGPointMake(position.x, position.y-30);
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.categoryBitMask = missileCategory;
        self.physicsBody.collisionBitMask = projectileCategory | wallCategory;
        self.physicsBody.contactTestBitMask = projectileCategory | wallCategory;
        self.physicsBody.velocity = CGVectorMake(0.0, 2.0);
        self.physicsBody.friction = 0.9;
        self.physicsBody.linearDamping = 0.4;
        self.physicsBody.mass = 2.0;
        self.physicsBody.affectedByGravity = YES;
    }
    
    return self;
    
}

@end
