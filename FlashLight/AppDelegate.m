//
//  AppDelegate.m
//  FlashLight
//
//  Created by Mars on 13-4-2.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "AppDelegate.h"
#import "MarsMainViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_marsController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    _marsController = [[MarsMainViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = _marsController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

/** 程序进入后台时，关闭手电筒功能  */

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [_marsController turnOnLight:NO];
}

/** 程序进入后台时，关闭手电筒功能  */
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if (_marsController.isLight) {
        [_marsController turnOnLight:NO];
    }
}

/** 程序已启动时就打开手电筒功能 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [_marsController turnOnLight:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
