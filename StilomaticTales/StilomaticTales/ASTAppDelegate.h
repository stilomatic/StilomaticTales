//
//  ASTAppDelegate.h
//  StilomaticTales
//
//  Created by Antonio Stilo on 12.09.13.
//  Copyright (c) 2013 Stilo-studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASTGameManager.h"

@interface ASTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) ASTGameManager *gm;

@end
