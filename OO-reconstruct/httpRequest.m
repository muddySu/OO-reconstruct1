//
//  httpRequest.m
//  oo
//
//  Created by 苏小龙 on 14-5-6.
//  Copyright (c) 2014年 苏小龙. All rights reserved.
//

#import "httpRequest.h"
#import "DataStorage.h"
@implementation httpRequest

-(NSMutableURLRequest *)getData:(NSData *)postdata
{
    NSURL *url = [NSURL URLWithString:@"http://oo.oobg.cn/do/do.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postdata];
    [request setTimeoutInterval:30.0f];
    //[request setAccessibilityLanguage:@"zh-CH"];
    //[request setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[postdata length]] forHTTPHeaderField:@"Content-Length"];
    return request;
}

-(NSMutableURLRequest *)getDataWithCookies:(NSData *)postdata
{
    DataStorage *dataStorge = [DataStorage sharedInstance];
    //NSLog(@"dataStorge.cookie in httpRequest %@",dataStorge.cookie);
    NSURL *url = [NSURL URLWithString:@"http://oo.oobg.cn/do/do.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postdata];
    [request setTimeoutInterval:30.0f];
    [request setValue:dataStorge.cookie forHTTPHeaderField:@"Cookie"];
    [request setAccessibilityLanguage:@"zh-CH"];
    [request setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[postdata length]] forHTTPHeaderField:@"Content-Length"];
    return request;
}

-(NSMutableURLRequest *)getFilesWithCookies:(NSData *)postdata
{
    DataStorage *dataStorge = [DataStorage sharedInstance];
    //NSLog(@"dataStorge.cookie in httpRequest %@",dataStorge.cookie);
    NSString *a = [[NSString alloc] initWithData:postdata encoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:a];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //[request setURL:url];
    [request setHTTPMethod:@"POST"];
    //[request setHTTPBody:postdata];
    [request setTimeoutInterval:30.0f];
    [request setValue:dataStorge.cookie forHTTPHeaderField:@"Cookie"];
    [request setAccessibilityLanguage:@"zh-CH"];
    [request setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[postdata length]] forHTTPHeaderField:@"Content-Length"];
    return request;
}


@end
