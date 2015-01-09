//
//  FileDetailViewController.m
//  OO-reconstruct
//
//  Created by su on 1/5/15.
//  Copyright (c) 2015 su. All rights reserved.
//

#import "FileDetailViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "httpRequest.h"
#import "myCell.h"
#import "RealFileViewController.h"
@interface FileDetailViewController ()
{
    NSMutableArray *bidFileArray;            //存放用于请求的bid
    NSMutableArray *nameFileArray;           //存放文件名称
    UIImage *fileIconImage;
    NSString *requestBodyString;
    RealFileViewController *realFileView;
}
@end

@implementation FileDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"欧欧云办公"];
    fileIconImage = [UIImage imageNamed:@"newfile"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    realFileView = [[RealFileViewController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDataFormFilesView:(NSMutableArray *)bidArray and:(NSMutableArray *)nameArray{
    bidFileArray = bidArray;
    nameFileArray = nameArray;
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    [self.navigationController pushViewController:realFileView animated:YES];

    [self requestForTheFile];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}


#pragma mark - request method

- (void)requestForTheFile{
    NSString *newString = [NSString stringWithFormat:@"%@%@",@"a=023&start=0&limit=20&bid=",requestBodyString];
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
            NSMutableArray *fileNameArray = [[NSMutableArray alloc] init];
            NSMutableArray *newbidFileArray = [[NSMutableArray alloc] init];
            for (int i=0; i<[array count]; i++) {
                [fileNameArray addObject:[[array objectAtIndex:i] objectForKey:@"fn"]];
                [newbidFileArray addObject:[[array objectAtIndex:i] objectForKey:@"fid"]];
            }
            //NSLog(@"newbidFileArray %@",newbidFileArray);
            //push viewcontroller
            //[realFileView getDataFormFileDetailView:newbidFileArray and:fileNameArray];
            //[weakSelf.navigationController pushViewController:realFileView animated:YES];
            [realFileView getDataFormFileDetailView:newbidFileArray and:fileNameArray];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Attention" message:@"请求失败，请检测网络或重新请求" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];

    [opearation start];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
