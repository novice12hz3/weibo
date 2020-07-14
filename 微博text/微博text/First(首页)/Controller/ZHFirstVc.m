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
@interface ZHFirstVc ()<UISearchBarDelegate>
@property(nonatomic,strong) ZHStatus *status;
@property(nonatomic,strong) NSMutableArray *statusArray;
@property(nonatomic,strong) NSArray *dictArry;
@property(nonatomic,strong) ZHTableViewCell *cell;
@property(nonatomic,strong) NSArray *collectArray;
@property(nonatomic,strong) NSArray *historyArray;
@property(nonatomic,strong) NSMutableArray *collecttemp;
@property(nonatomic,strong) NSMutableArray *historytemp;
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
    NSString *access_token = @"2.00HZCsbG0PLui2910aa110350RA6et";

//    NSString *uid = dict[@"uid"];
    //获取微博数据
    NSString *urlstr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json?access_token=%@",access_token];
    NSURL *url = [NSURL URLWithString:urlstr];
    //2创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3发送请求
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
   
    //将字典数组转模型
    _dictArry = dictionary[@"statuses"];
    NSMutableArray *temp=[NSMutableArray array];//临时数组
    for (NSDictionary *dict in _dictArry) {
        ZHStatus *statuses = [ZHStatus statuseswithDict:dict];
        //模型存入临时数组
        [temp addObject:statuses];
    }
    //临时数组转数组
    _statusArray = temp;
   
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    //刷新tableview的内容
    [self.tableView reloadData];
    
    
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
   
}

- (void)setupNavgationerBar{
    /*右上角按钮*/
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
//    [btn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
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


# pragma mark 右上角刷新按钮
-(void)refresh{
    NSString *access_token = [NSString stringWithFormat:@"2.00HZCsbG0PLui2910aa110350RA6et"];
    //    NSString *uid = [NSString stringWithFormat:@"6056401001"];
    //获取微博数据
    NSString *urlstr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json?access_token=%@",access_token];
    NSURL *url = [NSURL URLWithString:urlstr];
    //2创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3发送请求
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    //将字典数组转模型
   _dictArry = dictionary[@"statuses"];
    NSMutableArray *temp=[NSMutableArray array];//临时数组
    for (NSDictionary *dict in _dictArry) {
        ZHStatus *status = [ZHStatus statuseswithDict:dict];
        //模型存入临时数组
        [temp addObject:status];
    }
    //临时数组转数组
    _statusArray = temp;
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _status = [[ZHStatus alloc]init];
    _status = self.statusArray[indexPath.row];
    ZHTableViewCell *cell = [[ZHTableViewCell alloc]init];
    cell.status = _status;
    cell = [cell setUpAllChildView];
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
