//
//  MarsEditerViewController.h
//  FlashLight
//
//  Created by Mars on 13-4-3.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPopoverListView.h"
#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>

@interface MarsEditerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverListViewDataSource,UIPopoverListViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *editerTableView;

@property (nonatomic, copy) NSMutableArray *editerArray;

@property (nonatomic, copy) NSArray *messageArray;

/// backButton 返回按钮
@property (nonatomic, strong) UIButton *backButton;

/// 摇晃开关
@property (nonatomic, strong) UISwitch *shakeSwitch;

/// 标题栏的文字
@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UIView *messageView;

@end
