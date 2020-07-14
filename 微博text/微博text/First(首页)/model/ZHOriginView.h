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
NS_ASSUME_NONNULL_BEGIN
@class ZHcollectVc;
@interface ZHOriginView : UIView

@property (nonatomic, weak) UIImageView *iconView;// 头像
@property (nonatomic, weak) UILabel *nameView;// 昵称
@property (nonatomic, weak) UILabel *timeView;// 发布时间
@property (nonatomic, weak) UITextView *textView;// 正文
@property (nonatomic, weak) UIImageView *sendvView;//转发
@property (nonatomic, weak) UILabel *sendlabel;
@property (nonatomic, weak) UIImageView *commentView;//评论
@property (nonatomic, weak) UILabel *commmentlabel;
@property (nonatomic, weak) UIImageView *praiseView;//点赞
@property (nonatomic, weak) UILabel *praiselabel;
@property (nonatomic, weak) UIImageView *picView1;//配图1
@property (nonatomic, weak) UIImageView *picView2;//配图2
@property (nonatomic, weak) UIImageView *picView3;//配图3
@property (nonatomic, weak) UIButton *collectbtn;//收藏按钮
@property (nonatomic, strong) NSArray *collectArray;//收藏数组
@property (nonatomic, strong) NSMutableArray *collecttemp;//临时收藏数组
@property (nonatomic, strong) ZHFirstVc *zhfirstvc;
@property (nonatomic, strong) ZHcollectVc *zhcollectVc;
@property (nonatomic, strong) ZHStatus *status;
@property (nonatomic, strong) NSDictionary *statusdict;//储存当前status数据的字典
@property BOOL iscollect;
@end

 

NS_ASSUME_NONNULL_END
