//
//  ZHAccount.h
//  微博text
//
//  Created by fu00 on 2020/5/15.
//  Copyright © 2020 fu00. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHAccount : NSObject
@property(nonatomic,copy)NSString *access_token;
@property(nonatomic,copy)NSString *expires_in;
@property(nonatomic,copy)NSString *remind_in;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *isRealName;
+(instancetype)AccountWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
