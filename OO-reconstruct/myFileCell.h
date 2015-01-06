//
//  myFileCell.h
//  OO-reconstruct
//
//  Created by su on 1/6/15.
//  Copyright (c) 2015 su. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIProgressView+AFNetworking.h"
@interface myFileCell : UITableViewCell
@property (nonatomic, strong)UIImageView *fileIcon;
@property (nonatomic, strong)UILabel *fileName;
@property (nonatomic, strong)UIProgressView *progressView;
@property (nonatomic, strong)UIButton *actionButton;
@property (nonatomic, strong)UIButton *deleteButton; 
@end
