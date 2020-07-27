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
// 添加所有子控件
- (void)setUpAllChildView
{
    

    
    //控件创建
    self.iconView = [[UIImageView alloc] init];
    self.nameView = [[UILabel alloc] init];
    self.timeView = [[UILabel alloc] init];
    self.textView = [[UITextView alloc] init];
    self.picView1 = [[UIImageView alloc]init];
    self.picView2 = [[UIImageView alloc]init];
    self.picView3 = [[UIImageView alloc]init];
    self.sendView = [[UIImageView alloc]init];
    self.sendlabel = [[UILabel alloc]init];
    self.praiseView = [[UIImageView alloc]init];
    self.praiselabel = [[UILabel alloc]init];
    self.collectbtn = [UIButton buttonWithType:UIButtonTypeCustom];

    
        // 头像
        //    iconView.frame = CGRectMake(0, 0, 50, 50);
        self.iconView.layer.masksToBounds = YES;
        self.iconView.layer.cornerRadius = 25;
        self.iconView.layer.borderWidth = 1;
        self.iconView.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:self.iconView];
        self.iconView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).widthIs(50).heightIs(50);
        
        // 昵称
    
        [self addSubview:self.nameView];
        self.nameView.sd_layout.leftSpaceToView(self.iconView, 0).topEqualToView(self).heightIs(25);
        [self.nameView setSingleLineAutoResizeWithMaxWidth:200];
    
        // 发布时间
    
        self.timeView.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.timeView];
        self.timeView.sd_layout.leftSpaceToView(self.iconView, 0).topSpaceToView(self.nameView, 0).heightIs(25);
        [self.timeView setSingleLineAutoResizeWithMaxWidth:200];
        
        // 正文
        self.textView.editable = NO;
        self.textView.scrollEnabled = NO;
        [self.textView setFont:[UIFont systemFontOfSize:17]];
        [self addSubview:self.textView];
        self.textView.sd_layout.topSpaceToView(self.iconView, 0).leftEqualToView(self).widthIs(self.size.width).heightIs(100);//heightIs(100)
        
    
//        self.picView1.tag = 1;
//        [self addSubview:self.picView1];
//        self.picView1.sd_layout.topSpaceToView(self.textView, 0).leftSpaceToView(self, 20).widthIs(100).heightIs(100);
//        self.picView2.tag = 2;
//        [self addSubview:self.picView2];
//
//        self.picView2.sd_layout.topSpaceToView(self.textView, 0).leftSpaceToView(self, (self.size.width-40)/3+20).widthIs(100).heightIs(100);
//        self.picView3.tag = 3;
//        [self addSubview:self.picView3];
//        self.picView3.sd_layout.topSpaceToView(self.textView, 0).leftSpaceToView(self, 2*(self.size.width-40)/3+20).widthIs(100).heightIs(100);
//
//    self.picView1.backgroundColor = [UIColor blueColor];
//    self.picView2.backgroundColor = [UIColor blueColor];
//    self.picView3.backgroundColor = [UIColor blueColor];
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
        self.sendView.image = [UIImage imageNamed:@"send"];
        [self addSubview:self.sendView];
        self.sendView.sd_layout.leftSpaceToView(self, 44).topSpaceToView(self, 250).widthIs(25).heightIs(25);
        self.sendlabel.frame = CGRectMake(69, 250, 50, 25);
        [self addSubview:self.sendlabel];
        self.sendlabel.sd_layout.leftSpaceToView(self.sendView, 25).topSpaceToView(self, 250).heightIs(25);
        [self.sendlabel setSingleLineAutoResizeWithMaxWidth:100];
        
        //评论
        self.commentView = [[UIImageView alloc]init];
        self.commentView.image = [UIImage imageNamed:@"comment"];
        [self addSubview:self.commentView];
        self.commentView.sd_layout.leftSpaceToView(self, 44+(self.size.width-88)/3).topSpaceToView(self, 250).widthIs(25).heightIs(25);
        self.commentlabel = [[UILabel alloc]init];
        [self addSubview:self.commentlabel];
        self.commentlabel.sd_layout.leftSpaceToView(self.commentView, 25).topSpaceToView(self, 260).heightIs(25);
        [self.commentlabel setSingleLineAutoResizeWithMaxWidth:100];
        
        //点赞
        self.praiseView.image = [UIImage imageNamed:@"praise"];
        [self addSubview:self.praiseView];
        self.praiseView.sd_layout.leftSpaceToView(self, 44+2*(self.size.width-88)/3).topSpaceToView(self, 250).widthIs(25).heightIs(25);
        [self addSubview:self.praiselabel];
        self.praiselabel.sd_layout.leftSpaceToView(self.praiseView, 25).topSpaceToView(self, 250).heightIs(25);
        [self.praiselabel setSingleLineAutoResizeWithMaxWidth:100];
        //收藏按钮
        [self.collectbtn setTitle:@"收藏" forState:UIControlStateNormal];
        [self.collectbtn setImage:[UIImage imageNamed:@"收藏 d"] forState:UIControlStateNormal];
        [self addSubview:self.collectbtn];
        self.collectbtn.sd_layout.topEqualToView(self).rightSpaceToView(self, 20).widthIs(50).heightIs(50);
        self.iscollect = NO;
    

    //添加通知接收
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:@"collect" object:self.zhfirstvc];
    
    
}
//#pragma mark 根据网络地址请求网络图片
//- (UIImage *)getthuimage:(NSString *)imageString{
//    //保存图片到沙盒缓存
//    NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    NSString *filename = [imageString lastPathComponent];
//    NSString *fullpath = [caches stringByAppendingPathComponent:filename];
//    
//    __block UIImage *thuimage = [[UIImage alloc]init];
//    
//    NSData *dataimage = [NSData dataWithContentsOfFile:fullpath];
//    
//    if (dataimage) {
//        thuimage = [UIImage imageWithData:dataimage];
//    }else{
//        NSURL *imageurl = [NSURL URLWithString:imageString];
//        NSData *dataimage = [NSData dataWithContentsOfURL:imageurl];
//        thuimage = [UIImage imageWithData:dataimage];
//        
//    }
//    
//    [dataimage writeToFile:fullpath atomically:YES];
//    return thuimage;
//    
//}
#pragma mark 通知方法
- (void)notification:(NSNotification *)noti{
    NSDictionary *dict = [noti userInfo];
    _status =[ZHStatus statuseswithDict:dict];
    
    
}

@end
