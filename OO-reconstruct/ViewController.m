//
//  ViewController.m
//  OO-reconstruct
//
//  Created by su on 12/19/14.
//  Copyright (c) 2014 su. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tabbarController = [[UITabBarController alloc] init];
    _filesView = [[FilesViewController alloc] init];
    _chatView = [[ChatViewController alloc] init];
    _aboutView = [[AboutViewController alloc] init];
    
    _fileNav = [[UINavigationController alloc] initWithRootViewController:_filesView];
    _chatNav = [[UINavigationController alloc] initWithRootViewController:_chatView];
    _aboutNav = [[UINavigationController alloc] initWithRootViewController:_aboutView];
    
    _tabbarController.viewControllers = [NSArray arrayWithObjects:_fileNav,_chatNav,_aboutNav, nil];
    
    UITabBarItem *fileitem = [[UITabBarItem alloc] initWithTitle:@"文档库" image:[UIImage imageNamed: @"file1"] tag:1];
    UITabBarItem *chatitem = [[UITabBarItem alloc] initWithTitle:@"聊天" image:[UIImage imageNamed: @"chat"] tag:2];
    UITabBarItem *aboutitem = [[UITabBarItem alloc] initWithTitle:@"关于" image:[UIImage imageNamed: @"info"] tag:3];
    
    _filesView.tabBarItem = fileitem;
    _chatView.tabBarItem = chatitem;
    _aboutView.tabBarItem = aboutitem;
    // Do any additional setup after loading the view, typically from a nib.
    self.logView = [[loginView alloc] initWithFrame:CGRectMake(0, 0, Screen_WIDTH, Screen_HEIGHT)];
    //[self.view addSubview:self.logView];
    
    [_tabbarController.view addSubview:self.logView];
}

- (void)viewDidAppear:(BOOL)animated{
    [self presentViewController:_tabbarController animated:NO completion:^{
        //[weakSelf.tabBarController.view bringSubviewToFront:weakSelf.logView];
    }];
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
    self.logView.frame = CGRectMake(0, 0, Screen_WIDTH, Screen_HEIGHT-44);
}

- (void)landscapeLogic{
    self.logView.frame = CGRectMake(0, 0, Screen_HEIGHT, Screen_WIDTH-44);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        [self landscapeLogic];
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        [self portraitLogic];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.logView endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
