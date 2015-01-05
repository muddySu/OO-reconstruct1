//
//  httpRequest.h
//  oo
//
//  Created by 苏小龙 on 14-5-6.
//  Copyright (c) 2014年 苏小龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface httpRequest : NSMutableURLRequest

//-(NSMutableURLRequest *)initGetData:(NSData *)postdata;
+ (instancetype)initGetData:(NSData *)postdata;
+ (instancetype)initGetDataWithCookies:(NSData *)postdata;
+ (instancetype)initGetFilesWithCookies:(NSData *)postdata;
@end
