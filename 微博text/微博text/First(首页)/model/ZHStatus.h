//
//  ZHStatus.h
//  微博text
//
//  Created by fu00 on 2020/5/15.
//  Copyright © 2020 fu00. All rights reserved.
//
//created_at    string  微博创建时间
//idstr string  字符串型的微博ID
//text  string  微博信息内容
//source    string  微博来源
//user  object  微博作者的用户信息字段 详细
//retweeted_status  object  被转发的原微博信息字段，当该微博为转发微博时返回
//reposts_count int 转发数
//comments_count    int 评论数
//attitudes_count       int 表态数
//pic_urls  配图数组
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
///Users/fu00/Desktop/微博text/微博text/First(首页)/model/ZHWeiBo.h
@interface ZHStatus : NSObject<NSCoding>
@property(nonatomic,copy) NSString *created_at;//创建时间
@property(nonatomic,copy) NSString *text;//微博内容
@property(nonatomic,copy) NSArray *pic_urls;//配图字典
@property(nonatomic,copy) NSString *thumbnail_pic;//略缩图片地址
@property(nonatomic,copy) NSString *original_pic;//略缩图片地址
@property(nonatomic,copy) NSDictionary *user;//使用者
@property(nonatomic,assign) NSString *comments_count;//评论数
@property(nonatomic,assign) NSString *reposts_count;//转发数
@property(nonatomic,assign) NSString *praise_count;//点赞数


+ (instancetype)statuseswithDict:(NSDictionary *)dict;
- (void)setValue:(id)value forUndefinedKey:( NSString *)key;
@end

NS_ASSUME_NONNULL_END
