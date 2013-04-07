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
        self.messageArray = [[NSArray alloc] initWithObjects:@"朋友圈",@"好友圈",@"短信",@"邮箱", nil];
    }
    return self;
}

-(void)dealloc
{
    [_titleLable      release];
    [_editerArray     release];
    [_messageArray    release];
    [_editerTableView release];
    [super dealloc];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.editerTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sf_bg"]];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 260, 40)];
    _titleLable.font = [UIFont systemFontOfSize:22.0f];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.backgroundColor = [UIColor clearColor];
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.text = @"设置";
    [self.view addSubview:_titleLable];
    
    _editerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _editerTableView.delegate = self;
    _editerTableView.dataSource = self;
    [self.view addSubview:_editerTableView];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(20, 5, 30, 30);
    [_backButton setImage:[UIImage imageNamed:@"BtnClose.png"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
}

#pragma mark - UITableView Delegate and DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    }
    else{
        
        return self.editerArray.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    NSString *headString = nil;
    if (section == 0) {
        
        headString = @"FlashLight";
        return headString;
    }
    else{
        
        headString = @"关于";
        return headString;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"cellIndentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifer] autorelease];
    }
    if (indexPath.section == 0) {
        
        _shakeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        _shakeSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"setting"];
        cell.accessoryView = _shakeSwitch;
        [_shakeSwitch addTarget:self action:@selector(switchBtn:) forControlEvents:UIControlEventValueChanged];
        cell.textLabel.text = [NSString stringWithFormat:@"开启摇动"];
        
    }else{
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
        label.font = [UIFont systemFontOfSize:18.0f];
        label.text = [self.editerArray objectAtIndex:indexPath.row];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label];
        [label release];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        [self changeViewWithAnimation];
        
    }
    else if (indexPath.row == 1)
    {
        CGFloat yHeight = 272.0f;
        CGFloat yoffset = (HEIGHT - 262)/2;
        UIPopoverListView *listView = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yoffset, 300, yHeight)];
        listView.delegate = self;
        listView.datasource = self;
        listView.listView.scrollEnabled =FALSE;
        [listView setTitle:@"分享到"];
        [listView  show];
        [listView release];
        
    }
    else if (indexPath.row == 2)
    {
        Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
        
        if (!mailClass) {
            
            [self alertViewMessage:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"];
        }
        
        if (![mailClass canSendMail]) {
            
            [self alertViewMessage:@"用户没有设置邮件账户"];
            return;
        }
        
        [self displayMailPickerWithSubject:@"发送反馈意见" andObject:@"wj182838@gmail.com" andMessage:@""];
    }
}

#pragma mark UIPopoverListView DataSource

-(UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"cellIndentifer";
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer] autorelease];
    UIImageView *snsImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
    snsImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_1%d",(indexPath.row + 1)]];
    [cell.contentView addSubview:snsImage];
    [snsImage release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 200, 50)];
    label.font = [UIFont fontWithName:@"Arail" size:25.0f];
    label.text = [self.messageArray objectAtIndex:indexPath.row];
    [cell.contentView addSubview:label];
    [label release];
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

#pragma mark - UIPopoverListViewDelegate

- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            break;
        }
        case 1:
        {
            
            break;
        }
        case 2:
        {
            Class messageClass = ((NSClassFromString(@"MFMessageComposeViewController")));
            if (messageClass != nil) {
                
                if ([messageClass canSendText]) {
                    
                    [self displaySMSComoserPicker];
                }
                else{
                    
                    [self alertViewMessage:@"设备没有短信功能"];
                }
            }
            else
            {
                [self alertViewMessage:@"iOS版本过低,iOS4.0以上才支持程序内发送短信"];
            }
            
            break;
        }
        case 3:
        {
            Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
            
            if (!mailClass) {
            
                [self alertViewMessage:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"];
            }
            
            if (![mailClass canSendMail]) {
                
                [self alertViewMessage:@"用户没有设置邮件账户"];
                return;
            }
            
            [self displayMailPickerWithSubject:@"分享是一种态度" andObject:@"wj182838@sina.cn" andMessage:@"这是个非常实用的软件，改软件既可以当做指南针，还可以当做手电筒"];
            break;
        }
        
    }
}

-(void)alertViewMessage:(NSString *)message
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}

#pragma mark - MFMessage Methods

-(void)displaySMSComoserPicker
{
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    
    messageController.body = [NSString stringWithFormat:@"这个应用非常好用，既能当手电筒用，还可以充当闪光灯，还能指定方向"];
    [self presentViewController:messageController animated:YES completion:nil];
    
    [messageController release];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSString *msg = nil;
    switch (result) {
        case MessageComposeResultCancelled:
        {
            msg = @"取消发送短信";
            break;
        }
            case MessageComposeResultSent:
        {
            msg = @"发送消息成功";
            break;
        
        }
        case MessageComposeResultFailed:
        {
            msg = @"发送短信失败";
        }
            
        [self alertViewMessage:msg];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MFMailMessage Methods

-(void)displayMailPickerWithSubject:(NSString *)subject andObject:(NSString *)object andMessage:(NSString *)message
{
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    mailController.mailComposeDelegate = self;
    
    [mailController setSubject:subject];
    /// 添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject:object];
    [mailController setToRecipients:toRecipients];
    
//    /// 添加抄送人
//    NSArray *ccRecipients = [NSArray arrayWithObjects:@"wj182838@sina.cn",@"wj182838@gmail.com", nil];
//    [mailController setCcRecipients:ccRecipients];
    
    /// 发送正文
    NSString *emailBody =[NSString stringWithFormat:@"%@",message];
    [mailController setMessageBody:emailBody isHTML:YES];
    [self presentViewController:mailController animated:YES completion:nil];
    [mailController release];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *msg = nil;
    switch (result) {
        case MFMailComposeResultCancelled:
        {
            msg = @"用户取消编辑邮件";

            break;
        }
        case MFMailComposeResultSaved:
        {
            msg = @"用户成功保存邮件";

            break;
        }
        case MFMailComposeResultSent:
        {
            msg = @"用户点击发送，将邮件放到队列中，还没发送";

            break;
            
        }
        case MFMailComposeResultFailed:
        {
            msg = @"用户试图保存或者发送邮件失败";
            break;
        }
            
        [self alertViewMessage:msg];
    }
}

-(void)backPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)switchBtn:(UISwitch *)sender
{
    UISwitch *switchBtn = sender;
    BOOL setting = switchBtn.on;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (setting) {
        
       [userDefaults setBool:YES forKey:@"setting"];
        
    }
    else{
        
        [userDefaults setBool:NO forKey:@"setting"];
    }
    
    [userDefaults synchronize]; ///> 强制写入磁盘    
}

-(void)changeViewWithAnimation
{
    _messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-40)];
    _messageView.backgroundColor = [UIColor blackColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, 260)];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.text = @"  该应用是一款集成手电筒、闪关灯、滑动开关电灯、指南针等功能于一身，有什么建议和改进的地方请大家发送反馈到我的邮箱， 谢谢大家，你们的建议和反馈是我的最大动力！邮箱为：wj182838@gmail.com";
    label.textColor = [UIColor whiteColor];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    [_messageView addSubview:label];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    [_messageView.layer addAnimation:animation forKey:@"animation"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [_messageView addGestureRecognizer:tap];
    
    [self.view addSubview:_messageView];

}

-(void)tapGesture:(id)sender
{
    [_messageView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
