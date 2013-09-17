//
//  ASTViewController.m
//  StilomaticTales
//
//  Created by Antonio Stilo on 12.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTViewController.h"
#import "ASTGameScene.h"

@implementation ASTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"levels" ofType:@"plist"];
    NSArray *levels = [NSArray arrayWithContentsOfFile:plistPath];
    
    
    ASTGameScene *scene = [ASTGameScene sceneWithSize:skView.bounds.size];
    scene.levelProperties = [levels objectAtIndex:0];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
