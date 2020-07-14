//
//  ZHWriteTextView.h
//  微博text
//
//  Created by fu00 on 2020/5/7.
//  Copyright © 2020 fu00. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHWriteTextView : UITextView
@property(nonatomic,strong) NSString *placeHolder;
@property(nonatomic,strong) UILabel *placeHolderLabel;
@end

NS_ASSUME_NONNULL_END
