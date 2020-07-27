//
//  ZHSearchVc.h
//  微博text
//
//  Created by fu00 on 2020/7/26.
//  Copyright © 2020 fu00. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHSearchVc : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UINavigationController *nav;
@end

NS_ASSUME_NONNULL_END
