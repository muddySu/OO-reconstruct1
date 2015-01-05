//
//  loginView.m
//  OO-reconstruct
//
//  Created by su on 12/22/14.
//  Copyright (c) 2014 su. All rights reserved.
//

#import "loginView.h"
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "httpRequest.h"
#import "MyMD5.h"
#import "handleLogResponedData.h"
#import "DataStorage.h"
@interface loginView()
{
    UILabel *titleLabel;
    UILabel *loginLabel;
    UILabel *infoLabel;
    //default
    NSUserDefaults *defaults;
    AFNetworkReachabilityManager *reachManager;
    handleLogResponedData *handle;
}
@end
@implementation loginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self initAndlayOtherView];
    }
    return self;
}

- (void)initAndlayOtherView{
    self.backgroundColor = [UIColor whiteColor];
    titleLabel = [[UILabel alloc] init];
    loginLabel = [[UILabel alloc] init];
    infoLabel = [[UILabel alloc] init];
    
    _useName = [[UITextField alloc] init];
    _passWord = [[UITextField alloc] init];
    _logButton = [[UIButton alloc] init];
    _activityView = [[UIActivityIndicatorView alloc] init];
    _storeSwitch = [[UISwitch alloc] init];
    _logButton = [[UIButton alloc] init];
    
    //添加限制前需要把子视图添加到父视图，否则会报错
    [self addSubview:titleLabel];
    [self addSubview:loginLabel];
    [self addSubview:_useName];
    [self addSubview:_passWord];
    [self addSubview:infoLabel];
    [self addSubview:_logButton];
    [self addSubview:_storeSwitch];

    WS(weakSelf)
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.bottom).with.offset(0);
        make.left.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.height.mas_equalTo(@40);
    }];
    
    [self setLabelStyle:titleLabel andText:@"欧欧云办公" andTextColor:[UIColor grayColor] andBackgroundColor:[UIColor clearColor] andFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0] andTextAlignment:NSTextAlignmentCenter];
    [self setLabelStyle:loginLabel andText:@"请登录" andTextColor:[UIColor grayColor] andBackgroundColor:[UIColor clearColor] andFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0] andTextAlignment:NSTextAlignmentLeft];
    
    
    //set uitextfield
    [_useName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(90);
        make.left.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.height.mas_equalTo(@30);
    }];
    [_passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_useName.bottom).with.offset(0);
        make.left.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.height.mas_equalTo(@30);
    }];
    
    [self setTextStyle:_useName andBordeStyle:UITextBorderStyleRoundedRect
                                andBackgroundColor:[UIColor whiteColor]
                                andString:@"用户名"
                                andAlignment:UIControlContentVerticalAlignmentCenter
                                andFront:[UIFont fontWithName:@"Helvetica" size:13.0]
                                andModel:UITextFieldViewModeAlways
                                andKeyboardType:UIKeyboardTypeDefault andDelegate:self];
    [self setTextStyle:_passWord andBordeStyle:UITextBorderStyleRoundedRect
                                 andBackgroundColor:[UIColor whiteColor]
                                 andString:@"密码"
                                 andAlignment:UIControlContentVerticalAlignmentCenter
                                 andFront:[UIFont fontWithName:@"Helvetica" size:13.0]
                                 andModel:UITextFieldViewModeAlways
                                 andKeyboardType:UIKeyboardTypeDefault andDelegate:self];
    
    //set switch and infoLabel
    [_storeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passWord.bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(20);
        
    }];
    
    _storeSwitch.on = YES;
    [_storeSwitch addTarget:self action:@selector(switchChanged) forControlEvents:UIControlEventValueChanged];
    
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passWord.bottom).with.offset(10);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.height.mas_equalTo(@25);
    }];
    
    [self setLabelStyle:infoLabel andText:@"保存用户名密码" andTextColor:[UIColor grayColor] andBackgroundColor:[UIColor clearColor] andFont:[UIFont fontWithName:@"Helvetica" size:13.0] andTextAlignment:NSTextAlignmentRight];
    
    //set button
    [_logButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeSwitch.bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.height.mas_equalTo(@50);
    }];
    
    [self setButtonStyle:_logButton andTitleColor:[UIColor purpleColor] andTitle:@"登录" withState:UIControlStateNormal andLayerborderWidth:1.0 andLayercornerRadius:4.0 withLayermasksToBounds:YES andBackgroundColor:[UIColor colorWithRed:1 green:0.847 blue:0.376 alpha:0.6] withLayerborderColor:[UIColor whiteColor] ];
    [_logButton addTarget:self action:@selector(requestForLogin) forControlEvents:UIControlEventTouchUpInside];
    
    //set activity
    [_logButton addSubview:_activityView];
    [_activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_logButton);
    }];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    
    //init net work reachbility
    reachManager = [AFNetworkReachabilityManager sharedManager];
    [reachManager startMonitoring];
    NSLog(@"status string %@",[reachManager localizedNetworkReachabilityStatusString]);
    //_isExistenceNetwork = [reachManager isReachable];
    [reachManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (status >= 1) {
            strongSelf.isExistenceNetwork = 1;
        }else{
            strongSelf.isExistenceNetwork = 0;
        }
    }];
    
    //------add defaults---------------------//
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *use = [defaults objectForKey:@"username"];
    NSString *pass = [defaults objectForKey:@"password"];
    _useName.text = use;
    _passWord.text = pass;
    //---------------------------//
    //handleLogResponedData *handle = [[handleLogResponedData alloc] init];
}

#pragma mark
#pragma mark - 设置label
- (void) setLabelStyle:(UILabel *)_Label andText:(NSString *)text andTextColor:(UIColor *)textColor andBackgroundColor:(UIColor *)backgroundColor andFont:(UIFont *)font andTextAlignment:(NSTextAlignment)textAlignment{
    _Label.text = text;
    _Label.textColor = textColor;
    _Label.backgroundColor = backgroundColor;
    _Label.font = font;
    _Label.textAlignment = textAlignment;
}


#pragma mark
#pragma mark - 设置textField
- (void) setTextStyle:(UITextField *)_textField andBordeStyle:(UITextBorderStyle)borderStyle andBackgroundColor:(UIColor *)backgroundColor andString:(NSString *)placeholder andAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment andFront:(UIFont *)font andModel:(UITextFieldViewMode)clearButtonMode andKeyboardType:(UIKeyboardType)keyboardType andDelegate:(id<UITextFieldDelegate>)delegate{
    _textField.borderStyle = borderStyle;
    _textField.backgroundColor = backgroundColor;
    _textField.placeholder = placeholder;
    _textField.contentVerticalAlignment = contentVerticalAlignment;
    _textField.font = font;
    _textField.clearButtonMode = clearButtonMode;
    _textField.keyboardType = keyboardType;
    _textField.delegate = delegate;
}

#pragma mark
#pragma mark - 设置button
- (void) setButtonStyle:(UIButton *)_button andTitleColor:(UIColor *)titleColor andTitle:(NSString *)titleString withState:(UIControlState)controlState andLayerborderWidth:(CGFloat)borderWidth andLayercornerRadius:(CGFloat)cornerRadius withLayermasksToBounds:(BOOL)flag andBackgroundColor:(UIColor *)backColor withLayerborderColor:(UIColor *)borderColor{
    [_button setTitle:titleString forState:controlState];
    [_button setTitleColor:titleColor forState:controlState];
    _button.backgroundColor = backColor;
    _button.layer.borderWidth = borderWidth;
    _button.layer.cornerRadius = cornerRadius;
    _button.layer.borderColor = (__bridge CGColorRef)(borderColor);
}


#pragma mark
#pragma mark - 登录请求
- (void) requestForLogin{
    WS(weakSelf);                    //对self弱引用
    
    NSString *newpassword;
    _useNameString = _useName.text;
    _passWordString = _passWord.text;
    _useNameString = @"5@8483";
    _passWordString = @"5@8483";
    [self chargeIsHasNetWork];
    NSLog(@"_isExistenceNetwork %d",_isExistenceNetwork);
    if (!_isExistenceNetwork) {
        [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"当前未连接到网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }else if (_useNameString.length == 0 || _passWordString.length == 0 || _useNameString == nil || _passWordString == nil){
        [[[UIAlertView alloc] initWithTitle:@"Attention" message:@"用户名或密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }else{
        [_activityView startAnimating];
        if (![_passWordString isEqualToString:@""]) {
            newpassword = [MyMD5 newmd5:_passWordString];
        }
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",@"a=010&oo=",_useNameString,@"&pwd=",newpassword,@"&mac=&mac1=&mac2=&winver=2.12&oover=2.12&v=2.12"];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        httpRequest *URLRequest = [httpRequest initGetData:data];
        AFHTTPRequestOperation *opearation = [[AFHTTPRequestOperation alloc] initWithRequest:URLRequest];
        [opearation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData *data = [[NSData alloc] initWithData:responseObject];
            
            //setcookies :首次返回的cookies
            NSHTTPURLResponse *httpResponse = operation.response;
            NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[httpResponse allHeaderFields] forURL:[NSURL URLWithString:@"http://oo.oobg.cn/do/do.php"]];
            NSLog(@"cookies count %lu",(unsigned long)[cookies count]);
            NSString *cookiesString = [[httpResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            [DataStorage sharedInstance].cookie = [[cookiesString componentsSeparatedByString:@";"] objectAtIndex:0];

            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (result.length < 4) {
                [[[UIAlertView alloc] initWithTitle:@"Attention" message:@"用户名密码错误" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                [strongSelf.activityView stopAnimating];
            }else{
                NSError *error;
                NSDictionary *jsonDic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments   error:&error];
                if (![jsonDic objectForKey:@"code"] || ![[jsonDic objectForKey:@"code"] isEqualToString:@"504"]) {
                    [[[UIAlertView alloc] initWithTitle:@"Attention" message:@"用户名密码错误" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                    [strongSelf.activityView stopAnimating];
                }else{
                    handle = [[handleLogResponedData alloc] init];
                    [handle handThelogResponedData:data];
                    [_delegate logViewShouldDelloc];
                    [self removeFromSuperview];
                }
            }
            [strongSelf.activityView stopAnimating];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failure to get data");
            [[[UIAlertView alloc] initWithTitle:@"Attention" message:@"请求失败，请检测网络或重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }];
        [opearation start];
    }
}

- (void)chargeIsHasNetWork{
    WS(weakSelf);
    reachManager =[AFNetworkReachabilityManager sharedManager];
    _isExistenceNetwork = [reachManager isReachable];
    [reachManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (status >= 1) {
            strongSelf.isExistenceNetwork = 1;
        }else{
            strongSelf.isExistenceNetwork = 0;
        }
    }];
}

#pragma mark
#pragma mark - switch change
-(void)switchChanged
{
    if (_storeSwitch== NO) {
        [defaults removeObjectForKey:@"username"];
        [defaults removeObjectForKey:@"password"];
    }
}


#pragma mark
#pragma mark - textfield delegate
//textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _useNameString = _useName.text;
    _passWordString = _passWord.text;
    [defaults setObject:_useNameString forKey:@"username"];
    [defaults setObject:_passWordString forKey:@"password"];
    [defaults synchronize];
    [textField resignFirstResponder];
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _useNameString = _useName.text;
    _passWordString = _passWord.text;
    //NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_useNameString forKey:@"username"];
    [defaults setObject:_passWordString forKey:@"password"];
    [defaults synchronize];
    [textField resignFirstResponder];
}


#pragma mark
- (void) dealloc{
    
}
@end
