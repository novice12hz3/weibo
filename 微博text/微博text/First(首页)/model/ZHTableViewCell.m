//
//  ZHTableViewCell.m
//  微博text
//
//  Created by fu00 on 2020/5/20.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHTableViewCell.h"

@implementation ZHTableViewCell
#pragma mark 自定义tableviewcell


- (instancetype)setUpAllChildView{
    ZHOriginView *originView = [[ZHOriginView alloc]init];
    originView.frame = CGRectMake(0, 0, 414, 175);
    //用户头像
    if (_status.user[@"avatar_hd"]!=nil) {
        _imageString = _status.user[@"avatar_hd"];
    }
//    _imageString = _status.user[@"avatar_hd"];
    UIImage *thuimage = [self getthuimage:_imageString];
    originView.iconView.image = thuimage;
    //用户昵称
    if (_status.user[@"screen_name"]!=nil) {
        originView.nameView.text = _status.user[@"screen_name"];
    }else{
        originView.nameView.text = [NSString stringWithFormat:@"不吃香菜"];
    }
    
    //发布时间
    originView.timeView.text = _status.created_at;
    //正文
    originView.textView.text = _status.text;
    originView.textView.selectable = YES;
    originView.textView.delegate = self;
    originView.textView.dataDetectorTypes =UIDataDetectorTypeLink;//自动识别网址
    //转发数
    originView.sendlabel.text =[NSString stringWithFormat:@"%@",_status.reposts_count];
    //评论数
    originView.commmentlabel.text = [NSString stringWithFormat:@"%@",_status.comments_count];
    //点赞数
    originView.praiselabel.text = [NSString stringWithFormat:@"%@",_status.praise_count];
    //配图
//    originView.picView1.image = _imageArray[0];
//    originView.picView2.image = _imageArray[1];
//    originView.picView2.image = _imageArray[2];
    if (_imageArray) {
            originView.picView1.image = _imageArray[0];
            originView.picView2.image = _imageArray[1];
            originView.picView2.image = _imageArray[2];
    }else{
    
        if (_status.pic_urls.count==0) {
            originView.textView.frame = CGRectMake(0, 50, 414, 200);
            originView.textView.text = _status.text;
        }
        if (_status.pic_urls.count>=1 ) {
            dispatch_queue_t queue = dispatch_queue_create("下载图片1", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                NSDictionary *dict = self.status.pic_urls[0];
                NSString *picstr1 = dict[@"thumbnail_pic"];
                originView.image = [self getthuimage:picstr1];
                dispatch_async(dispatch_get_main_queue(), ^{
                    originView.picView1.image = originView.image;
                    [self.imageArray addObject:originView.picView1.image];
                });
            });
        }
        if (_status.pic_urls.count>=2){
            dispatch_queue_t queue = dispatch_queue_create("下载图片2", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                NSDictionary *dict = self.status.pic_urls[1];
                NSString *picstr2 = dict[@"thumbnail_pic"];
                originView.image = [self getthuimage:picstr2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    originView.picView2.image = originView.image;
                    [self.imageArray addObject:originView.picView2.image];
                });
            });
        }
        if (_status.pic_urls.count>=3) {
            dispatch_queue_t queue = dispatch_queue_create("下载图片3", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                NSDictionary *dict = self.status.pic_urls[2];
                NSString *picstr3 = dict[@"thumbnail_pic"];
                originView.image = [self getthuimage:picstr3];
                dispatch_async(dispatch_get_main_queue(), ^{
                    originView.picView3.image =  originView.image;
                    [self.imageArray addObject:originView.picView3.image];
                });
            });
        }
        
    }
    

    _originView = originView;
    [self addSubview:_originView];
    
//    //监听收藏按钮
    [originView.collectbtn addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    
    
    return self;
}
#pragma mark 根据网络地址请求网络图片
- (UIImage *)getthuimage:(NSString *)imageString{
    //保存图片到沙盒缓存
    NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filename = [imageString lastPathComponent];
    NSString *fullpath = [caches stringByAppendingPathComponent:filename];
    
    UIImage *thuimage = [[UIImage alloc]init];

    NSData *dataimage = [NSData dataWithContentsOfFile:fullpath];
    if (dataimage) {
        thuimage = [UIImage imageWithData:dataimage];
    }else{
        NSURL *imageurl = [NSURL URLWithString:imageString];
        NSData *dataimage = [NSData dataWithContentsOfURL:imageurl];
        thuimage = [UIImage imageWithData:dataimage];

    }

    [dataimage writeToFile:fullpath atomically:YES];
   
    return thuimage;
}
#pragma mark 点击网址跳转方法
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    NSLog(@"%@",URL);
    return YES;
}
#pragma mark 收藏按钮的方法
- (void)collect{
    _originView.iscollect = !_originView.iscollect;
    //先拿出以前储存的收藏赋值给临时收藏数组（实现收藏多个status）
    if (_originView.iscollect ==YES) {
        [_originView.collectbtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    NSString *path =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [path stringByAppendingPathComponent:@"collectStatus.data"];
    NSData *collectData =[NSData dataWithContentsOfFile:filepath];
    NSMutableArray *collecttemp = [NSMutableArray arrayWithCapacity:0];
    collecttemp = [NSKeyedUnarchiver unarchiveObjectWithData:collectData];
    if (collecttemp == nil) {
        collecttemp = [NSMutableArray arrayWithCapacity:0];
    }

    [collecttemp addObject:_status];
    NSArray *collectArray = collecttemp;
    //        归档
    NSData *arrayData  = [NSKeyedArchiver archivedDataWithRootObject:collectArray];
    if ([arrayData writeToFile:filepath atomically:YES]) {
        NSLog(@"归档成功");
    }
        
    }else{
        [_originView.collectbtn setImage:[UIImage imageNamed:@"收藏 d"] forState:UIControlStateNormal];
    }
    
    //通知收藏tableviewcontroll 刷新
    NSNotification *note = [NSNotification notificationWithName:@"刷新收藏" object:_zhcollectVc.tableView];
    [[NSNotificationCenter defaultCenter]postNotification:note];
}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
