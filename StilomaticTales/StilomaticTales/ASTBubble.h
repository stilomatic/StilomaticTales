//
//  ASTBubble.h
//  Bubble
//
//  Created by Antonio Stilo on 10.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASTBubble : SKSpriteNode

@property (nonatomic) NSInteger gender;

-(id)initWithImageNamed:(NSString *)name isDynamic:(BOOL)dynamic;
-(void)hit;

@end
