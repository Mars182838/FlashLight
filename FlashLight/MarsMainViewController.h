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
    /// 当前的数据
    int currentValue;
    
    /// 定时器
    NSTimer *timer;
    
    /// 是否正在闪烁
    BOOL isShineOn;
    
    /// 是否支持闪烁
    BOOL enableShine;
}

/// 是否打开手电筒
@property (nonatomic) BOOL isLight;

/// marsView 界面类
@property (nonatomic, strong) MarsMainView *marsView;

/// locationManager 系统定位
@property (nonatomic, strong) CLLocationManager *locationManager;

/** 判断是否打开手电筒
 * @param update 为YES表示为打开，NO为关闭
 */
-(void)turnOnLight:(BOOL)update;

@end
