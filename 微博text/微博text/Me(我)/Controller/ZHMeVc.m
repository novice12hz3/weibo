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
@property(nonatomic,strong) NSArray *Array;
@property(nonatomic,strong) NSMutableArray *temp;
@property(nonatomic,strong) NSMutableArray *cellArray;
@end
static NSString *ID = @"personweibocell";

@implementation ZHMeVc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.cellArray == nil) {
        self.cellArray = [NSMutableArray arrayWithCapacity:0];
    }
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
    NSString *filePath = [path stringByAppendingPathComponent:@"Array.plist"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    _Array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    _Array = [NSArray arrayWithContentsOfFile:filePath];
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
    return _Array.count;
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
    ZHStatus *status = [[ZHStatus alloc]init];
    NSDictionary *dict =_Array[indexPath.row];
    status.text = dict[@"text"];
    //写死评论数点赞数转发数
    NSString *reposts_count = @"0";
    status.reposts_count =reposts_count;
    NSString *comments_count = @"0";
    status.comments_count = comments_count;
    NSString *praise_count =  @"0";
    status.praise_count = praise_count;
    cell.status = status;
    cell.imageString = [NSString stringWithFormat:@"https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3701847413,2165986719&fm=111&gp=0.jpg"];    cell.contentView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).widthIs(self.view.size.width).autoHeightRatio(0);
    
     NSMutableArray *imageArray = dict[@"image"];
    cell.imageArray = imageArray;
    
    [cell setUpAllChildView];

   
    

//    NSInteger imageCount = cell.contentView.subviews.count-11;//已添加的图片数
//    NSInteger j = 0;
//    while (imageCount< imageArray.count) {
//        NSInteger i = (imageCount+1)%3;
//        if (i==0) {
//            i = 3;
//        }
//        if (imageCount<3) {
//            j=1;
//        }else{
//            if(imageCount<6){j=2;}else{j=3;}
//        }
//        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.image = imageArray[imageCount];
//        [cell.contentView addSubview:imageView];
//        imageView.sd_layout.leftSpaceToView(self.view, 45+(i-1)*110).topSpaceToView(cell.textView, 110*(j-1)).heightIs(100).widthIs(100);
//        imageCount+= 1;
//
//    }
    
    [self.cellArray addObject:cell];
    return cell;
    
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHTableViewCell *cell = self.cellArray[indexPath.row];
    return cell.Height;
}


#pragma mark 通知方法
- (void)notification:(NSNotification *)noti{
    NSDictionary *dic = [noti userInfo];
    if (_temp == nil) {
        _temp  = [[NSMutableArray alloc]init];
        for (int i=0; i<_Array.count; i++) {
            [_temp addObject:_Array[i]];
        }
    }
    [_temp addObject:dic];
    _Array = _temp;
    
    //本地沙盒储存
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"Array.plist"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_Array];
    [data writeToFile:filePath atomically:YES];
    [self.tableView reloadData];
}


@end
