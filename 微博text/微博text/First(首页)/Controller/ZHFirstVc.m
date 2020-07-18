//
//  ZHFirstVc.m
//  微博text
//
//  Created by fu00 on 2020/5/7.
//  Copyright © 2020 fu00. All rights reserved.
//
//Back String:{"access_token":"2.00HZCsbG0PLui2910aa110350RA6et","remind_in":"157679999","expires_in":157679999,"uid":"6056401001","isRealName":"true"}
#import "ZHFirstVc.h"
#import "ZHOAuthvc.h"
#import "ZHStatus.h"
#import "ZHTableViewCell.h"
#import "ZHcollectVc.h"
#import "ZHHisitoryVc.h"
#import "ZHsearchTabVc.h"
#import "AFNetworking.h"
@interface ZHFirstVc ()<UISearchBarDelegate>
@property(nonatomic,strong) ZHStatus *status;
@property(nonatomic,strong) NSMutableArray *statusArray;
@property(nonatomic,strong) NSMutableArray *dictArry;
@property(nonatomic,strong) ZHTableViewCell *cell;
@property(nonatomic,strong) NSArray *collectArray;
@property(nonatomic,strong) NSArray *historyArray;
@property(nonatomic,strong) NSMutableArray *collecttemp;
@property(nonatomic,strong) NSMutableArray *historytemp;
@property(nonatomic,strong) NSMutableDictionary *imagedict;
@property(nonatomic,strong) ZHcollectVc *zhcollectVc;
@property(nonatomic,strong) ZHHisitoryVc *zhhistoryVc;
@property(nonatomic,strong) ZHsearchTabVc *zhsearchtabVc;
@end

@implementation ZHFirstVc



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationerBar];
    
    
    _zhsearchtabVc = [[ZHsearchTabVc alloc]init];
    [_zhsearchtabVc.view addSubview:nil];//调用了view，viewdidload同时也调用了(解决第一次搜索要点2次的bug)
    
    NSDictionary *dict = [[NSDictionary alloc]init];
    //取出本地储存的accessdict
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"accessdict.plist"];
    dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
//    NSString *access_token = dict[@"access_token"];//2.00HZCsbG0PLui2910aa110350RA6et
//    NSString *access_token = @"2.00HZCsbG0PLui2910aa110350RA6et";


    NSString *str = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json?"];
    NSDictionary *dictionary = @{
                           @"access_token":@"2.00HZCsbG0PLui2910aa110350RA6et"
                           };
    
//    self.statusArray = [[NSMutableArray alloc]init];
    [self AFNget:str dict:dictionary];

    
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self.tableView reloadData];
    }];
    
//    NSString *path1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)[0];
//    NSString *filepath = [path1 stringByAppendingPathComponent:@"Status.data"];
//    NSData *statusdata = [NSData dataWithContentsOfFile:filepath];
//    self.statusArray = [NSKeyedUnarchiver unarchiveObjectWithData:statusdata];
//    NSLog(@"%lu",_statusArray.count);
//
    
    
    //搜索
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.placeholder = @"请输入文字";
    searchBar.frame = CGRectMake(0, 0, 300, 50);
//    searchBar.
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    [titleView addSubview:searchBar];
    self.navigationItem.titleView = titleView;
    searchBar.delegate = self;
    //拖拽隐藏键盘
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    //下拉刷新
    UIRefreshControl *refreshcontrol = [[UIRefreshControl alloc]init];
    refreshcontrol.tintColor = [UIColor grayColor];
    refreshcontrol.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新"];
    [refreshcontrol addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshcontrol;
    
    
   
}

- (void)setupNavgationerBar{
    /*右上角按钮*/
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
//    [btn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}
#pragma mark 网络请求
- (void)AFNget:(NSString *)string dict:(NSDictionary *)dict{
//    //1创建队列
    dispatch_queue_t queue = dispatch_queue_create("队列", DISPATCH_QUEUE_CONCURRENT);
    //2封装任务
    dispatch_async(queue, ^{
        __block NSMutableArray *Array = [[NSMutableArray alloc]init];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:string parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.dictArry = responseObject[@"statuses"];
            NSMutableArray *temp=[NSMutableArray array];//临时数组
            for (NSDictionary *dict in self.dictArry) {
                ZHStatus *statuses = [ZHStatus statuseswithDict:dict];
                //模型存入临时数组
                [temp addObject:statuses];
            }
            //临时数组转数组
             Array = temp;
            self.statusArray = Array;
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
       
    });
    
    
}

# pragma mark searchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
        NSString *searchtext = searchBar.text;
        NSDictionary *searchdict = [[NSDictionary alloc]init];
        NSMutableArray *searchtemp = [[NSMutableArray alloc]init];
        for (int i=0; i<_statusArray.count; i++) {
            ZHStatus *status = [[ZHStatus alloc]init];
            status = _statusArray[i];
            NSString *contenttext =status.text;
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",searchtext];
            if ([predicate evaluateWithObject:contenttext]) {
                NSLog(@"搜索到了");
                [searchtemp addObject:status];
                searchdict = [NSDictionary dictionaryWithObject:searchtemp forKey:@"Array"];
            }else{
                NSLog(@"未寻找到该内容");
            }

        }
    
    NSNotification *note = [NSNotification notificationWithName:@"search" object:self   userInfo:searchdict];
    [[NSNotificationCenter defaultCenter]postNotification:note];
    
    _zhsearchtabVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_zhsearchtabVc animated:YES];
}


# pragma mark 刷新方法
-(void)refresh{
    NSString *str = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json?"];
    NSDictionary *dictionary = @{
                                 @"access_token":@"2.00HZCsbG0PLui2910aa110350RA6et"
                                 };
    
    [self AFNget:str dict:dictionary];
    [self.tableView reloadData];
    if ([self.tableView.refreshControl isRefreshing]) {
        [self.tableView.refreshControl endRefreshing];
    }
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"222");
//    if (self.statusArray.count == 0) {
//        return 1;
//    }else{
        return self.statusArray.count;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _status = [[ZHStatus alloc]init];
    _status = self.statusArray[indexPath.row];
//     if(_status.pic_urls) {
//                NSDictionary *dict1 = _status.pic_urls[0];
//                _status.icon = dict1[@"thumbnail_pic"];
//            }
    ZHTableViewCell *cell = [[ZHTableViewCell alloc]init];
    cell.status = _status;
    cell.imageArray = [_imagedict objectForKey:cell.status.icon];
    cell = [cell setUpAllChildView];
    
     [_imagedict setObject:cell.imageArray forKey:_status.icon];
    
    _cell = cell;
    
   
    
    NSDictionary *dict = _dictArry[indexPath.row];
    NSNotification *note = [NSNotification notificationWithName:@"collect" object:self userInfo:dict];
    [[NSNotificationCenter defaultCenter]postNotification:note];
    
    return cell;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 285;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHStatus *status = [[ZHStatus alloc]init];
    status = _statusArray[indexPath.row];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [path stringByAppendingPathComponent:@"historyArray.data"];
    //先取出以前储存的历史记录数组（实现储存多个历史status）
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    _historytemp = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [_historytemp addObject:status];
    if (_historytemp == nil) {
        _historytemp = [NSMutableArray arrayWithCapacity:0];
    }
    _historyArray = _historytemp;
    //        归档
    NSData *arrayData  = [NSKeyedArchiver archivedDataWithRootObject:_historyArray];
    if ([arrayData writeToFile:filepath atomically:YES]) {
        NSLog(@"归档成功");
    }
    
    //通知收藏tableviewcontroll 刷新
    NSNotification *note = [NSNotification notificationWithName:@"刷新历史" object:_zhhistoryVc.tableView];
    [[NSNotificationCenter defaultCenter]postNotification:note];
    
}
@end
