//
//  RealFileViewController.m
//  OO-reconstruct
//
//  Created by su on 1/5/15.
//  Copyright (c) 2015 su. All rights reserved.
//

#import "RealFileViewController.h"
#import "AFDownloadRequestOperation.h"
#import "myFileCell.h"
#import "ReadViewController.h"
#import "DataStorage.h"
@interface RealFileViewController ()
{
    NSMutableArray *FidArray;
    NSMutableArray *FnNameArray;      //存储文件名称
    
    //requestURLArray-用于存储每一个文件对应的下载URL
    NSMutableArray *requestURLArray;
    //operationArray-用于存储每一个网络请求方便获取和控制
    NSMutableArray *operationArray;
    //webpath-存放下载完成文件的路径
    NSString *webPath;
    ReadViewController *myReadView;
}
@end

@implementation RealFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myReadView = [[ReadViewController alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    webPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/OOTemp"];
    if(![fileManager fileExistsAtPath:webPath])
    {
        [fileManager createDirectoryAtPath:webPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //init array
    requestURLArray = [[NSMutableArray alloc] init];
    operationArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[FidArray count]; i++) {
        [requestURLArray addObject:[NSString stringWithFormat:@"%@%@",@"http://oo.oobg.cn/do/do.php?a=02f5&ty=v&fid=",[FidArray objectAtIndex:i]]];
        NSURL *url = [NSURL URLWithString:[requestURLArray objectAtIndex:i]];
        NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
        [mutableRequest setValue:[DataStorage sharedInstance].cookie forHTTPHeaderField:@"Cookie"];
        NSLog(@"%@",[DataStorage sharedInstance].cookie);
        
        NSString *desPath = [webPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [FnNameArray objectAtIndex:i]]];
        NSLog(@"%@",desPath);
        
        AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:mutableRequest targetPath:desPath shouldResume:YES];
        [operationArray addObject:operation];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - pass method
- (void)getDataFormFileDetailView:(NSMutableArray *)bidArray and:(NSMutableArray *)nameArray{
    FidArray = bidArray;
    FnNameArray = nameArray;
    
    //set requestURLArray and operationArray
//    [requestURLArray removeAllObjects];
//    [operationArray removeAllObjects];
//    for (int i=0; i<[FidArray count]; i++) {
//        [requestURLArray addObject:[NSString stringWithFormat:@"%@%@",@"http://oo.oobg.cn/do/do.php?a=02f5&ty=v&fid=",[FidArray objectAtIndex:i]]];
//        NSURL *url = [NSURL URLWithString:[requestURLArray objectAtIndex:i]];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:urlRequest targetPath:webPath shouldResume:YES];
//        [operationArray addObject:operation];
//    }
    
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
    if ([FnNameArray count] == 0) {
        return 1;
    }else{
        return [FnNameArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    myFileCell *cell = (myFileCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell=[[myFileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //cell.textLabel.text = [nameFileArray objectAtIndex:indexPath.row];
    if ([FnNameArray count] != 0) {
        cell.fileIcon.image = [UIImage imageNamed:[self judgeTheIcon:
                                                   [FnNameArray objectAtIndex:indexPath.row]]];
        cell.fileName.text =[FnNameArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([self fileExistWithName:[FnNameArray objectAtIndex:indexPath.row]]) {
            [cell.actionButton setTitle:@"打开" forState:UIControlStateNormal];
        }else{
            [cell.actionButton setTitle:@"下载" forState:UIControlStateNormal];
        }
    }else{
        cell.fileName.text =@"本抽屉没有文件";
        cell.fileName.textColor = [UIColor redColor];
    }
    cell.progressView.tag = indexPath.row;
    cell.deleteButton.tag = indexPath.row;
    cell.actionButton.tag = indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(deletaFile:) forControlEvents:UIControlEventTouchUpInside];
    [cell.actionButton addTarget:self action:@selector(downloadOrOpenFile:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
}

#pragma mark - cell button function
- (void)downloadOrOpenFile:(id)sender{
    UIButton* button = (UIButton*)sender;
    NSInteger num = button.tag;
    
    NSString *desPath = [webPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [FnNameArray objectAtIndex:num]]];
    
    //判断Documents/OOTemp目录下是否有对应的文件，若无则下载，若有则直接打开
    if ([button.titleLabel.text  isEqual: @"打开"]) {
        if ([[[[FnNameArray objectAtIndex:num] componentsSeparatedByString:@"."] objectAtIndex:1] isEqualToString:@"txt"]) {
             //载入txt
            NSData *txtdata = [NSData dataWithContentsOfFile:desPath];
            [self myFileViewLoadTxt:txtdata with:[FnNameArray objectAtIndex:num]];
            
        }else{
            //载入其他类型文本
            NSURL *url = [NSURL URLWithString:desPath];
            [self myfileViewloadOther:url with:[FnNameArray objectAtIndex:num]];
        }
    }else if([button.titleLabel.text  isEqual: @"下载"]){
        //加入队列进行下载
        AFDownloadRequestOperation *downOperation = [operationArray objectAtIndex:num];
        [[NSOperationQueue mainQueue] addOperation:downOperation];
        [button setTitle:@"暂停" forState:UIControlStateNormal];
        //NSLog(@"tempPath = %@",downOperation.tempPath);
        NSString *path = downOperation.tempPath;
        myFileCell *cell = [[self.tableView visibleCells] objectAtIndex:num];
        [downOperation setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
            //主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.progressView.progress = totalBytesReadForFile/(float)totalBytesExpectedToReadForFile;
            });
        }];
        [downOperation setCompletionBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:@"打开" forState:UIControlStateNormal];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSString *desPath = [webPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [FnNameArray objectAtIndex:num]]];
                //下载完将数据从缓存拷贝到指定目录
                [fileManager copyItemAtPath:path toPath:desPath error:nil];
            });
        }];
    }else if ([button.titleLabel.text  isEqual: @"暂停"]){
        [[operationArray objectAtIndex:num] suspend];
        [button setTitle:@"继续" forState:UIControlStateNormal];
    }else if ([button.titleLabel.text  isEqual: @"继续"]){
        [[operationArray objectAtIndex:num] resume];
        [button setTitle:@"暂停" forState:UIControlStateNormal];
    }

}

- (void)deletaFile:(id)sender{
    UIButton* button = (UIButton*)sender;
    //NSLog(@"%ld",(long)button.tag);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *desPath = [[documentsDirectory stringByAppendingPathComponent:@"Documents/OOTemp"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [FnNameArray objectAtIndex:button.tag]]];
    BOOL removeFlag = [fileManager removeItemAtPath:desPath error:nil];
   
    myFileCell *cell = [[self.tableView visibleCells] objectAtIndex:button.tag];
    //NSLog(@"%ld",(long)cell.progressView.tag);
    if (removeFlag) {
        cell.progressView.progress = 0.0;
    }
    
}

#pragma mark - 读文件操作
-(void)myFileViewLoadTxt:(NSData *)txtData with:(NSString *)filename
{
    [myReadView.fileWebView reload];
    [myReadView.fileWebView loadData:txtData MIMEType:@"text/txt" textEncodingName:@"GBK" baseURL:nil];
    [self.navigationItem setTitle:filename];
    
}

-(void)myfileViewloadOther:(NSURL *)url with:(NSString *)filename
{
    [myReadView.fileWebView reload];
    [myReadView.fileWebView loadRequest:[NSURLRequest requestWithURL:url]];
    //[myReadView.navBarItem setTitle:filename];
    [self.navigationItem setTitle:filename];
}

#pragma mark - 文件操作
//判断目录下是否有文件
- (BOOL)fileExistWithName:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *desPath = [[documentsDirectory stringByAppendingPathComponent:@"Documents/OOTemp"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    return [fileManager fileExistsAtPath:desPath];
}

//删除目录下文件
- (BOOL)deleteFileWithName:(NSString *)fileName{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *desPath = [[documentsDirectory stringByAppendingPathComponent:@"Documents/OOTemp"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    return [fileManager removeItemAtPath:desPath error:&error];
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
