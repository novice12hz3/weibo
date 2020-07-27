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
@property(nonatomic,strong) NSMutableArray *historyArray;
@property(nonatomic,strong) ZHFirstVc *zhfirstVc;
@property(nonatomic,strong) NSMutableArray *cellArray;

@end
static NSString *ID = @"weibocell";

@implementation ZHHisitoryVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [path stringByAppendingPathComponent:@"historyArray.data"];
    NSData *historydata = [NSData dataWithContentsOfFile:filepath];
    _historyArray = [NSKeyedUnarchiver unarchiveObjectWithData:historydata];
    
    
    if (_historyArray == nil) {
        _historyArray = [NSMutableArray arrayWithCapacity:0];
    }
    if (_cellArray ==nil) {
        _cellArray = [NSMutableArray arrayWithCapacity:0];
    }
//    self.tableView.dataSource =self;
    //通知刷新tableview
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh) name:@"刷新历史" object:self.zhfirstVc];
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
    ZHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZHTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }else{
        while ([cell.contentView.subviews lastObject] !=nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.contentView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).widthIs(self.view.size.width).autoHeightRatio(0);
    cell.status = _historyArray[indexPath.row];
    
    [cell setUpAllChildView];
    [self.cellArray addObject:cell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHTableViewCell *cell = self.cellArray[indexPath.row];
    
    return cell.Height;
}


 

@end
