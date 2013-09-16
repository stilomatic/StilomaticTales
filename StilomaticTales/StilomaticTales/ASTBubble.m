//
//  ASTBubble.m
//  Bubble
//
//  Created by Antonio Stilo on 10.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTBubble.h"
#import "ASTMathUtils.h"


@implementation ASTBubble
@synthesize gender;

-(id)initWithImageNamed:(NSString *)name isDynamic:(BOOL)dynamic
{
    self = [super initWithImageNamed:name];
    if (self) {
        self.gender = [ASTMathUtils getRandom:3];
        self.xScale = self.yScale = 0.4;
        
        if (self.gender == 0) {
            [self runAction:[SKAction colorizeWithColor:[SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5] colorBlendFactor:0.5 duration:1.0]];
        }else if(self.gender == 1){
            [self runAction:[SKAction colorizeWithColor:[SKColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.5] colorBlendFactor:0.5 duration:1.0]];
        }else if(self.gender == 2){
            [self runAction:[SKAction colorizeWithColor:[SKColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5] colorBlendFactor:0.5 duration:1.0]];
        }
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
        self.physicsBody.dynamic = dynamic;
        self.physicsBody.categoryBitMask = bubbleCategory;
        self.physicsBody.contactTestBitMask = projectileCategory;
        self.physicsBody.collisionBitMask = projectileCategory;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.name = @"buble";
    }
    return self;
}

-(void)hit
{
    NSLog(@"--------- HIT --------");
}

@end
