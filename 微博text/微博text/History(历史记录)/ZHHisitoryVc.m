//
//  ZHHisitoryVc.m
//  微博text
//
//  Created by fu00 on 2020/5/30.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHHisitoryVc.h"
#import "ZHTableViewCell.h"
#import "ZHFirstVc.h"
@interface ZHHisitoryVc ()
@property(nonatomic,strong) NSArray *historyArray;
@property(nonatomic,strong) ZHFirstVc *zhfirstVc;
@end

@implementation ZHHisitoryVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [path stringByAppendingPathComponent:@"historyArray.data"];
    NSData *historydata = [NSData dataWithContentsOfFile:filepath];
    _historyArray = [NSKeyedUnarchiver unarchiveObjectWithData:historydata];
    [self.tableView reloadData];
    
    
    self.tableView.dataSource =self;
    //通知刷新tableview
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh) name:@"刷新历史" object:_zhfirstVc];
    [self.tableView reloadData];
    
    
}

#pragma mark 通知方法
- (void)refresh{
    NSString *path =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [path stringByAppendingPathComponent:@"historyArray.data"];
    NSData *historydata = [NSData dataWithContentsOfFile:filepath];
    _historyArray = [NSKeyedUnarchiver unarchiveObjectWithData:historydata];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _historyArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHTableViewCell *cell = [[ZHTableViewCell alloc]init];
    ZHStatus *status = _historyArray[indexPath.row];
    cell.status = status;
    [cell setUpAllChildView];
    return cell;
}

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
