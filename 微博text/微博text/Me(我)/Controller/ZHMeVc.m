//
//  ZHMeVc.m
//  微博text
//
//  Created by fu00 on 2020/5/7.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHMeVc.h"
#import "ZHWriteVc.h"
#import "ZHOAuthvc.h"
#import "ZHTableViewCell.h"
@interface ZHMeVc ()
@property(nonatomic,strong) ZHWriteVc *ZHwritevc;
@property(nonatomic,strong) NSArray *textArry;
@property(nonatomic,strong) NSMutableArray *temp;
@end

@implementation ZHMeVc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //发微博按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
    [btn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn addTarget:self action:@selector(jumptoWriteVc) forControlEvents:UIControlEventTouchUpInside];
    
    //登陆按钮
    UIButton *jumptoOauthbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumptoOauthbtn setImage:[UIImage imageNamed:@"me"] forState:UIControlStateNormal];
    [jumptoOauthbtn sizeToFit];
    [jumptoOauthbtn addTarget:self action:@selector(jumptoOauth) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:jumptoOauthbtn];

    
    //接受通知
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"发送" object:self.ZHwritevc];
    
    //取出本地储存的textArry
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"textArry.plist"];
    _textArry = [NSArray arrayWithContentsOfFile:filePath];
}

#pragma mask 跳转发微博控制器方法
- (void)jumptoWriteVc{
    _ZHwritevc = [[ZHWriteVc alloc]init];
    //隐藏tabBar
    _ZHwritevc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_ZHwritevc animated:YES];
}

#pragma mask 跳转登陆控制器方法
- (void)jumptoOauth{
    ZHOAuthvc *vc = [[ZHOAuthvc alloc]init];
    //隐藏底部tabBar
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _textArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHTableViewCell *cell = [[ZHTableViewCell alloc]init];
    ZHStatus *status = [[ZHStatus alloc]init];
    NSDictionary *dict =_textArry[indexPath.row];
    status.text = dict[@"text"];
    //写死评论数点赞数转发数
    NSString *reposts_count = @"0";
    status.reposts_count =reposts_count;
    NSString *comments_count = @"0";
    status.comments_count = comments_count;
    NSString *praise_count =  @"0";
    status.praise_count = praise_count;
    cell.status = status;
    cell.imageString = [NSString stringWithFormat:@"https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3701847413,2165986719&fm=111&gp=0.jpg"];
    cell.originView = [[ZHOriginView alloc]init];
    cell.originView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).widthIs(self.view.size.width).heightIs(175);
    [cell setUpAllChildView];
    
    return cell;
    
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 285;
}


#pragma mark 通知方法
- (void)notification:(NSNotification *)noti{
    NSDictionary *dic = [noti userInfo];
    if (_temp == nil) {
        _temp  = [[NSMutableArray alloc]init];
        for (int i=0; i<_textArry.count; i++) {
            [_temp addObject:_textArry[i]];
        }
    }
    [_temp addObject:dic];
    _textArry = _temp;
    
    //本地沙盒储存
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"textArry.plist"];
    [_textArry writeToFile:filePath atomically:YES];
    [self.tableView reloadData];
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
