//
//  ZHStatus.m
//  微博text
//
//  Created by fu00 on 2020/5/15.
//  Copyright © 2020 fu00. All rights reserved.
//
#import "ZHStatus.h"

@implementation ZHStatus
+(instancetype)statuseswithDict:(NSDictionary *)dict{
    NSDictionary *from = dict[@"from"];//该发布者信息
    NSDictionary *extend = from[@"extend"];//user
    ZHStatus *status = [[ZHStatus alloc]init];
    status.user = extend;
    status.text = dict[@"content"];
    if ([dict[@"imageUrls"] isEqual:[NSNull null]]) {
        status.pic_urls = nil;
    }else{
    status.pic_urls = dict[@"imageUrls"];
    }
//    [status setValuesForKeysWithDictionary:dict];
    status.created_at = dict[@"pDate"];
    NSString *reposts_count = dict[@"shareCount"];
    status.reposts_count =reposts_count;
    NSString *comments_count = dict[@"commentCount"];
    status.comments_count = comments_count;
    NSString *praise_count = dict[@"likeCount"];
    status.praise_count = praise_count;
    status.icon = status.thumbnail_pic;
    if ([dict[@"videoUrls"] isEqual:[NSNull null]]) {
        status.videoURLs = [NSString stringWithFormat:@""];
    }else{
        NSArray *Array = dict[@"videoUrls"];
        status.videoURLs = Array[0];
        
    }
  
    return status;
}
#pragma mark 将没赋值的属性跳过
- (void)setValue:(id)value forUndefinedKey:( NSString *)key{
//    NSLog(@"%@",key);

}

#pragma mark nscoding
//保存时调用
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.created_at forKey:@"created_at"];
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.pic_urls forKey:@"pic_urls"];
    [aCoder encodeObject:self.thumbnail_pic forKey:@"thumbnail_pic"];
    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.comments_count forKey:@"comments_count"];
    [aCoder encodeObject:self.reposts_count forKey:@"reposts_count"];
    [aCoder encodeObject:self.praise_count forKey:@"praise_count"];
}
//取出时调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.created_at = [aDecoder decodeObjectForKey:@"created_at"];
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.pic_urls = [aDecoder decodeObjectForKey:@"pic_urls"];
        self.thumbnail_pic = [aDecoder decodeObjectForKey:@"thumbnail_pic"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
        self.comments_count = [aDecoder decodeObjectForKey:@"comments_count"];
        self.reposts_count = [aDecoder decodeObjectForKey: @"reposts_count"];
        self.praise_count = [aDecoder decodeObjectForKey:@"praise_count"];
    }
    return self;
}
@end

