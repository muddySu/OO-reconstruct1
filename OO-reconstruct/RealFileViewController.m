//
//  RealFileViewController.m
//  OO-reconstruct
//
//  Created by su on 1/5/15.
//  Copyright (c) 2015 su. All rights reserved.
//

#import "RealFileViewController.h"
#import "AFDownloadRequestOperation.h"
#import "myCell.h"
@interface RealFileViewController ()
{
    NSMutableArray *FidArray;
    NSMutableArray *FnNameArray;
    
    //requestURLArray-用于存储每一个文件对应的下载URL
    NSMutableArray *requestURLArray;
    //operationArray-用于存储每一个网络请求方便获取和控制
    NSMutableArray *operationArray;
    //webpath-存放下载完成文件的路径
    NSString *webPath;
}
@end

@implementation RealFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    webPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/OOTemp"];
    if(![fileManager fileExistsAtPath:webPath])
    {
        [fileManager createDirectoryAtPath:webPath withIntermediateDirectories:YES attributes:nil error:nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDataFormRealFilesView:(NSMutableArray *)bidArray and:(NSMutableArray *)nameArray{
    FidArray = bidArray;
    FnNameArray = nameArray;
    
    //set requestURLArray and operationArray
    for (int i=0; i<[FidArray count]; i++) {
        [requestURLArray addObject:[NSString stringWithFormat:@"%@%@",@"http://oo.oobg.cn/do/do.php?a=02f5&ty=v&fid=",[FidArray objectAtIndex:i]]];
        NSURL *url = [NSURL URLWithString:[requestURLArray objectAtIndex:i]];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:urlRequest targetPath:webPath shouldResume:YES];
        [operationArray addObject:operation];
    }
    
    //reloadData
    [self.tableView reloadData];
}

#pragma mark - 判断Icon

-(NSString *)judgeTheIcon:(NSString *)string
{
    NSString *resultString,*returnString;
    NSRange range = [string rangeOfString:@"."];
    if (range.location != NSNotFound) {
        resultString = [[string componentsSeparatedByString:@"."] objectAtIndex:1];
        if ([resultString isEqualToString:@"docx"] || [resultString isEqualToString:@"doc"] ) {
            returnString =  @"icon_doc";
        }else if ([resultString isEqualToString:@"xlsx"] || [resultString isEqualToString:@"xlsx"]){
            returnString = @"icon_xlsx";
        }else if ([resultString isEqualToString:@"ppt"]){
            returnString = @"icon_ppt";
        }else if ([resultString isEqualToString:@"pdf"]){
            returnString = @"icon_pdf";
        }else if ([resultString isEqualToString:@"bmp"] || [resultString isEqualToString:@"jpg"] || [resultString isEqualToString:@"jpeg"] || [resultString isEqualToString:@"png"] || [resultString isEqualToString:@"gif"]){
            returnString = @"icon_pic";
        }else{
            returnString = @"icon_txt";
        }
    }else
    {
        returnString = @"icon_txt";
    }
    
    return returnString;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return [FnNameArray count];
    if ([FnNameArray count] == 0) {
        return 1;
    }else{
        return [FnNameArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    myCell *cell = (myCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell=[[myCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //cell.textLabel.text = [nameFileArray objectAtIndex:indexPath.row];
    if ([FnNameArray count] != 0) {
        cell.image.image = [UIImage imageNamed:[self judgeTheIcon:[FnNameArray objectAtIndex:indexPath.row]]
                            ];
        cell.textlabel.text =[FnNameArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.textlabel.text =@"本抽屉没有文件";
        cell.textlabel.textColor = [UIColor redColor];
    }
    return cell;
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
