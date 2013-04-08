//
//  AppDelegate.h
//  FlashLight
//
//  Created by Mars on 13-4-2.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarsPainWindow.h"

@class MarsMainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) MarsPainWindow *window;

@property (nonatomic, retain) MarsMainViewController *marsController;


@end
