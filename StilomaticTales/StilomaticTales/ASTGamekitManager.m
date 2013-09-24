//
//  ASTGamekitManager.m
//  StilomaticTales
//
//  Created by Antonio_Stilo on 9/24/13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import "ASTGamekitManager.h"

@implementation ASTGamekitManager
@synthesize currentViewController;

-(NSArray*)retriveBestScores
{
    __block NSArray *list = nil;
    [GKLeaderboard loadLeaderboardsWithCompletionHandler:^(NSArray *leaderboards, NSError *error) {
        list = leaderboards;
    }];
    return list;
}

-(void)submitScore:(NSInteger)score
{
    if (![self isGameCenterAvailable]) return;
    
    GKScore *gkScore = [[GKScore alloc] initWithLeaderboardIdentifier:@"Stilomatic Tales"];
    gkScore.value = score;
    [GKScore reportScores:@[gkScore] withCompletionHandler:nil];

}

-(void)login
{
    if (![self isGameCenterAvailable]) return;
    
    GKLocalPlayer *player = [GKLocalPlayer localPlayer];
    NSLog(@"** GAMEKIT_AUTH : %d",player.authenticated);
    if (player.authenticated == NO) {
        player.authenticateHandler = ^(UIViewController *viewController, NSError *error)
        {
            NSLog(@" * * GAMEKIT_AUTH e:%@",error.localizedDescription);
            if (error) {
                //[currentViewController presentViewController:viewController animated:YES completion:nil];
            }
        };
    } else {
        NSLog(@"Already authenticated!");
    }
}


- (BOOL)isGameCenterAvailable {
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    NSLog(@"GAMEKIT %d",(gcClass && osVersionSupported));
    
    return (gcClass && osVersionSupported);
}

+ (ASTGamekitManager *)sharedInstance
{
    static ASTGamekitManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ASTGamekitManager alloc] init];
    });
    return sharedInstance;
}

@end
