//
//  ASTMathUtils.m
//  Bubble
//
//  Created by Antonio Stilo on 12.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTMathUtils.h"

@implementation ASTMathUtils

+(CGFloat)getRandom:(CGFloat)limit
{
    
    return floorf(((double)arc4random() / ARC4RANDOM_MAX) * limit);

}

@end
