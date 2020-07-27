//
//  ZHsearchTabVc.h
//  微博text
//
//  Created by fu00 on 2020/6/1.
//  Copyright © 2020 fu00. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZHsearchTabVc : UITableViewController
@property (nonatomic,strong) ZHStatus *status;
@property (nonatomic,strong) NSArray *statusArray;
@property (nonatomic,strong) ZHFirstVc *fistVc;
@property (nonatomic,strong) NSMutableArray *cellArray;
@end

NS_ASSUME_NONNULL_END
