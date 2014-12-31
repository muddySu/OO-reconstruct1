//
//  ViewController.h
//  OO-reconstruct
//
//  Created by su on 12/19/14.
//  Copyright (c) 2014 su. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 @des:viewController作为所有controller的基类，不要直接实例化它，应该继承它
 */
@interface ViewController : UIViewController
{
}

//横屏逻辑处理
- (void)landscapeLogic;

//竖屏逻辑处理
- (void)portraitLogic;

@end

