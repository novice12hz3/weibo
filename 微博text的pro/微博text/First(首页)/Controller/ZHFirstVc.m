//
//  ZHFirstVc.m
//  微博text
//
//  Created by fu00 on 2020/5/7.
//  Copyright © 2020 fu00. All rights reserved.

#import "ZHFirstVc.h"
#import "ZHOAuthvc.h"
#import "ZHStatus.h"
#import "ZHOriginView.h"
#import "ZHTableViewCell.h"
#import "ZHcollectVc.h"
#import "ZHHisitoryVc.h"
#import "ZHsearchTabVc.h"
#import "AFNetworking.h"
#import "ZHSearchVc.h"
@interface ZHFirstVc ()<UISearchBarDelegate>
@property(nonatomic,strong) ZHStatus *status;
@property(nonatomic,strong) NSMutableArray *statusArray;
@property(nonatomic,strong) NSMutableArray *dictArry;
@property(nonatomic,strong) ZHTableViewCell *cell;
@property(nonatomic,strong) NSMutableArray *collectArray;
@property(nonatomic,strong) NSMutableArray *historyArray;
@property(nonatomic,strong) NSMutableArray *collecttemp;
@property(nonatomic,strong) NSMutableArray *historytemp;
@property(nonatomic,strong) NSMutableDictionary *imagedict;
@property(nonatomic,strong) ZHcollectVc *zhcollectVc;
@property(nonatomic,strong) ZHHisitoryVc *zhhistoryVc;
@property(nonatomic,strong) ZHsearchTabVc *zhsearchtabVc;
@property (nonatomic,strong) AVPlayerViewController *avPlayerVC;
@end

@implementation ZHFirstVc

static NSString *ID = @"weibocell";

- (AVPlayerViewController *)avPlayerVC{
    if (self.avPlayerVC == nil) {
        self.avPlayerVC = [[AVPlayerViewController alloc]init];
    }
    
    return self.avPlayerVC;
}

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


    NSString *str = [NSString stringWithFormat:@"http://api02.idataapi.cn:8000/post/weibo?"];
    NSDictionary *dictionary = @{
                           @"apikey":@"SDT4UxVF4pF2wenM7Dd076viivgzudDfdnJ7VsN8wzkb9Mk3u8rhsyi1qFLIRjyt",
                           @"kw":@"%E5%8C%97%E4%BA%AC",
                           @"uid":@"2803301701"
                           };
    
//    [self AFNget:str dict:dictionary];
    
    
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
    
    //缓存微博数据
    NSString *path11 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath11 = [path11 stringByAppendingPathComponent:@"status.plist"];
    NSData *data = [NSData dataWithContentsOfFile:filepath11];
    self.statusArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self.tableView reloadData];
    
    
//    self.tableView
//    [self.view setFrame:CGRectMake(0, 150, 414, self.tableView.frame.size.height)];
    
   
}

- (void)setupNavgationerBar{
    /*右上角按钮*/
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    //左上角网络搜索
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setImage:[UIImage imageNamed:@"discover"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(discover) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
}
#pragma mark 网络请求
- (void)AFNget:(NSString *)string dict:(NSDictionary *)dict{

//        __block NSMutableArray *Array = [[NSMutableArray alloc]init];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:string parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            self.dictArry = responseObject[@"data"];
            NSMutableArray *temp=[NSMutableArray array];//临时数组
            for (NSDictionary *dict in self.dictArry) {
                ZHStatus *statuses = [ZHStatus statuseswithDict:dict];
                //模型存入临时数组
                [temp addObject:statuses];
            }
            //临时数组转数组
            self.statusArray = temp;
            //缓存微博数据
            NSString *path11 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *filepath11 = [path11 stringByAppendingPathComponent:@"status.plist"];
            NSData *statusdata = [NSKeyedArchiver archivedDataWithRootObject:self.statusArray];
            [statusdata writeToFile:filepath11 atomically:YES];
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
    
    
    
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


# pragma mark 监听方法
-(void)refresh{
    
    NSString *str = [NSString stringWithFormat:@"http://api02.idataapi.cn:8000/post/weibo?"];
    NSDictionary *dictionary = @{
                                 @"apikey":@"fp40srNpCn5fvwAMQj0qsmLcDrhX6ypPySRBGjC8fRoPRCQexYc29kN0CegiKLMp",
                                 @"kw":@"%E5%8C%97%E4%BA%AC",
                                 @"uid":@"2803301701"
                                 };
    [self AFNget:str dict:dictionary];
    [self.tableView reloadData];
    if ([self.tableView.refreshControl isRefreshing]) {
        [self.tableView.refreshControl endRefreshing];
    }
    
}

- (void) discover{
    ZHSearchVc *vc = [[ZHSearchVc alloc]init];
    
    //    [self.view addSubview:_searchBar];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//屏幕旋转自动调用方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return self.statusArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _status = [[ZHStatus alloc]init];
    _status = self.statusArray[indexPath.row];

    ZHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZHTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }else{
        while ([cell.contentView.subviews lastObject] !=nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.status = _status;
    cell.imageArray = [_imagedict objectForKey:cell.status.icon];
    cell.contentView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).widthIs(self.view.size.width);
    
    cell = [cell setUpAllChildView];
    
    _cell = cell;
    
    return cell;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.tableView cellHeightForIndexPath:indexPath cellContentViewWidth:414 tableView:self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHStatus *status = [[ZHStatus alloc]init];
    status = _statusArray[indexPath.row];

    [self.avPlayerVC.player pause];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [path stringByAppendingPathComponent:@"historyArray.data"];
    //先取出以前储存的历史记录数组（实现储存多个历史status）
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    _historytemp = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (_historytemp == nil) {
        _historytemp = [NSMutableArray arrayWithCapacity:0];
    }
    [_historytemp addObject:status];
   
    _historyArray = _historytemp;
    //        归档
    NSData *arrayData  = [NSKeyedArchiver archivedDataWithRootObject:_historyArray];
    if ([arrayData writeToFile:filepath atomically:YES]) {
        NSLog(@"归档成功");
    }
    
    //通知历史tableviewcontroll 刷新
    NSNotification *note = [NSNotification notificationWithName:@"刷新历史" object:_zhhistoryVc];
    [[NSNotificationCenter defaultCenter]postNotification:note];

}


//底部加载
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentSize.height+20 <scrollView.frame.size.height+scrollView.contentOffset.y) {
        NSString *str = [NSString stringWithFormat:@"http://api02.idataapi.cn:8000/post/weibo?"];
        NSDictionary *dictionary = @{
                                     @"apikey":@"SDT4UxVF4pF2wenM7Dd076viivgzudDfdnJ7VsN8wzkb9Mk3u8rhsyi1qFLIRjyt",
                                     @"kw":@"%E5%8C%97%E4%BA%AC",
                                     @"uid":@"2803301701",
                                     @"pageToken":@"2"
                                     };
        
        __block NSMutableArray *Array = [[NSMutableArray alloc]init];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:str parameters:dictionary headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            self.dictArry = responseObject[@"data"];
            NSMutableArray *temp=[NSMutableArray array];//临时数组
            for (NSDictionary *dict in self.dictArry) {
                ZHStatus *statuses = [ZHStatus statuseswithDict:dict];
                //模型存入临时数组
                [temp addObject:statuses];
            }
            //临时数组转数组
            Array = temp;
            [self.statusArray addObjectsFromArray:Array];
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];

    }
    
}
@end
