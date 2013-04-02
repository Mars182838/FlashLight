//
//  MarsMainView.h
//  FlashLight
//
//  Created by Mars on 13-4-2.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarsMainView : UIView

/// 设备的宽度
#define WIDTH self.view.frame.size.width

/// 设备的高度
#define HEIGHT self.view.frame.size.height

@property (nonatomic, retain) UIImageView *compassImage;

@property (nonatomic, retain) UIImageView *backImage;

@property (nonatomic, retain) UIImageView *wightImage;

@property (nonatomic, retain) UIImageView *labelImage;

/// lightBtn 灯开关按钮
@property (nonatomic, retain) UIButton *lightBtn;

/// faderSlider 频率调节
@property (nonatomic, strong) UISlider *faderSlider;

@property (nonatomic, strong) UILabel *sliderLabel;


@end
