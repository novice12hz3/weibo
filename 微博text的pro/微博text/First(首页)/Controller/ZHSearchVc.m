//
//  ZHSearchVc.m
//  微博text
//
//  Created by fu00 on 2020/7/26.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHSearchVc.h"
#import "AFNetworking.h"
#import "ZHsearchTabVc.h"
#import "ZHStatus.h"
@interface ZHSearchVc ()
@property(nonatomic,strong) NSMutableArray *historytext;
@property(nonatomic,strong) UISearchBar *searchBar;
@end

@implementation ZHSearchVc

- (void)viewDidLoad {
    [super viewDidLoad];
    //搜索
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.placeholder = @"请输入文字";
    _searchBar.frame = CGRectMake(50, 150, 300, 50);
    [self.view addSubview:_searchBar];
    _searchBar.delegate = self;
    
    
    if (_historytext == nil) {
        _historytext = [NSMutableArray arrayWithCapacity:0];
    }
    
    //本地储存历史搜索
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"historytext.plist"];
    NSData *data = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    _historytext = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    
    UITableView *tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, 414, 300)];
    tab.dataSource =self;
    tab.delegate = self;
    [self.view addSubview:tab];
}
#pragma mark search
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.historytext addObject:searchBar.text];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"historytext.plist"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.historytext];
    [data writeToFile:filePath atomically:YES];
    
    NSString *string = [NSString stringWithFormat:@"http://api02.idataapi.cn:8000/post/weibo?"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"fp40srNpCn5fvwAMQj0qsmLcDrhX6ypPySRBGjC8fRoPRCQexYc29kN0CegiKLMp" forKey: @"apikey"];
    [dict setObject:@"hot" forKey:@"type"];
    [dict setObject:searchBar.text forKey:@"kw"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:string parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dictArry = responseObject[@"data"];
        ZHsearchTabVc *Vc = [[ZHsearchTabVc alloc]init];
        NSMutableArray *temp=[NSMutableArray array];//临时数组
        for (NSDictionary *dict in dictArry) {
            ZHStatus *statuses = [ZHStatus statuseswithDict:dict];
            //模型存入临时数组
            [temp addObject:statuses];
        }
        //临时数组转数组
        Vc.statusArray = temp;
        [self presentViewController:Vc animated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
}
#pragma mark tableviewdatsource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.historytext.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.historytext[indexPath.row];
    return cell;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.searchBar.text = _historytext[indexPath.row];
    [self searchBarTextDidEndEditing:self.searchBar];
}

@end
