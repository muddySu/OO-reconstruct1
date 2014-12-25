//
//  ViewController.h
//  OO-reconstruct
//
//  Created by su on 12/19/14.
//  Copyright (c) 2014 su. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginView.h"
#import "FilesViewController.h"
#import "AboutViewController.h"
#import "ChatViewController.h"
@interface ViewController : UIViewController
{
}

@property (nonatomic, strong) loginView *logView;
@property (nonatomic, strong) UITabBarController *tabbarController;
@property (nonatomic, strong) UINavigationController *fileNav;
@property (nonatomic, strong) UINavigationController *chatNav;
@property (nonatomic, strong) UINavigationController *aboutNav;
@property (nonatomic, strong) FilesViewController *filesView;
@property (nonatomic, strong) AboutViewController *aboutView;
@property (nonatomic, strong) ChatViewController *chatView;
//横屏逻辑处理
- (void)landscapeLogic;

//竖屏逻辑处理
- (void)portraitLogic;

@end

