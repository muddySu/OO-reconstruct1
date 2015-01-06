//
//  myFileCell.m
//  OO-reconstruct
//
//  Created by su on 1/6/15.
//  Copyright (c) 2015 su. All rights reserved.
//

#import "myFileCell.h"

@implementation myFileCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _fileIcon = [[UIImageView alloc] init];
        _fileName = [[UILabel alloc] init];
        _progressView = [[UIProgressView alloc] init];
        _actionButton = [[UIButton alloc] init];
        _deleteButton = [[UIButton alloc] init];
        
        [self.contentView addSubview:_fileIcon];
        [self.contentView addSubview:_fileName];
        [self.contentView addSubview:_progressView];
        [self.contentView addSubview:_actionButton];
        [self.contentView addSubview:_deleteButton];
        
        _fileName.font = [UIFont fontWithName:@"Arial" size:14.0];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _actionButton.backgroundColor = [UIColor greenColor];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:10.0];
        _deleteButton.backgroundColor = [UIColor redColor];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        
        WS(weakSelf);
        [_fileIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).with.offset(5);
            make.left.equalTo(weakSelf.contentView).with.offset(5);
            make.height.mas_equalTo(@30);
            make.width.mas_equalTo(@30);
        }];
        [_fileName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).with.offset(5);
            make.left.equalTo(weakSelf.fileIcon.right).with.offset(5);
            make.height.mas_equalTo(@30);
            make.width.mas_equalTo(@100);
        }];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).with.offset(5);
            make.right.equalTo(weakSelf.contentView).with.offset(-5);
            make.height.mas_equalTo(@30);
            make.width.mas_equalTo(@30);
        }];
        [_actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).with.offset(5);
            make.right.equalTo(weakSelf.deleteButton.left).with.offset(-5);
            make.height.mas_equalTo(@30);
            make.width.mas_equalTo(@30);
        }];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).with.offset(20);
            make.right.equalTo(weakSelf.actionButton.left).with.offset(-10);
            //make.height.mas_equalTo(@30);
            make.width.mas_equalTo(@100);
        }];
        
    }
    return self;
}

//#pragma mark - button action
//-(IBAction)button:(id)sender{
//    UIButton* button = (UIButton*)sender;
//    UITableViewCell* buttonCell = (UITableViewCell*)[sender superview];
//    
//    //NSUInteger row = [[UITableView indexPathForCell:buttonCell]row];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
