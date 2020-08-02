//
//  ZHTagVc.m
//  微博text
//
//  Created by fu00 on 2020/7/29.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHTagVc.h"
#import "AFNetworking.h"
#import "ZHStatus.h"
#import "ZHTableViewCell.h"
@interface ZHTagVc ()
@property (nonatomic,strong) NSArray *TagArray;
@property (nonatomic,strong) NSArray *statusArray;
@property (nonatomic,strong) UITableView *tab;
@end
static NSString *ID = @"weibocell";

@implementation ZHTagVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (_TagArray == nil) {
        _TagArray = @[@"游戏",@"八卦",@"科技",@"明星",@"英雄联盟",@"数码",@"搞笑"];
    }
    NSLog(@"%@",_TagArray);
    //标签
    UIScrollView *tagScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50,414,50)];
    tagScrollView.scrollEnabled = YES;
    tagScrollView.contentSize = CGSizeMake(800, 50);
    [self.view addSubview:tagScrollView];
    
    //添加标签按钮
    for (int i = 0; i<_TagArray.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:_TagArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(10+i*120, 0, 80, 50);
        [tagScrollView addSubview:btn];
        
        [btn addTarget:self action:@selector(tagbtn:)forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i];
    }
    
    _tab = [[UITableView alloc]init];
//    _tab.frame = CGRectMake(0, 70, 414, 2000);
    _tab.dataSource = self;
    _tab.delegate = self;
    [self.view addSubview:_tab];
    _tab.sd_layout.topSpaceToView(tagScrollView, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    

}
- (void)tagbtn:(id) sender{
    NSInteger i = [sender tag];
    NSLog(@"%@",_TagArray[i]);
    NSString *string = [NSString stringWithFormat:@"http://api01.idataapi.cn:8000/post/weibo?"];
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]init];
    [dict1 setObject:@"SDT4UxVF4pF2wenM7Dd076viivgzudDfdnJ7VsN8wzkb9Mk3u8rhsyi1qFLIRjyt" forKey: @"apikey"];
    [dict1 setObject:@"hot" forKey:@"type"];
    [dict1 setObject:_TagArray[i] forKey:@"kw"];

    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = dict1;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:string parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dictArry = responseObject[@"data"];
        NSMutableArray *temp=[NSMutableArray array];//临时数组
        for (NSDictionary *dict in dictArry) {
            ZHStatus *statuses = [ZHStatus statuseswithDict:dict];
            //模型存入临时数组
            [temp addObject:statuses];
        }
        self.statusArray = temp;
        [self.tab reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}
#pragma mark tableviewdatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _statusArray.count;
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
    cell.contentView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).widthIs(self.view.size.width);
    cell.status = _statusArray[indexPath.row];
    
    [cell setUpAllChildView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_tab cellHeightForIndexPath:indexPath cellContentViewWidth:414 tableView:_tab];
}
@end
