//
//  MarsEditerViewController.m
//  FlashLight
//
//  Created by Mars on 13-4-3.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "MarsEditerViewController.h"
#import "Config.h"

@interface MarsEditerViewController ()

@end

@implementation MarsEditerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.editerArray = [[NSMutableArray alloc] initWithObjects:@"关于我们",@"友情分享",@"电邮反馈",@"给我个评价", nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sf_bg"]];
    
    _editerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _editerTableView.delegate = self;
    _editerTableView.dataSource = self;
    _editerTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sf_bg"]];
    [self.view addSubview:_editerTableView];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(20, 5, 30, 30);
    [_backButton setImage:[UIImage imageNamed:@"BtnClose.png"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.editerArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"cellIndentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifer] autorelease];
    }
    
     cell.textLabel.text = [self.editerArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)backPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
