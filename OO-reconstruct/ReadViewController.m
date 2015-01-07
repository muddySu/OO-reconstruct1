//
//  ReadViewController.m
//  OO-reconstruct
//
//  Created by su on 1/6/15.
//  Copyright (c) 2015 su. All rights reserved.
//

#import "ReadViewController.h"

@interface ReadViewController ()

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    WS(weakSelf);
//    _fileWebView = [[UIWebView alloc] init];
//    [self.view addSubview:_fileWebView];
//    [_fileWebView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.view).with.offset(0);
//        make.bottom.equalTo(weakSelf.view.bottom).with.offset(0);
//        make.left.equalTo(weakSelf.view.left).with.offset(0);
//        make.right.equalTo(weakSelf.view.right).with.offset(0);
//    }];
}

- (void)viewWillAppear:(BOOL)animated{
    WS(weakSelf);
    _fileWebView = [[UIWebView alloc] init];
    [self.view addSubview:_fileWebView];
    [_fileWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(0);
        make.bottom.equalTo(weakSelf.view.bottom).with.offset(0);
        make.left.equalTo(weakSelf.view.left).with.offset(0);
        make.right.equalTo(weakSelf.view.right).with.offset(0);
    }];
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error
{
    [[[UIAlertView alloc] initWithTitle:@"Attention" message:@"打开文档失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

- (void)viewWillDisappear:(BOOL)animated{
    _fileWebView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
