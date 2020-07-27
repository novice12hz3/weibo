//
//  ZHTableViewCell.h
//  微博text
//
//  Created by fu00 on 2020/5/20.
//  Copyright © 2020 fu00. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHStatus.h"
#import "ZHOriginView.h"
#import "ZHcollectVc.h"
NS_ASSUME_NONNULL_BEGIN
@class ZHOriginView;
@class ZHcollectVc;
@interface ZHTableViewCell : UITableViewCell<UITextViewDelegate>

@property(nonatomic,strong) ZHStatus *status;
@property(nonatomic,strong) NSString *imageString;
@property(nonatomic,strong) ZHOriginView *originView;
@property(nonatomic,strong) ZHcollectVc  *zhcollectVc;
@property(nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) UIImageView *lastImageView;
@property (nonatomic,strong) UILabel *textView;
@property (nonatomic,assign) CGFloat Height;
- (instancetype)setUpAllChildView;
@end

NS_ASSUME_NONNULL_END
