//
//  MarsMainViewController.h
//  FlashLight
//
//  Created by Mars on 13-4-2.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@class MarsMainView;

@interface MarsMainViewController : UIViewController<CLLocationManagerDelegate>
{
    SystemSoundID soundID;
    int currentValue;
}

@property (nonatomic) BOOL isLight;

/// marsView 界面类
@property (nonatomic, retain) MarsMainView *marsView;

@property (nonatomic, strong) CLLocationManager *locationManager;

/** 判断是否打开手电筒
 * @param update 为YES表示为打开，NO为关闭
 */
-(void)turnOnLight:(BOOL)update;

/** 判断是都关闭手电筒
 *@param update 为YES表示为关闭，NO为打开
 */
-(void)turnOffLight:(BOOL)update;


@end
