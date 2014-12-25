//
//  handleLogResponedData.h
//  OO-reconstruct
//
//  Created by su on 14/12/25.
//  Copyright (c) 2014年 su. All rights reserved.
//
/**
 针对在登录过程中需要解析较多数据，采用单独一个类来封装方法，用于对登录请求的数据进行解析
 */
#import <Foundation/Foundation.h>
@interface handleLogResponedData : NSObject
{
}
- (void)handThelogResponedData:(NSData *)result;


@end
