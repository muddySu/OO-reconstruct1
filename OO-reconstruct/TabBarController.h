//
//  TabBarController.h
//  
//
//  Created by su on 12/24/14.
//
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "loginView.h"
#import "FilesViewController.h"
#import "AboutViewController.h"
#import "ChatViewController.h"
@interface TabBarController : UITabBarController
{
}

@property (nonatomic, strong) loginView *logView;
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

