//
//  ZHTableViewCell.h
//  微博text
//
//  Created by fu00 on 2020/5/20.
//  Copyright © 2020 fu00. All rights reserved.

#import <UIKit/UIKit.h>
#import "ZHStatus.h"
#import "ZHOriginView.h"
#import "ZHcollectVc.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN
@class ZHOriginView;
@class ZHcollectVc;
@interface ZHTableViewCell : UITableViewCell<UITextViewDelegate,AVPlayerViewControllerDelegate>

@property(nonatomic,strong) ZHStatus *status;
@property(nonatomic,strong) NSString *imageString;
@property(nonatomic,strong) ZHOriginView *originView;
@property(nonatomic,strong) ZHcollectVc  *zhcollectVc;
@property(nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) UIView *lastImageView;
@property (nonatomic,strong) UILabel *textView;
@property (nonatomic,assign) CGFloat Height;
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerViewController *avPlayerVC;
@property BOOL iscollect; //收藏状态
@property (nonatomic, strong) UIButton *collectbtn;//收藏按钮
- (instancetype)setUpAllChildView;
@end

NS_ASSUME_NONNULL_END
