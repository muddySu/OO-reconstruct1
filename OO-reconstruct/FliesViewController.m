//
//  FliesViewController.m
//  OO-reconstruct
//
//  Created by su on 1/4/15.
//  Copyright (c) 2015 su. All rights reserved.
//

#import "FliesViewController.h"
#import "httpRequest.h"
#import "AFHTTPRequestOperationManager.h"
#import "myCell.h"
#import "DataStorage.h"
#import "FileDetailViewController.h"
@interface FliesViewController ()
{
    NSMutableArray *bidFileArray;
    NSMutableArray *nameFileArray;
    UIImage *fileIconImage;
    NSString *requestBodyString;
    FileDetailViewController *detailView;
}
@end

@implementation FliesViewController

static FliesViewController *instance = nil;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FliesViewController alloc] init];
    });
    return instance;
}

+ (void)releaseInstance
{
    instance = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"欧欧云办公"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    fileIconImage = [UIImage imageNamed:@"newfile"];
    detailView = [[FileDetailViewController alloc] init];
}

- (void)getArrayFromResponsedData:(NSMutableArray *)bidArray and:(NSMutableArray *)nameArray{
    bidFileArray = bidArray;
    nameFileArray = nameArray;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([nameFileArray count]>0) {
        return [nameFileArray count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    myCell *cell = (myCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell=[[myCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.image.image = fileIconImage;
    cell.textlabel.text =[nameFileArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    requestBodyString = [bidFileArray objectAtIndex:indexPath.row];
    [self requestForFile];
}

#pragma mark
#pragma mark - 私有方法
- (void)requestForFile{
    WS(weakSelf);
    NSString *newString = [NSString stringWithFormat:@"%@%@",@"a=022&bid=",requestBodyString];
    NSData *newData = [newString dataUsingEncoding:NSUTF8StringEncoding];
    httpRequest *request = [httpRequest initGetDataWithCookies:newData];
    AFHTTPRequestOperation *opearation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [opearation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        NSDictionary *jsonDic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments   error:&error];
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
            [weakSelf.navigationController pushViewController:detailView animated:YES];
            [detailView getDataFormFilesView:newbidFileArray and:newbidFileArray];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Attention" message:@"请求失败，请检测网络或重新请求" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
    [opearation start];
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
