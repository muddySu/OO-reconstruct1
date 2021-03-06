//
//  TabBarController.m
//  
//
//  Created by su on 12/24/14.
//
//

#import "TabBarController.h"
@interface TabBarController()
{
}
@end
@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _filesView = [FliesViewController shareInstance];
    _chatView = [[ChatViewController alloc] init];
    _aboutView = [[AboutViewController alloc] init];
    
    _fileNav = [[UINavigationController alloc] initWithRootViewController:_filesView];
    _chatNav = [[UINavigationController alloc] initWithRootViewController:_chatView];
    _aboutNav = [[UINavigationController alloc] initWithRootViewController:_aboutView];
    
    self.viewControllers = [NSArray arrayWithObjects:_fileNav,_chatNav,_aboutNav, nil];
    
    UITabBarItem *fileitem = [[UITabBarItem alloc] initWithTitle:@"文档库" image:[UIImage imageNamed: @"file1"] tag:1];
    UITabBarItem *chatitem = [[UITabBarItem alloc] initWithTitle:@"聊天" image:[UIImage imageNamed: @"chat"] tag:2];
    UITabBarItem *aboutitem = [[UITabBarItem alloc] initWithTitle:@"关于" image:[UIImage imageNamed: @"info"] tag:3];
    
    _filesView.tabBarItem = fileitem;
    _chatView.tabBarItem = chatitem;
    _aboutView.tabBarItem = aboutitem;

    self.logView = [[loginView alloc] initWithFrame:CGRectMake(0, 0, Screen_WIDTH, Screen_HEIGHT)];
    [self.view addSubview:self.logView];
    
    //set delegate
    self.logView.delegate = self;
}


-(void) viewDidAppear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
    [self changeLogicAfterRotation];          //视图加载前对横竖屏逻辑判断并适配
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
    self.logView.frame = CGRectMake(0, 0, Screen_WIDTH, Screen_HEIGHT);
    //旋转事件会被根viewcontroller:tabbarController截获，此处显式调用该方法来让其响应旋转事件
    [_aboutView.aboutDetailView portraitLogic];
}

- (void)landscapeLogic{
    self.logView.frame = CGRectMake(0, 0, Screen_HEIGHT, Screen_WIDTH);
    [_aboutView.aboutDetailView landscapeLogic];
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

- (void)logViewShouldDelloc{
    self.logView = nil;             //memory release;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

