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
@property(nonatomic,strong) NSMutableArray *cellArray;

@end
static NSString *ID = @"weibocell";
@implementation ZHcollectVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [path stringByAppendingPathComponent:@"collectStatus.data"];
    NSLog(@"%@",path);
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
    ZHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZHTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }else{
        while ([cell.contentView.subviews lastObject] !=nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    ZHStatus *status = _collectArray[indexPath.row];
    cell.status = status;
    cell.contentView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).widthIs(self.view.size.width);
    [cell setUpAllChildView];
    [self.cellArray addObject:cell];
    return cell;
    
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.tableView cellHeightForIndexPath:indexPath cellContentViewWidth:414 tableView:self.tableView];

}


@end
