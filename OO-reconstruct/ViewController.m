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
}

- (void)landscapeLogic{
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
