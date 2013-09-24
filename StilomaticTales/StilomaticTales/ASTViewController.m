//
//  ASTViewController.m
//  StilomaticTales
//
//  Created by Antonio Stilo on 12.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTViewController.h"
#import "ASTGameManager.h"
#import "ASTGameScene.h"
#import "ASTHomeScene.h"

@implementation ASTViewController

-(void)viewWillAppear:(BOOL)animate
{
    [super viewWillAppear:animate];
    
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    ASTGameManager *gm = [ASTGameManager sharedInstance];
    [gm newLevel];
    [gm setCurrentViewController:self];
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"levels" ofType:@"plist"];
    NSArray *levels = [NSArray arrayWithContentsOfFile:plistPath];
    
    
    ASTGameScene *scene = [[ASTGameScene alloc] initWithSize:skView.bounds.size andProperties:[levels objectAtIndex:gm.level]];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
