//
//  handleLogResponedData.m
//  OO-reconstruct
//
//  Created by su on 14/12/25.
//  Copyright (c) 2014年 su. All rights reserved.
//

#import "handleLogResponedData.h"
#import "DataStorage.h"
#import "FliesViewController.h"
#import "ChatViewController.h"
@implementation handleLogResponedData


//处理登录请求
- (void)handThelogResponedData:(NSData *)data
{
    NSError *error;
    NSDictionary *jsonDic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments   error:&error];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *chatArray = [[NSMutableArray alloc] init];
    NSMutableArray *onOffArray = [[NSMutableArray alloc] init];
    //存放键fb对应的对象
    //            NSLog(@"%@ %d",[[[jsonDic objectForKey:@"First"]  objectForKey:@"fb"] objectAtIndex:0],[[[jsonDic objectForKey:@"First"]  objectForKey:@"fb"] count]);
    if ([jsonDic objectForKey:@"First"]) {
        if ([[jsonDic objectForKey:@"First"]  objectForKey:@"fb"]) {
            for (int i=0; i<[[[jsonDic objectForKey:@"First"]  objectForKey:@"fb"] count]; i++) {
                [array addObject:[[[jsonDic objectForKey:@"First"]  objectForKey:@"fb"] objectAtIndex:i]];
            }
        }else{
            NSLog(@"no fb");
        }
        if ([[[jsonDic objectForKey:@"First"]  objectForKey:@"u"] objectForKey:@"all"]) {
            for (int i=0; i<[[[[jsonDic objectForKey:@"First"]  objectForKey:@"u"] objectForKey:@"all"] count]; i++) {
                if (![[[[[[jsonDic objectForKey:@"First"]  objectForKey:@"u"] objectForKey:@"all"] objectAtIndex:i] objectForKey:@"_3"] isEqualToString:[DataStorage sharedInstance].username]) {
                    [chatArray addObject:[[[[jsonDic objectForKey:@"First"]  objectForKey:@"u"] objectForKey:@"all"] objectAtIndex:i]];
                }
                //[chatArray addObject:[[[jsonDic objectForKey:@"First"]  objectForKey:@"all"] objectAtIndex:i]];
            }
            
        }else{
            NSLog(@"no userinfo");
        }
        if ([[[jsonDic objectForKey:@"First"]  objectForKey:@"u"] objectForKey:@"on"]) {
            for (int i=0; i<[[[[jsonDic objectForKey:@"First"]  objectForKey:@"u"] objectForKey:@"on"] count]; i++) {
                [onOffArray addObject:[[[[jsonDic objectForKey:@"First"]  objectForKey:@"u"] objectForKey:@"on"] objectAtIndex:i]];
                //[chatArray addObject:[[[jsonDic objectForKey:@"First"]  objectForKey:@"all"] objectAtIndex:i]];
            }
        }
        
    }else{
        NSLog(@"no first");
    }
    
    //array need to pass to filesviewcontroller
    NSMutableArray *bidArray = [[NSMutableArray alloc] init];
    NSMutableArray *nameArray = [[NSMutableArray alloc] init];
    
    
    for (int i=0; i<[array count]; i++) {
        [bidArray addObject:(NSString *)[[array objectAtIndex:i] objectForKey:@"bid"]];
        //[nameArray addObject:(NSString *)[[array objectAtIndex:i] objectForKey:@"bn"]];
        
        NSString *nameString = (NSString *)[[array objectAtIndex:i] objectForKey:@"bn"];
        NSRange range1 = [nameString rangeOfString:@"<"];
        NSRange range2 = [nameString rangeOfString:@">"];
        NSRange range3 = [nameString rangeOfString:@"/"];
        if (range1.location != NSNotFound && range2.location != NSNotFound && range3.location != NSNotFound) {
            NSString *realnameString = [nameString substringWithRange:NSMakeRange(range2.location+1, range3.location-range2.location-2)];
            [nameArray addObject:realnameString];
        }else{
            [nameArray addObject:(NSString *)[[array objectAtIndex:i] objectForKey:@"bn"]];
        }
        
    }
    [[FliesViewController shareInstance] getArrayFromResponsedData:bidArray and:nameArray];
}

//处理文件第一次请求数据
- (void)handTheFileResponeData:(NSData *)result{
    NSError *error;
    NSDictionary *jsonDic =[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments   error:&error];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if ([jsonDic objectForKey:@"r"]) {
        for (int i = 0; i<[[jsonDic objectForKey:@"r"] count]; i++) {
            [array addObject:[[jsonDic objectForKey:@"r"] objectAtIndex:i]];
        }
        
        //array need to pass
        NSMutableArray *fileNameArray = [[NSMutableArray alloc] init];
        NSMutableArray *newbidFileArray = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[array count]; i++) {
            if ([[[array objectAtIndex:i] objectForKey:@"bn"] isEqualToString:@""]) {
                [fileNameArray addObject:@"抽屉"];
            }else
            {
                NSString *nameString = (NSString *)[[array objectAtIndex:i] objectForKey:@"bn"];
                NSRange range1 = [nameString rangeOfString:@"<"];
                NSRange range2 = [nameString rangeOfString:@">"];
                NSRange range3 = [nameString rangeOfString:@"/"];
                if (range1.location != NSNotFound && range2.location != NSNotFound && range3.location != NSNotFound) {
                    NSString *realnameString = [nameString substringWithRange:NSMakeRange(range2.location+1, range3.location-range2.location-2)];
                    [fileNameArray addObject:realnameString];
                }else{
                    [fileNameArray addObject:(NSString *)[[array objectAtIndex:i] objectForKey:@"bn"]];
                }
            }
            [newbidFileArray addObject:[[array objectAtIndex:i] objectForKey:@"bid"]];
        }
        
    }
}
@end

