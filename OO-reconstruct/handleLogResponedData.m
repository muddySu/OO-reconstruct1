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
#import "AppDelegate.h"
@implementation handleLogResponedData



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
    
    //delegate to fileView
    NSMutableArray *bidArray = [[NSMutableArray alloc] init];
    NSMutableArray *nameArray = [[NSMutableArray alloc] init];
    
    [AppDelegate userInfo].bidMutableArray = bidArray;
    [AppDelegate userInfo].nameMutableArray = nameArray;
    
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
    
}

//处理文件第一次请求数据
- (void)handTheFileResponeData:(NSData *)result{
    
}  
@end

