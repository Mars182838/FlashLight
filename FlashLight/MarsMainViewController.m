//
//  MarsMainViewController.m
//  FlashLight
//
//  Created by Mars on 13-4-2.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "MarsMainViewController.h"
#import "MarsEditerViewController.h"
#import "MarsMainView.h"
#import "Config.h"

@interface MarsMainViewController ()

@end

@implementation MarsMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        _isLight = YES;
        
    }
    return self;
}

-(void)dealloc
{
    [_locationManager release];
    [_marsView        release];
    [super dealloc];
}

#pragma mark - LifeCycle

/** 打开应用时开启自动定位 
 */
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(startLocationHeadingEvents)];
}

/** 应用退出时停止定位 
 */
-(void)viewWillDisappear:(BOOL)animated
{
    if (self.locationManager) {
        
        [_locationManager stopUpdatingLocation];///> 停止定位
        [_locationManager stopUpdatingHeading];///> 停止更新
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sf_bg.png"]];
    
    currentValue = MIN_FREQ;///> 设定滑竿的最小值
    
    _marsView = [[MarsMainView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    [_marsView.lightBtn addTarget:self action:@selector(lightOnOff:) forControlEvents:UIControlEventTouchUpInside];
    
    [_marsView.faderSlider addTarget:self action:@selector(faderSlider:) forControlEvents:UIControlEventValueChanged];
    
    [_marsView.faderSlider addTarget:self action:@selector(faderProgress:) forControlEvents:UIControlEventTouchUpInside];
    
    [_marsView.switchBtn addTarget:self action:@selector(switchBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [_marsView.editerBtn addTarget:self action:@selector(editerBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    
    _marsView.faderSlider.value = currentValue*10/(MAX_FREQ - MIN_FREQ);
    _marsView.sliderLabel.text = [NSString stringWithFormat:@"%d HZ",(int)_marsView.faderSlider.value + 1];
    
    [self.view addSubview:_marsView];
        
    /// 程序开启时打开手电筒的声音
    [self playServicesAudioWithResource:SOUND_ON];

}

#pragma mark - UISlider Methods

/** 滑动滚轮的时候，根据滑动的多少改变数据的显示 
 *  sender 
 */
-(void)faderSlider:(UISlider *)sender
{
    int percent = (int)(sender.value*100);
    currentValue = MIN_FREQ + (MAX_FREQ - MIN_FREQ)*percent/100;
    _marsView.sliderLabel.text = [NSString stringWithFormat:@"%d HZ",currentValue];
}

/** 时间发射器，如果enableShine 为YES时，开启时间发射器，
 * 否则为NO时，关闭时间发射器。
 */
-(void)faderProgress:(id)sender
{
    double time = 1.0/currentValue;
    
    if (enableShine) {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(timeShine) userInfo:nil repeats:YES];/// 定时器，根据当前的频率发送灯光的闪烁时间
    }
    else{
        
        [timer invalidate];/// 取消定时器
        timer = nil;
    }
}

/** 闪烁的频率,当为偶数时灯光闪烁，为奇数时不闪烁 
 */
-(void) timeShine
{
    static int count = 0;
    
    /// 如果灯光已经打开
    if (enableShine) {
        
        if (count % 2) {
            
            [self turnOnLight:NO];/// 偶数时灯光闪烁打开
            
        }else{
            
            [self turnOnLight:YES];/// 奇数时灯光闪烁关闭
        }
        
        count ++;/// 每次自加1
    }
    
}

#pragma mark - 
#pragma mark - UIButton Methods

/** 设备的闪关灯打开 */
-(void)turnOnLight:(BOOL)update
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        
        [device lockForConfiguration:nil];
        
        if (update)
        {
            _marsView.lightImage.image = [UIImage imageNamed:@"sf_button_light_strobe"];
            [_marsView.lightBtn setImage:[UIImage imageNamed:@"sf_button_normal"] forState:UIControlStateNormal];
            [device setTorchMode: AVCaptureTorchModeOn];
            [device unlockForConfiguration];
        }
        else{
            _marsView.lightImage.image = [UIImage imageNamed:@""];
            [_marsView.lightBtn setImage:[UIImage imageNamed:@"sf_button_tapped"] forState:UIControlStateNormal];
            [device setTorchMode: AVCaptureTorchModeOff];
            [device unlockForConfiguration];
        }

    }
}

/** 闪关灯开关按钮 */
-(void)lightOnOff:(id)sender
{
    _isLight = 1 - _isLight;
    if (_isLight) {
        
        [self turnOnLight:YES];
        [self playServicesAudioWithResource:SOUND_ON];
    }
    else{
        
        [self turnOnLight:NO];
        [self playServicesAudioWithResource:SOUND_OFF];
    }
}

/** 该函数的方法功能是控制灯能否闪烁
 *  enableShine 为YES代表灯光支持闪烁
 *  为NO代表不支持闪烁
 */
-(void)switchBtnPress:(id)sender
{
    enableShine = 1 - enableShine;
    
    if (!enableShine)
    {
        _isLight = YES;
        [self turnOnLight:NO];
        [self playServicesAudioWithResource:SOUND_OFF];
        [_marsView.switchBtn setImage:[UIImage imageNamed:@"22.png"] forState:UIControlStateNormal];
        
    }else{
        // 灯光闪烁
        isShineOn = NO;
        
        _isLight = YES;
        [self turnOnLight:YES];
        [self playServicesAudioWithResource:SOUND_Shutter];
        [_marsView.switchBtn setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
    }
    [self turnOnLight:YES];
    [self faderProgress:nil];
    
}

-(void)editerBtnPress:(id)sender
{
    MarsEditerViewController *editerController = [[MarsEditerViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:editerController animated:YES completion:nil];
}

#pragma mark - Audio Methods

-(void)playServicesAudioWithResource:(NSString *)resource
{
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL URLWithString:path], &soundID);
    
    AudioServicesPlaySystemSound(soundID);///> 播放铃声

}

/// 开启定位的方法

-(void)startLocationHeadingEvents
{
    if (!self.locationManager) {
        
        CLLocationManager *manager = [[[CLLocationManager alloc] init] autorelease];
        manager.delegate = self;
        self.locationManager = manager;
    }
    
    [_locationManager startUpdatingLocation];

    if([CLLocationManager headingAvailable])
    {
        _locationManager.headingFilter = kCLHeadingFilterNone;///> 设置滤波器不工作
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;///> 设置精度为最佳

        [_locationManager startUpdatingHeading];///> 开始更新
    }
}

#pragma mark - 
#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    /// 每次都要重置view的位置，才能保证图片的偏转量正常
    _marsView.compassImage.transform = CGAffineTransformIdentity;
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI*newHeading.magneticHeading/180.0);
    _marsView.compassImage.transform = transform;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
