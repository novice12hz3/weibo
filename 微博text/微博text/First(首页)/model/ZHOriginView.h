//
//  ZHOriginView.h
//  微博text
//
//  Created by fu00 on 2020/5/20.
//  Copyright © 2020 fu00. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHFirstVc.h"
#import "ZHcollectVc.h"
#import "SDAutoLayout.h"
NS_ASSUME_NONNULL_BEGIN
@class ZHcollectVc;
@interface ZHOriginView : UIView

@property (nonatomic, strong) UIImageView *iconView;// 头像
@property (nonatomic, strong) UILabel *nameView;// 昵称
@property (nonatomic, strong) UILabel *timeView;// 发布时间
@property (nonatomic, strong) UITextView *textView;// 正文
@property (nonatomic, strong) UIImageView *sendView;//转发
@property (nonatomic, strong) UILabel *sendlabel;
@property (nonatomic, strong) UIImageView *commentView;//评论
@property (nonatomic, strong) UILabel *commentlabel;
@property (nonatomic, strong) UIImageView *praiseView;//点赞
@property (nonatomic, strong) UILabel *praiselabel;
@property (nonatomic, strong) UIImageView *picView1;//配图1
@property (nonatomic, strong) UIImageView *picView2;//配图2
@property (nonatomic, strong) UIImageView *picView3;//配图3
@property (nonatomic, strong) UIImageView *picView4;//配图4
@property (nonatomic, strong) UIImageView *picView5;//配图5
@property (nonatomic, strong) UIImageView *picView6;//配图6
@property (nonatomic, strong) UIImageView *picView7;//配图7
@property (nonatomic, strong) UIImageView *picView8;//配图8
@property (nonatomic, strong) UIImageView *picView9;//配图9
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIButton *collectbtn;//收藏按钮
@property (nonatomic, strong) NSArray *collectArray;//收藏数组
@property (nonatomic, strong) NSMutableArray *collecttemp;//临时收藏数组
@property (nonatomic, strong) ZHFirstVc *zhfirstvc;
@property (nonatomic, strong) ZHcollectVc *zhcollectVc;
@property (nonatomic, strong) ZHStatus *status;
@property (nonatomic, strong) NSDictionary *statusdict;//储存当前status数据的字典
@property BOOL iscollect;
- (void)setUpAllChildView;
@end

 

NS_ASSUME_NONNULL_END
