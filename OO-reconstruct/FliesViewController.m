//
//  FliesViewController.m
//  OO-reconstruct
//
//  Created by su on 1/4/15.
//  Copyright (c) 2015 su. All rights reserved.
//

#import "FliesViewController.h"
#import "AppDelegate.h"
#import "handleLogResponedData.h"
#import "myCell.h"
@interface FliesViewController ()
{
    NSMutableArray *bidFileArray;
    NSMutableArray *nameFileArray;
    UIImage *fileIconImage;
    NSString *requestBodyString;
}
@end

@implementation FliesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"欧欧云办公"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    fileIconImage = [UIImage imageNamed:@"newfile"];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    bidFileArray = [AppDelegate userInfo].bidMutableArray;
    nameFileArray = [AppDelegate userInfo].nameMutableArray;
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
    NSLog(@"number of row method");
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
    requestBodyString = [bidFileArray objectAtIndex:indexPath.row];
    [self requestForFile];
}

#pragma mark
#pragma mark - 私有方法
- (void)requestForFile{
    
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
