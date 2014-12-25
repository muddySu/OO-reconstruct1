//
//  FilesViewController.h
//  OO-reconstruct
//
//  Created by su on 12/25/14.
//  Copyright (c) 2014 su. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PassDataToFileDelegate <NSObject>
- (void)loginHasData:(NSArray *)bidArray and:(NSArray *)nameArray;
@end
@interface FilesViewController : UITableViewController

@property (nonatomic, assign)id<PassDataToFileDelegate> delegate;

@end
