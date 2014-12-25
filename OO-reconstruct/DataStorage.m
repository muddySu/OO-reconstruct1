//
//  DataStorage.m
//  oo
//
//  Created by 苏小龙 on 14-5-13.
//  Copyright (c) 2014年 苏小龙. All rights reserved.
//

#import "DataStorage.h"

static DataStorage *dataStorage = nil;
@implementation DataStorage

+ (DataStorage *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataStorage = [[DataStorage alloc] init];
    });
    return dataStorage;
}



@end
