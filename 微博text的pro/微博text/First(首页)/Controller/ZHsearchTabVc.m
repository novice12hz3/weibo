//
//  ZHsearchTabVc.m
//  微博text
//
//  Created by fu00 on 2020/6/1.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHsearchTabVc.h"

@interface ZHsearchTabVc ()

@end
static NSString *ID = @"weibocell";

@implementation ZHsearchTabVc

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(search:) name:@"search" object:nil];
}

- (void)search:(NSNotification *)noti{
    NSDictionary *dict = [noti userInfo];
    _statusArray = dict[@"Array"];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _statusArray.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHStatus *status = _statusArray[indexPath.row];
    ZHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZHTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }else{
        while ([cell.contentView.subviews lastObject] !=nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.status = status;
    [cell setUpAllChildView];
    [self.cellArray addObject:cell];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.tableView cellHeightForIndexPath:indexPath cellContentViewWidth:414 tableView:self.tableView];

}



@end
