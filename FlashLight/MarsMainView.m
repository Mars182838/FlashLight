//
//  MarsMainView.m
//  FlashLight
//
//  Created by Mars on 13-4-2.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "MarsMainView.h"

@implementation MarsMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        /// 滑轮图片
        _labelImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        _labelImage.image = [UIImage imageNamed:@"sf_strobe_controller_bg.png"];
        [self addSubview:_labelImage];
        
        /// 滑杆 
        _faderSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 10, 280, 10)];
        _faderSlider.backgroundColor = [UIColor clearColor];
        UIImage *stechTrack = [[UIImage imageNamed:@"faderTrack.png"] stretchableImageWithLeftCapWidth:10.0f topCapHeight:0.0];
        [_faderSlider setThumbImage:[UIImage imageNamed:@"faderKey.png"] forState:UIControlStateNormal];
        [_faderSlider setMinimumTrackImage:stechTrack forState:UIControlStateNormal];
        [_faderSlider setMaximumTrackImage:stechTrack forState:UIControlStateNormal];
        [self addSubview:_faderSlider];
        
        /// 显示的文字
        _sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, 260, 30)];
        _sliderLabel.backgroundColor = [UIColor clearColor];
        _sliderLabel.textColor = [UIColor blueColor];
        _sliderLabel.textAlignment = NSTextAlignmentCenter;
        _sliderLabel.font = [UIFont fontWithName:@"DBLCDTempBlack" size:20.0f];
        [self addSubview:_sliderLabel];
        
        /// 指南针的选择图片
        _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(115, 100, 90, 90)];
        _backImage.image = [UIImage imageNamed:@"sf_compass_bg.png"];
        [self addSubview:_backImage];
        
        /// 指南针图片和背景色
        _wightImage = [[UIImageView alloc] initWithFrame:CGRectMake(130, 115, 60, 60)];
        _wightImage.image = [UIImage imageNamed:@"sf_compass_glass_cover.png"];
        
        _compassImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        _compassImage.image = [UIImage imageNamed:@"sf_compass_rotating_object.png"];
        [_wightImage addSubview:_compassImage];
        
        [self addSubview:_wightImage];
        
        /// 手电筒开关按钮
        _lightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lightBtn.frame = CGRectMake(70, 200, 195, 215);
        [_lightBtn setImage:[UIImage imageNamed:@"sf_button_normal.png"] forState:UIControlStateNormal];
        [self addSubview:_lightBtn];
        
        /// 灯光渐变的背景图片
        _lightImage = [[UIImageView alloc] initWithFrame:CGRectMake(70, 280, 193, 99)];
        [self addSubview:_lightImage];
        
        /// 控制是否打开闪关灯的Button
        _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchBtn.frame = CGRectMake(30, self.frame.size.height - 80, 60, 60);
        [_switchBtn setImage:[UIImage imageNamed:@"clock.png"] forState:UIControlStateNormal];
        [self addSubview:_switchBtn];
        
        _editerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editerBtn.frame = CGRectMake(230, self.frame.size.height - 80, 60, 60);
        [_editerBtn setImage:[UIImage imageNamed:@"set.png"] forState:UIControlStateNormal];
        [self addSubview:_editerBtn];
        
    }
    return self;
}

-(void)dealloc
{
    [_backImage    release];
    [_wightImage   release];
    [_compassImage release];
    [_labelImage   release];
    [_switchBtn    release];
    [_lightBtn     release];
    [_sliderLabel  release];
    [_faderSlider  release];
    [_lightImage   release];
    
    [super dealloc];
    
}

@end
