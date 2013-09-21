//
//  SKEmitterNode+SKEmitterNode_Utils.m
//  Stilomatic
//
//  Created by Antonio_Stilo on 9/8/13.
//  Copyright (c) 2013 Antonio_Stilo. All rights reserved.
//

#import "SKEmitterNode+SKEmitterNode_Utils.h"

@implementation SKEmitterNode (SKEmitterNode_Utils)
+ (instancetype)ast_emitterNodeWithEmitterNamed:(NSString *)emitterFileName {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:emitterFileName ofType:@"sks"]];
}
@end
