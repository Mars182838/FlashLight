//
//  MarsEditerViewController.h
//  FlashLight
//
//  Created by Mars on 13-4-3.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarsEditerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *editerTableView;

@property (nonatomic, copy) NSMutableArray *editerArray;

@property (nonatomic, strong) UIButton *backButton;

@end
