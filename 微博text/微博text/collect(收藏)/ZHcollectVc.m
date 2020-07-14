//
//  ZHcollectVc.m
//  微博text
//
//  Created by fu00 on 2020/5/29.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHcollectVc.h"

@interface ZHcollectVc ()
@property (nonatomic,strong) NSArray *collectArray;
@property (nonatomic,strong) ZHTableViewCell *zhtableviewcell;

@end

@implementation ZHcollectVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [path stringByAppendingPathComponent:@"collectStatus.data"];
    //解档
    NSData *collectData = [NSData dataWithContentsOfFile:filepath];
    _collectArray= [NSKeyedUnarchiver unarchiveObjectWithData:collectData];
    [self.tableView reloadData];
    
    //通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh) name:@"刷新收藏" object:_zhtableviewcell];
    [self.tableView reloadData];
    
}
//刷新通知方法
- (void)refresh{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [path stringByAppendingPathComponent:@"collectStatus.data"];
    //解档
    NSData *collectData = [NSData dataWithContentsOfFile:filepath];
    _collectArray= [NSKeyedUnarchiver unarchiveObjectWithData:collectData];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _collectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHTableViewCell *cell = [[ZHTableViewCell alloc]init];
    
    ZHStatus *status = _collectArray[indexPath.row];
    cell.status = status;
    [cell setUpAllChildView];
    
    return cell;
    
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 285;
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
