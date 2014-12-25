//
//  DataStorage.h
//  oo
//
//  Created by 苏小龙 on 14-5-13.
//  Copyright (c) 2014年 苏小龙. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *cookie;
@interface DataStorage : NSObject
{
    
}

@property (nonatomic, copy) NSString *cookie;
@property (nonatomic, copy) NSString *loginTime;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *friendName;
@property (nonatomic, copy) NSString *friendUID;

+(DataStorage *)sharedInstance;

@end
