//
//  ASTHomeViewController.m
//  StilomaticTales
//
//  Created by Antonio_Stilo on 9/22/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTHomeViewController.h"
#import "ASTGameManager.h"
#import "ASTGamekitManager.h"

@interface ASTHomeViewController ()

@end

@implementation ASTHomeViewController

-(IBAction)leve0Handler
{
    [[ASTGameManager sharedInstance] setLevel:1];
    [self performSegueWithIdentifier:@"gameSegue" sender:nil];
}

-(IBAction)leve1Handler
{
    [[ASTGameManager sharedInstance] setLevel:2];
    [self performSegueWithIdentifier:@"gameSegue" sender:nil];
}

-(IBAction)leve2Handler
{
    [[ASTGameManager sharedInstance] setLevel:3];
    [self performSegueWithIdentifier:@"gameSegue" sender:nil];
}

-(IBAction)leve3Handler
{
    [[ASTGameManager sharedInstance] setLevel:4];
    [self performSegueWithIdentifier:@"gameSegue" sender:nil];
}

-(IBAction)leve4Handler
{
    [[ASTGameManager sharedInstance] setLevel:5];
    [self performSegueWithIdentifier:@"gameSegue" sender:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ASTGamekitManager *gkm = [ASTGamekitManager sharedInstance];
    gkm.currentViewController = self;
    [gkm login];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
