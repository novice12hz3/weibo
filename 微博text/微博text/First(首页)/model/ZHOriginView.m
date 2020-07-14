//
//  ZHOriginView.m
//  微博text
//
//  Created by fu00 on 2020/5/20.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHOriginView.h"

@implementation ZHOriginView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildView];
        
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(0, 0, 50, 50);
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = iconView.layer.frame.size.width/2;
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.frame = CGRectMake(50, 0, 250, 25);
    [self addSubview:nameView];
    _nameView = nameView;
    
    // 发布时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.frame = CGRectMake(50, 25, 250, 25);
    timeView.font = [UIFont systemFontOfSize:10];
    [self addSubview:timeView];
    _timeView = timeView;

    // 正文
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(0, 50, 414, 100);
//    textView.numberOfLines = 0;
    textView.editable = NO;
    textView.scrollEnabled = NO;
    [textView setFont:[UIFont systemFontOfSize:17]];
    
    
    [self addSubview:textView];
    _textView = textView;
    
    //配图
    UIImageView *picView1 = [[UIImageView alloc]init];
    picView1.frame = CGRectMake(42, 150, 100, 100);
    [self addSubview:picView1];
    _picView1 = picView1;
    UIImageView *picView2 = [[UIImageView alloc]init];
    picView2.frame = CGRectMake(152, 150, 100, 100);
    [self addSubview:picView2];
    _picView2 = picView2;
    UIImageView *picView3 = [[UIImageView alloc]init];
    picView3.frame = CGRectMake(262, 150, 100, 100);
    [self addSubview:picView3];
    _picView3 = picView3;
    
    //转发
    UIImageView *sendView = [[UIImageView alloc]init];
    sendView.frame = CGRectMake(44,250 , 25, 25);
    sendView.image = [UIImage imageNamed:@"send"];
    [self addSubview:sendView];
    _sendvView = sendView;
    UILabel *sendlabel = [[UILabel alloc]init];
    sendlabel.frame = CGRectMake(69, 250, 50, 25);
    [self addSubview:sendlabel];
    _sendlabel = sendlabel;
    
    //评论
    UIImageView *commentView = [[UIImageView alloc]init];
    commentView.frame =CGRectMake(182, 250, 25, 25);
    commentView.image = [UIImage imageNamed:@"comment"];
    [self addSubview:commentView];
    _commentView = commentView;
    UILabel *commentlabel = [[UILabel alloc]init];
    commentlabel.frame = CGRectMake(207, 250, 50, 25);
    [self addSubview:commentlabel];
    _commmentlabel = commentlabel;
    
    //点赞
    UIImageView *praiseView = [[UIImageView alloc]init];
    praiseView.frame =CGRectMake(320, 250, 25, 25);
    praiseView.image = [UIImage imageNamed:@"praise"];
    [self addSubview:praiseView];
    _praiseView = praiseView;
    UILabel *praiselabel = [[UILabel alloc]init];
    praiselabel.frame = CGRectMake(345, 250, 50, 25);
    [self addSubview:praiselabel];
    _praiselabel = praiselabel;
    
    //收藏按钮
    UIButton *collectbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectbtn.frame = CGRectMake(364, 0, 50, 50);
    [collectbtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectbtn setImage:[UIImage imageNamed:@"收藏 d"] forState:UIControlStateNormal];
//    [collectbtn setImage:[UIImage imageNamed:@"收藏 "] forState:UIControlStateSelected];
//    [collectbtn addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    _collectbtn = collectbtn;
    [self addSubview:collectbtn];
    
    _iscollect = NO;
    

    //添加通知接收
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:@"collect" object:self.zhfirstvc];
    
}

#pragma mark 通知方法
- (void)notification:(NSNotification *)noti{
    NSDictionary *dict = [noti userInfo];
    _status =[ZHStatus statuseswithDict:dict];
    
    
}

#pragma mark 收藏按钮方法
//- (void)collect{
//    _iscollect = !_iscollect;
//    if (_iscollect) {
//        [_collectbtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];

//        //先拿出以前储存的收藏赋值给临时收藏数组（实现收藏多个status）
//        NSString *path =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//        NSString *filepath = [path stringByAppendingPathComponent:@"collectStatus"];
//        NSData *collectData =[NSData dataWithContentsOfFile:filepath];
//        _collecttemp = [NSKeyedUnarchiver unarchiveObjectWithData:collectData];
//        if (_collecttemp == nil) {
//            _collecttemp = [NSMutableArray arrayWithCapacity:0];;
//        }
//        NSLog(@"1111%@",_status.text);
//        [_collecttemp addObject:_status];
//        _collectArray = _collecttemp;
////        归档
//       
//        NSData *arrayData  = [NSKeyedArchiver archivedDataWithRootObject:_collectArray];
//        if ([arrayData writeToFile:filepath atomically:YES]) {
//            NSLog(@"归档成功");
//        }
//    }else{
//        [_collectbtn setImage:[UIImage imageNamed:@"收藏 d"] forState:UIControlStateNormal];
//    }
//
//    [_zhcollectVc.tableView reloadData];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
