//
//  ZHOriginView.m
//  微博text
//
//  Created by fu00 on 2020/5/20.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHOriginView.h"

//#import "Masonry.h"


@implementation ZHOriginView
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        // 添加所有子控件
//        [self setUpAllChildView];
//    }
//    
//    return self;
//}

// 添加所有子控件
- (void)setUpAllChildView
{
    // 头像
    _iconView = [[UIImageView alloc] init];
//    iconView.frame = CGRectMake(0, 0, 50, 50);
    _iconView.layer.masksToBounds = YES;
    _iconView.layer.cornerRadius = 25;
    _iconView.layer.borderWidth = 1;
    _iconView.layer.borderColor = [UIColor grayColor].CGColor;
    [self addSubview:_iconView];
     _iconView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).widthIs(50).heightIs(50);
    
    // 昵称
    _nameView = [[UILabel alloc] init];
    [self addSubview:_nameView];
    _nameView.sd_layout.leftSpaceToView(self, 50).topEqualToView(self).heightIs(25);
    [_nameView setSingleLineAutoResizeWithMaxWidth:200];
//        nameView.sd_layout.autoWidthRatio(0);
    
    // 发布时间
    _timeView = [[UILabel alloc] init];
    _timeView.font = [UIFont systemFontOfSize:10];
    [self addSubview:_timeView];
    _timeView.sd_layout.leftSpaceToView(self, 50).topSpaceToView(self, 25).heightIs(25);
    [_timeView setSingleLineAutoResizeWithMaxWidth:200];

    // 正文
    _textView = [[UITextView alloc] init];
    _textView.editable = NO;
    _textView.scrollEnabled = NO;
    [_textView setFont:[UIFont systemFontOfSize:17]];
    [self addSubview:_textView];
    _textView.sd_layout.topSpaceToView(self, 50).leftEqualToView(self).widthIs(self.size.width).heightIs(100);//heightIs(100)
    
    
    //配图
    _picView1 = [[UIImageView alloc]init];
    _picView1.tag = 1;
    [self addSubview:_picView1];
    _picView1.sd_layout.topSpaceToView(self, 150).leftSpaceToView(self, 20).widthIs(100).heightIs(100);
    _picView2 = [[UIImageView alloc]init];
    _picView2.tag = 2;
    [self addSubview:_picView2];
    _picView2.sd_layout.topSpaceToView(self, 150).leftSpaceToView(self, (self.size.width-40)/3+20).widthIs(100).heightIs(100);
    _picView3 = [[UIImageView alloc]init];
    _picView3.tag = 3;
    [self addSubview:_picView3];
    _picView3.sd_layout.topSpaceToView(self, 150).leftSpaceToView(self, 2*(self.size.width-40)/3+20).widthIs(100).heightIs(100);
    
//    _picView4 = [[UIImageView alloc]init];
//    _picView4.tag = 4;
//    [self addSubview:_picView4];
//    _picView4.sd_layout.topSpaceToView(_picView1, 110).leftSpaceToView(self, 20).widthIs(100).heightIs(100);
//    _picView5 = [[UIImageView alloc]init];
//    _picView5.tag = 5;
//    [self addSubview:_picView5];
//    _picView5.sd_layout.topSpaceToView(_picView1, 110).leftSpaceToView(self, (self.size.width-40)/3+20).widthIs(100).heightIs(100);
//    _picView6 = [[UIImageView alloc]init];
//    _picView6.tag = 6;
//    [self addSubview:_picView6];
//    _picView6.sd_layout.topSpaceToView(_picView1, 110).leftSpaceToView(self, 2*(self.size.width-40)/3+20).widthIs(100).heightIs(100);
//    
//    _picView7 = [[UIImageView alloc]init];
//    _picView7.tag = 7;
//    [self addSubview:_picView7];
//    _picView7.sd_layout.topSpaceToView(_picView4, 110).leftSpaceToView(self, 20).widthIs(100).heightIs(100);
//    _picView8 = [[UIImageView alloc]init];
//    _picView8.tag = 8;
//    [self addSubview:_picView8];
//    _picView8.sd_layout.topSpaceToView(_picView4, 110).leftSpaceToView(self, (self.size.width-40)/3+20).widthIs(100).heightIs(100);
//    _picView9 = [[UIImageView alloc]init];
//    _picView9.tag = 9;
//    [self addSubview:_picView9];
//    _picView9.sd_layout.topSpaceToView(_picView4, 110).leftSpaceToView(self, 2*(self.size.width-40)/3+20).widthIs(100).heightIs(100);
    
    //转发
    _sendView = [[UIImageView alloc]init];
    _sendView.image = [UIImage imageNamed:@"send"];
    [self addSubview:_sendView];
    _sendView.sd_layout.leftSpaceToView(self, 44).topSpaceToView(self, 250).widthIs(25).heightIs(25);
    _sendlabel = [[UILabel alloc]init];
    _sendlabel.frame = CGRectMake(69, 250, 50, 25);
    [self addSubview:_sendlabel];
    _sendlabel.sd_layout.leftSpaceToView(_sendView, 25).topSpaceToView(self, 250).heightIs(25);
    [_sendlabel setSingleLineAutoResizeWithMaxWidth:100];
    
    //评论
    _commentView = [[UIImageView alloc]init];
    _commentView.image = [UIImage imageNamed:@"comment"];
    [self addSubview:_commentView];
    _commentView.sd_layout.leftSpaceToView(self, 44+(self.size.width-88)/3).topSpaceToView(self, 250).widthIs(25).heightIs(25);
    _commentlabel = [[UILabel alloc]init];
    [self addSubview:_commentlabel];
    _commentlabel.sd_layout.leftSpaceToView(_commentView, 25).topSpaceToView(self, 250).heightIs(25);
    [_commentlabel setSingleLineAutoResizeWithMaxWidth:100];
    
    //点赞
    _praiseView = [[UIImageView alloc]init];
    _praiseView.image = [UIImage imageNamed:@"praise"];
    [self addSubview:_praiseView];
    _praiseView.sd_layout.leftSpaceToView(self, 44+2*(self.size.width-88)/3).topSpaceToView(self, 250).widthIs(25).heightIs(25);
    _praiselabel = [[UILabel alloc]init];
    [self addSubview:_praiselabel];
    _praiselabel.sd_layout.leftSpaceToView(_praiseView, 25).topSpaceToView(self, 250).heightIs(25);
    [_praiselabel setSingleLineAutoResizeWithMaxWidth:100];
    //收藏按钮
    _collectbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collectbtn setTitle:@"收藏" forState:UIControlStateNormal];
    [_collectbtn setImage:[UIImage imageNamed:@"收藏 d"] forState:UIControlStateNormal];
    [self addSubview:_collectbtn];
    _collectbtn.sd_layout.topEqualToView(self).rightSpaceToView(self, 20).widthIs(50).heightIs(50);
    _iscollect = NO;
    

    //添加通知接收
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:@"collect" object:self.zhfirstvc];
    
}

#pragma mark 通知方法
- (void)notification:(NSNotification *)noti{
    NSDictionary *dict = [noti userInfo];
    _status =[ZHStatus statuseswithDict:dict];
    
    
}

@end
