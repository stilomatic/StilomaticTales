//
//  ASTButtonSprite.m
//  StilomaticTales
//
//  Created by Antonio_Stilo on 10/3/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTButtonSprite.h"

@implementation ASTButtonSprite
@synthesize delegate;

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate sceneChange:self.scene andIndex:-1];
}

@end
