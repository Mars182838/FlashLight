//
//  MarsMainView.h
//  FlashLight
//
//  Created by Mars on 13-4-2.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarsMainView : UIView

/// compassImage 整个指南针背景图
@property (nonatomic, retain) UIImageView *compassImage;

/// backImage 指南针的背景图片
@property (nonatomic, retain) UIImageView *backImage;

/// wightImage 指南针图片
@property (nonatomic, retain) UIImageView *wightImage;

/// labelImage 显示文字的图片
@property (nonatomic, retain) UIImageView *labelImage;

/// lightImage 灯关闪烁时的换色
@property (nonatomic, strong) UIImageView *lightImage;

/// lightBtn 灯开关按钮
@property (nonatomic, strong) UIButton *lightBtn;

/// switchBtn 闪烁开关按钮
@property (nonatomic, strong) UIButton *switchBtn;

/// editerBtn 设置按钮
@property (nonatomic, strong) UIButton *editerBtn;

/// faderSlider 频率调节
@property (nonatomic, strong) UISlider *faderSlider;

/// 显示频率的Label
@property (nonatomic, strong) UILabel *sliderLabel;

@end
