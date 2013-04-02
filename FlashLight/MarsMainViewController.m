//
//  MarsMainViewController.m
//  FlashLight
//
//  Created by Mars on 13-4-2.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "MarsMainViewController.h"
#import "MarsMainView.h"

#define SOUND_OFF @"shutter_up"
#define SOUND_ON  @"sound_on"

#define MIN_FREQ   1
#define MAX_FREQ   20

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sf_bg.png"]];
    
    currentValue = MIN_FREQ;
    
    _marsView = [[MarsMainView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [_marsView.lightBtn addTarget:self action:@selector(lightOnOff:) forControlEvents:UIControlEventTouchUpInside];
    
    [_marsView.faderSlider addTarget:self action:@selector(faderSlider:) forControlEvents:UIControlEventValueChanged];
    _marsView.faderSlider.value = currentValue*1.0/(MAX_FREQ - MIN_FREQ);
    
    [self.view addSubview:_marsView];
        
    /// 程序开启时打开手电筒的声音
    [self playServicesAudioWithResource:SOUND_ON];

}

-(void)faderSlider:(UISlider *)sender
{
    _marsView.sliderLabel.text = [NSString stringWithFormat:@"%dHZ",(int)[_marsView.faderSlider value]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(startLocationHeadingEvents)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (self.locationManager) {
        
        [_locationManager stopUpdatingLocation];///> 停止定位
        [_locationManager stopUpdatingHeading];///> 停止更新
    }
}

#pragma mark - 
#pragma mark - UIButton Methods

-(void)turnOnLight:(BOOL)update
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    }
    if (update)
    {
        [_marsView.lightBtn setImage:[UIImage imageNamed:@"sf_button_normal"] forState:UIControlStateNormal];
    }
}

-(void)turnOffLight:(BOOL)update
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
    if (update)
    {
        [_marsView.lightBtn setImage:[UIImage imageNamed:@"sf_button_tapped.png"] forState:UIControlStateNormal];
    }
}

-(void)lightOnOff:(id)sender
{
    _isLight = 1 - _isLight;
    if (_isLight) {
        [self playServicesAudioWithResource:SOUND_ON];
        [self turnOnLight:YES];
    }
    else{
        [self playServicesAudioWithResource:SOUND_OFF];
        [self turnOffLight:YES];
    }
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
