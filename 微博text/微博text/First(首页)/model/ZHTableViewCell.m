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
    [_originView setUpAllChildView];
    
    //cell的高度自适应
//    [self.contentView sd_addSubviews:@[_originView.nameView,_originView.image]];
    //用户头像
    if (_status.user[@"avatar_hd"]!=nil) {
        _imageString = _status.user[@"avatar_hd"];
    }
//    _imageString = _status.user[@"avatar_hd"];
    UIImage *thuimage = [self getthuimage:_imageString];
    _originView.iconView.image = thuimage;
    //用户昵称
    if (_status.user[@"screen_name"]!=nil) {
        _originView.nameView.text = _status.user[@"screen_name"];
    }else{
        _originView.nameView.text = [NSString stringWithFormat:@"不吃香菜"];
    }
    [_originView.nameView updateLayout];
    //发布时间
    _originView.timeView.text = _status.created_at;
    //正文
    _originView.textView.text = _status.text;
    _originView.textView.selectable = YES;
    _originView.textView.delegate = self;
    _originView.textView.dataDetectorTypes =UIDataDetectorTypeLink;//自动识别网址
    //转发数
    _originView.sendlabel.text =[NSString stringWithFormat:@"%@",_status.reposts_count];
    //评论数
    _originView.commentlabel.text = [NSString stringWithFormat:@"%@",_status.comments_count];
    //点赞数
    _originView.praiselabel.text = [NSString stringWithFormat:@"%@",_status.praise_count];
    //配图
    if (_imageArray) {
            _originView.picView1.image = _imageArray[0];
            _originView.picView2.image = _imageArray[1];
            _originView.picView3.image = _imageArray[2];
        if (_imageArray.count>3) {
            _originView.picView4.image = _imageArray[3];
            _originView.picView5.image = _imageArray[4];
            _originView.picView6.image = _imageArray[5];}
        if (_imageArray.count>6) {
            _originView.picView7.image = _imageArray[6];
            _originView.picView8.image = _imageArray[7];
            _originView.picView9.image = _imageArray[8];}
        
        
    }else{
    
        if (_status.pic_urls.count==0) {
            _originView.textView.frame = CGRectMake(0, 50, 414, 200);
            _originView.textView.text = _status.text;
        }
        if (_status.pic_urls.count>=1 ) {
            dispatch_queue_t queue = dispatch_queue_create("下载图片1", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                NSDictionary *dict = self.status.pic_urls[0];
                NSString *picstr1 = dict[@"thumbnail_pic"];
                self.originView.image = [self getthuimage:picstr1];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.originView.picView1.image = self.originView.image;
                    [self.imageArray addObject:self.originView.picView1.image];
                });
            });
        }
        if (_status.pic_urls.count>=2){
            dispatch_queue_t queue = dispatch_queue_create("下载图片2", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                NSDictionary *dict = self.status.pic_urls[1];
                NSString *picstr2 = dict[@"thumbnail_pic"];
                self.originView.image = [self getthuimage:picstr2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.originView.picView2.image = self.originView.image;
                    [self.imageArray addObject:self.originView.picView2.image];
                });
            });
        }
        
        if (_status.pic_urls.count>=3) {
            dispatch_queue_t queue = dispatch_queue_create("下载图片3", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                NSDictionary *dict = self.status.pic_urls[2];
                NSString *picstr3 = dict[@"thumbnail_pic"];
                self.originView.image = [self getthuimage:picstr3];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.originView.picView3.image =  self.originView.image;
                    [self.imageArray addObject:self.originView.picView3.image];
                });
            });
//            if (_status.pic_urls.count <4) {
//                for (UIView *subview in self.subviews) {
//                    if (subview.tag >3) {[subview removeFromSuperview];} }
//            }
        }
//
//        if (_status.pic_urls.count>=4) {
//            dispatch_queue_t queue = dispatch_queue_create("下载图片4", DISPATCH_QUEUE_CONCURRENT);
//            dispatch_async(queue, ^{
//                NSDictionary *dict = self.status.pic_urls[3];
//                NSString *picstr4 = dict[@"thumbnail_pic"];
//                self.originView.image = [self getthuimage:picstr4];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self.originView.picView4.image =  self.originView.image;
//                    [self.imageArray addObject:self.originView.picView4.image];
//                });
//            });
//                           }
//
//        if (_status.pic_urls.count>=5) {
//            dispatch_queue_t queue = dispatch_queue_create("下载图片4", DISPATCH_QUEUE_CONCURRENT);
//            dispatch_async(queue, ^{
//                NSDictionary *dict = self.status.pic_urls[4];
//                NSString *picstr5 = dict[@"thumbnail_pic"];
//                self.originView.image = [self getthuimage:picstr5];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self.originView.picView5.image =  self.originView.image;
//                    [self.imageArray addObject:self.originView.picView5.image];
//                });
//            });
//        }
//
//        if (_status.pic_urls.count>=6) {
//            dispatch_queue_t queue = dispatch_queue_create("下载图片4", DISPATCH_QUEUE_CONCURRENT);
//            dispatch_async(queue, ^{
//                NSDictionary *dict = self.status.pic_urls[5];
//                NSString *picstr6 = dict[@"thumbnail_pic"];
//                self.originView.image = [self getthuimage:picstr6];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self.originView.picView6.image =  self.originView.image;
//                    [self.imageArray addObject:self.originView.picView6.image];
//                });
//            });
//        }
//
//        if (_status.pic_urls.count <7) {
//            for (UIView *subview in self.subviews) {
//                if (subview.tag >6) {[subview removeFromSuperview];} }
//        }
//
//        if (_status.pic_urls.count>=7) {
//            dispatch_queue_t queue = dispatch_queue_create("下载图片7", DISPATCH_QUEUE_CONCURRENT);
//            dispatch_async(queue, ^{
//                NSDictionary *dict = self.status.pic_urls[6];
//                NSString *picstr7 = dict[@"thumbnail_pic"];
//                self.originView.image = [self getthuimage:picstr7];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self.originView.picView7.image =  self.originView.image;
//                    [self.imageArray addObject:self.originView.picView7.image];
//                });
//            });
//        }
//
//        if (_status.pic_urls.count>=8) {
//            dispatch_queue_t queue = dispatch_queue_create("下载图片4", DISPATCH_QUEUE_CONCURRENT);
//            dispatch_async(queue, ^{
//                NSDictionary *dict = self.status.pic_urls[7];
//                NSString *picstr8 = dict[@"thumbnail_pic"];
//                self.originView.image = [self getthuimage:picstr8];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self.originView.picView8.image =  self.originView.image;
//                    [self.imageArray addObject:self.originView.picView8.image];
//                });
//            });
//        }
//
//        if (_status.pic_urls.count>=9) {
//            dispatch_queue_t queue = dispatch_queue_create("下载图片9", DISPATCH_QUEUE_CONCURRENT);
//            dispatch_async(queue, ^{
//                NSDictionary *dict = self.status.pic_urls[8];
//                NSString *picstr9 = dict[@"thumbnail_pic"];
//                self.originView.image = [self getthuimage:picstr9];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self.originView.picView9.image =  self.originView.image;
//                    [self.imageArray addObject:self.originView.picView9.image];
//                });
//            });
//        }
        
        
        
    }
    

        [self addSubview:self.originView];
    
//    //监听收藏按钮
    [self.originView.collectbtn addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    
    
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
