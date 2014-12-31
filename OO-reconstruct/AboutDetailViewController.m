//
//  AboutDetailViewController.m
//  OO-reconstruct
//
//  Created by su on 12/31/14.
//  Copyright (c) 2014 su. All rights reserved.
//

#import "AboutDetailViewController.h"

@interface AboutDetailViewController ()
{
    UILabel *questionlabel;
    UILabel *infolabel;
}
@end

@implementation AboutDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    infolabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSString *laberString = @"Version 1.0\n\n欧欧云办公系统\n\n13858080701\n\n362890952@qq.com\n\n杭州九慧科技有限公司";
    infolabel.numberOfLines = 0;
    infolabel.text = laberString;
    infolabel.frame = CGRectMake(0, 0, Screen_WIDTH, 350);
    infolabel.textAlignment = NSTextAlignmentCenter;
    infolabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    questionlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSString *questionString = @"关于网络连接\n  1.检查数据是否打开\n  2.检查是否连接到了其他的wifi热点\n  3.检查是否有vpdn设置\n\n关于软件使用\n  1.检查软件是否最新版本\n  2.检查手机工作是否正常";
    questionlabel.numberOfLines = 0;
    questionlabel.text = questionString;
    questionlabel.frame = CGRectMake(0, 0, Screen_WIDTH, 320);
    questionlabel.textAlignment = NSTextAlignmentLeft;
    questionlabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)viewWillAppear:(BOOL)animated{
    [self changeLogicAfterRotation];
}

-(void)changeLogicAfterRotation
{
    if (orientation_Flag == 1)
    {//竖屏
        [self portraitLogic];
    }
    else if(orientation_Flag == 0)
    {//横屏
        [self landscapeLogic];
    }
}

- (void)portraitLogic{
    infolabel.frame = CGRectMake(0, 0, PORT_WIDTH, 350);
    questionlabel.frame = CGRectMake(0, 0, PORT_WIDTH, 320);
}

- (void)landscapeLogic{
    infolabel.frame = CGRectMake(0, 0, LAND_WIDTH, 350);
    questionlabel.frame = CGRectMake(0, 0, LAND_WIDTH, 320);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        [self landscapeLogic];
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        [self portraitLogic];
    }
}


-(void)shouLoadWhichView:(int)num with:(NSString *)titleString
{
    if (num == 1) {
        [self loadThequestionView:titleString];
    }else if (num == 2)
    {
        [self loadTheinfoView:titleString];
    }
}

-(void)loadThequestionView:(NSString *)titleString
{
    [infolabel removeFromSuperview];
    [self.navigationItem setTitle:titleString];
    [self.view addSubview:questionlabel];
}

-(void)loadTheinfoView:(NSString *)titleString
{
    [questionlabel removeFromSuperview];
    [self.navigationItem setTitle:titleString];
    [self.view addSubview:infolabel];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    infolabel = nil;
    questionlabel = nil;
    self.view = nil;
}



@end
