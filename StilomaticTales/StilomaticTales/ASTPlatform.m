//
//  ASTPlatform.m
//  StilomaticTales
//
//  Created by Antonio_Stilo on 10/6/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTPlatform.h"

#define kWSectors 31
#define kHSectors 47

@implementation ASTPlatform
@synthesize levelMap;

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        SKNode *map = [[SKNode alloc] init];
        map.position = CGPointMake(0.0, 0.0);
        map.xScale = map.yScale = 1.0;
        levelMap = [UIImage imageNamed:@"level_0.png"];
        for (int x = kWSectors; x > 0 ; x--) {
            for (int y = kHSectors; y > 0 ; y--) {
                CGPoint loc = CGPointMake(x, y);
                SKSpriteNode *tmp = [self colorAtPosition:loc andLevel:levelMap];
                if (tmp) {
                    [map addChild:tmp];
                }
            }
        }
        [self addChild:map];
    }
    
    self.physicsWorld.gravity = CGVectorMake(0.0, 1.0);
    self.physicsWorld.speed = 6.0;
    self.physicsWorld.contactDelegate = self;
    
    
    return self;
}


-(SKSpriteNode*)colorAtPosition:(CGPoint)position andLevel:(UIImage*)map
{

    CGRect sourceRect = CGRectMake(position.x, position.y, 1.f, 1.f);
    CGImageRef imageRef = CGImageCreateWithImageInRect(map.CGImage, sourceRect);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *buffer = malloc(4);
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
    CGContextRef context = CGBitmapContextCreate(buffer, 1, 1, 8, 4, colorSpace, bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0.f, 0.f, 1.f, 1.f), imageRef);
    CGImageRelease(imageRef);
    CGContextRelease(context);
    
    CGFloat r = buffer[0] / 255.f;
    CGFloat g = buffer[1] / 255.f;
    CGFloat b = buffer[2] / 255.f;
    //CGFloat a = buffer[3] / 255.f;
    
    free(buffer);
    
    CGPoint loc = CGPointMake((position.x*40),(kHSectors*40)-(position.y*40));
    SKSpriteNode *tmp;
    if (r == 1 && g == 1)
    {
        tmp = [[SKSpriteNode alloc] initWithImageNamed:@"player-level0.png"];
        tmp.position = loc;
        return tmp;
    }else if (g == 1){
        tmp = [[SKSpriteNode alloc] initWithImageNamed:@"ground-level0.png"];
        tmp.position = loc;
        return tmp;
    }else if (b == 1){
        tmp = [[SKSpriteNode alloc] initWithImageNamed:@"door.png"];
        tmp.position = loc;
        return tmp;
    }else if (r == 1){
        tmp = [[SKSpriteNode alloc] initWithImageNamed:@"villan_level0.png"];
        tmp.position = loc;
        return tmp;
    }
    
    return nil;

}

- (void)didBeginContact:(SKPhysicsContact *)contact
{



}

@end
