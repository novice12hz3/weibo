//
//  ZHsearchTabVc.m
//  微博text
//
//  Created by fu00 on 2020/6/1.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHsearchTabVc.h"
#import "ZHTableViewCell.h"
@interface ZHsearchTabVc ()
@property (nonatomic,strong) ZHStatus *status;
@property (nonatomic,strong) NSArray *statusArray;
@property (nonatomic,strong) ZHFirstVc *fistVc;
@end

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
    ZHTableViewCell *cell = [[ZHTableViewCell alloc]init];
    cell.status = status;
    [cell setUpAllChildView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 285;
}



@end
