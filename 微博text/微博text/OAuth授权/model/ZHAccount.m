//
//  ZHAccount.m
//  微博text
//
//  Created by fu00 on 2020/5/15.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHAccount.h"

@implementation ZHAccount
+ (instancetype)AccountWithDict:(NSDictionary *)dict{
    ZHAccount *account = [[self alloc]init];

    [account setValuesForKeysWithDictionary:dict];
    return account;
}

- (void)setExpires_in:(NSString *)expires_in{
    _expires_in = expires_in;
}

- (void)endcodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_access_token forKey:@"token"];
    [aCoder encodeObject:_expires_in forKey:@"exoires"];
    [aCoder encodeObject:_uid forKey:@"uid"];
//    [aCoder encodeObject:_expires_date forKey:<#(nonnull NSString *)#>]
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        _access_token = [aDecoder decodeObjectForKey:@"token"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _expires_in = [aDecoder decodeObjectForKey:@"exoires"];
    }
    return self;
}
@end
