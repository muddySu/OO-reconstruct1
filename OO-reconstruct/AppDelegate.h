//
//  AppDelegate.h
//  OO-reconstruct
//
//  Created by su on 12/19/14.
//  Copyright (c) 2014 su. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong)NSMutableArray *bidMutableArray;
@property (nonatomic, strong)NSMutableArray *nameMutableArray;

//method
+(AppDelegate *)userInfo;
@end

