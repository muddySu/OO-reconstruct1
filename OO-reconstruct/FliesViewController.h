//
//  FliesViewController.h
//  OO-reconstruct
//
//  Created by su on 1/4/15.
//  Copyright (c) 2015 su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FliesViewController : UITableViewController

//instance method
+ (instancetype)shareInstance;
+ (void)releaseInstance;

//pass arraymethod
- (void)getArrayFromResponsedData:(NSMutableArray *)bidArray and:(NSMutableArray *)nameArray;
@end
