//
//  myCell.m
//  oo
//
//  Created by su on 14-5-21.
//  Copyright (c) 2014年 su. All rights reserved.
//

#import "myCell.h"

@implementation myCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _textlabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 270, 40)];
        _textlabel.font=[UIFont fontWithName:@"Arial" size:14.0];
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        [self.contentView addSubview:_textlabel];
        [self.contentView addSubview:_image];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
