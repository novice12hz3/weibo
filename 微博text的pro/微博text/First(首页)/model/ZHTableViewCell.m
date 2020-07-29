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
    dispatch_queue_t queue = dispatch_queue_create("下载图片1", DISPATCH_QUEUE_CONCURRENT);
    
    //控件创建
    UIImageView *iconView = [[UIImageView alloc] init];
    UILabel *nameView = [[UILabel alloc] init];
    UILabel *timeView = [[UILabel alloc] init];
    UILabel *textView = [[UILabel alloc] init];
    UIImageView *sendView = [[UIImageView alloc]init];
    UILabel *sendlabel = [[UILabel alloc]init];
    UIImageView *praiseView = [[UIImageView alloc]init];
    UILabel *praiselabel = [[UILabel alloc]init];
    UIImageView *commentView = [[UIImageView alloc]init];
    UILabel *commentlabel = [[UILabel alloc]init];


    UIButton *collectbtn = [UIButton buttonWithType:UIButtonTypeCustom];

    // 头像
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = 25;
    iconView.layer.borderWidth = 1;
    iconView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:iconView];
    iconView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).widthIs(50).heightIs(50);
    
    if (self.status.user[@"avatar_hd"]!=nil) {
        self.imageString = self.status.user[@"avatar_hd"];
    }
    dispatch_async(queue, ^{
        UIImage *thuimage = [self getthuimage:self.imageString];
        dispatch_async(dispatch_get_main_queue(), ^{
            iconView.image = thuimage;
        });
    });
    //发布时间
    timeView.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:timeView];
    timeView.sd_layout.leftSpaceToView(iconView, 0).topSpaceToView(nameView, 0).heightIs(25);
    [timeView setSingleLineAutoResizeWithMaxWidth:200];
    timeView.text = self.status.created_at;
    //正文
    [textView setFont:[UIFont systemFontOfSize:17]];
    [self.contentView addSubview:textView];
    textView.sd_layout.topSpaceToView(iconView, 0).leftEqualToView(self.contentView).widthIs(self.contentView.size.width).autoHeightRatio(0).maxHeightIs(200);
    textView.text = self.status.text;
    [textView updateLayout];
    _textView = textView;
    self.Height = 0;
    //用户昵称
    [self.contentView addSubview:nameView];
    nameView.sd_layout.leftSpaceToView(iconView, 0).topEqualToView(self.contentView).heightIs(25);
    [nameView setSingleLineAutoResizeWithMaxWidth:200];
        if (self.status.user[@"screen_name"]!=nil) {
            nameView.text = self.status.user[@"screen_name"];
        }else{
            nameView.text = [NSString stringWithFormat:@"不吃香菜"];
        }
        [nameView updateLayout];
    
    //配图
     NSInteger j = 0;
     NSInteger imageCount = self.contentView.subviews.count-4;//已添加的图片数
    if (_imageArray) {
        while (imageCount< _imageArray.count) {
            NSInteger i = (imageCount+1)%3;
            if (i==0) {i = 3;}
            if (imageCount<3) {
                j=1;
            }else{
                if(imageCount<6){j=2;}else{j=3;}
            }
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = _imageArray[imageCount];
            [self.contentView addSubview:imageView];
            imageView.sd_layout.leftSpaceToView(self.contentView, 45+(i-1)*110).topSpaceToView(textView,20+ 110*(j-1)).heightIs(100).widthIs(100);
            imageCount+= 1;
            if (imageCount == _imageArray.count) {
                self.lastImageView = imageView;
            }
        }
    }else{
            while (imageCount < self.status.pic_urls.count) {
                NSInteger i = (imageCount+1)%3;
                if (i==0) {
                    i = 3;
                }
                if (imageCount<3) {
                    j=1;
                }else{
                    if(imageCount<6){j=2;}else{j=3;}
                }
                UIImageView *imageView = [[UIImageView alloc]init];
                [self.contentView addSubview:imageView];
                imageView.sd_layout.leftSpaceToView(self.contentView, 45+(i-1)*110).topSpaceToView(textView, 110*(j-1)).heightIs(100).widthIs(100);
                NSString *picstr = self.status.pic_urls[imageCount];
                dispatch_async(queue, ^{
                    UIImage *image = [[UIImage alloc]init];
                    image = [self getthuimage:picstr];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        imageView.image = image;
                    });
                });
                
                imageCount+= 1;
                if (imageCount == _status.pic_urls.count) {
                    self.lastImageView = imageView;
                }
                if (imageCount == 9) {break;}
            }
//        }
    
    }
//    视频
    if (self.status.videoURLs.length == 0) {
    }else{
        
        NSURL *videoURL = [NSURL URLWithString:self.status.videoURLs];
        self.player = [[AVPlayer alloc]initWithURL:videoURL];
        self.avPlayerVC = [[AVPlayerViewController alloc]init];
        self.avPlayerVC.player = self.player;
        [self.contentView addSubview:self.avPlayerVC.view];
        self.avPlayerVC.view.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(textView, 20).heightIs(200).widthIs(414);
        self.lastImageView = self.avPlayerVC.view;
//        self.avPlayerVC.showsPlaybackControls = YES;
        self.Height = 220;
    }
    
    //转发数
    sendView.image = [UIImage imageNamed:@"send"];
    [self.contentView addSubview:sendView];
    sendView.sd_layout.leftSpaceToView(self.contentView, 44).topSpaceToView(self.lastImageView, 20).widthIs(25).heightIs(25);
    [self.contentView addSubview:sendlabel];
    sendlabel.sd_layout.leftSpaceToView(sendView, 0).topSpaceToView(self.lastImageView, 20).heightIs(25);
    [sendlabel setSingleLineAutoResizeWithMaxWidth:100];
    sendlabel.text =[NSString stringWithFormat:@"%@",self.status.reposts_count];
    //评论数
    commentView.image = [UIImage imageNamed:@"comment"];
    [self.contentView addSubview:commentView];
    commentView.sd_layout.leftSpaceToView(self.contentView, 44+(self.contentView.size.width-88)/3).topSpaceToView(self.lastImageView, 20).widthIs(25).heightIs(25);
    [self.contentView addSubview:commentlabel];
    commentlabel.sd_layout.leftSpaceToView(commentView, 0).topSpaceToView(self.lastImageView, 20).heightIs(25);
    [commentlabel setSingleLineAutoResizeWithMaxWidth:100];
    commentlabel.text = [NSString stringWithFormat:@"%@",self.status.comments_count];
    //点赞数
    praiseView.image = [UIImage imageNamed:@"praise"];
    [self.contentView addSubview:praiseView];
    praiseView.sd_layout.leftSpaceToView(self.contentView, 44+2*(self.contentView.size.width-88)/3).topSpaceToView(self.lastImageView, 20).widthIs(25).heightIs(25);
    [self.contentView addSubview:praiselabel];
    praiselabel.sd_layout.leftSpaceToView(praiseView, 0).topSpaceToView(self.lastImageView, 20).heightIs(25);
    [praiselabel setSingleLineAutoResizeWithMaxWidth:100];
    praiselabel.text = [NSString stringWithFormat:@"%@",self.status.praise_count];
    
    
    if (self.status.pic_urls == nil && self.status.videoURLs.length == 0&&_imageArray == nil) {//没图的情况下
        sendView.sd_layout.leftSpaceToView(self.contentView, 44).topSpaceToView(textView, 20).widthIs(25).heightIs(25);
        sendlabel.sd_layout.leftSpaceToView(sendView, 0).topSpaceToView(textView, 20).heightIs(25);
        commentView.sd_layout.leftSpaceToView(self.contentView, 44+(self.contentView.size.width-88)/3).topSpaceToView(textView, 20).widthIs(25).heightIs(25);
        commentlabel.sd_layout.leftSpaceToView(commentView, 0).topSpaceToView(textView, 20).heightIs(25);
        praiseView.sd_layout.leftSpaceToView(self.contentView, 44+2*(self.contentView.size.width-88)/3).topSpaceToView(textView, 20).widthIs(25).heightIs(25);
        praiselabel.sd_layout.leftSpaceToView(praiseView, 0).topSpaceToView(textView, 20).heightIs(25);
    }
    
//    //监听收藏按钮
    [collectbtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectbtn setImage:[UIImage imageNamed:@"收藏 d"] forState:UIControlStateNormal];
    [self.contentView addSubview:collectbtn];
    collectbtn.sd_layout.topEqualToView(self.contentView).rightSpaceToView(self.contentView, 20).widthIs(50).heightIs(50);
//    iscollect = NO;
    [collectbtn addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    self.collectbtn = collectbtn;
    
    [self setupAutoHeightWithBottomView:sendView bottomMargin:10];
    
    self.Height = self.Height+textView.height+(CGFloat)j*110+75+25;
    
    return self;
}
#pragma mark 根据网络地址请求网络图片
- (UIImage *)getthuimage:(NSString *)imageString{
    //保存图片到沙盒缓存
    NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filename = [imageString lastPathComponent];
    NSString *fullpath = [caches stringByAppendingPathComponent:filename];
    
    __block UIImage *thuimage = [[UIImage alloc]init];

    NSData *dataimage = [NSData dataWithContentsOfFile:fullpath];
    
    if (dataimage) {
        thuimage = [UIImage imageWithData:dataimage];
    }else{
            NSURL *imageurl = [NSURL URLWithString:imageString];
            NSData *dataimage = [NSData dataWithContentsOfURL:imageurl];
            thuimage = [UIImage imageWithData:dataimage];
            [dataimage writeToFile:fullpath atomically:YES];
    }

   
    return thuimage;

}
#pragma mark 点击网址跳转方法
//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
//    NSLog(@"%@",URL);
//    return YES;
//}
#pragma mark 收藏按钮的方法
- (void)collect{
    _iscollect = !_iscollect;
    //先拿出以前储存的收藏赋值给临时收藏数组（实现收藏多个status）
    if (_iscollect == YES) {
        [_collectbtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
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
        [_collectbtn setImage:[UIImage imageNamed:@"收藏 d"] forState:UIControlStateNormal];
    }
    
    //通知收藏tableviewcontroll 刷新
    NSNotification *note = [NSNotification notificationWithName:@"刷新收藏" object:_zhcollectVc.tableView];
    [[NSNotificationCenter defaultCenter]postNotification:note];
}

#pragma mark 监听
//- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController;{
//    [playerViewController.player play];
//}
//



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
