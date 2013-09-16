//
//  ASTMathUtils.h
//  Bubble
//
//  Created by Antonio Stilo on 12.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ARC4RANDOM_MAX      0x100000000

static const uint32_t bubbleCategory     =  0x1 << 0;
static const uint32_t projectileCategory =  0x1 << 1;
static const uint32_t missileCategory    =  0x1 << 2;
static const uint32_t villanCategory     =  0x1 << 3;
static const uint32_t wallCategory       =  0x1 << 4;

@interface ASTMathUtils : NSObject

+(CGFloat)getRandom:(NSInteger)limit;

@end
