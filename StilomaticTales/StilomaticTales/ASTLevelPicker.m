//
//  ASTLevelPicker.m
//  StilomaticTales
//
//  Created by Antonio_Stilo on 10/3/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTLevelPicker.h"

@implementation ASTLevelPicker
@synthesize controller,index;

-(id)initWithImageNamed:(NSString *)name
{
    self = [super initWithImageNamed:name];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    
    return self;

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [controller sceneChange:self.scene andIndex:index];
}

@end
