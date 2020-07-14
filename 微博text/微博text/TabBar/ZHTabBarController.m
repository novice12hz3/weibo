//
//  ZHTabBarController.m
//  微博text
//
//  Created by fu00 on 2020/5/6.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHTabBarController.h"
#import "ZHFirstVc.h"
#import "ZHcollectVc.h"
#import "ZHMeVc.h"
#import "ZHHisitoryVc.h"
@interface ZHTabBarController ()
- (void)getChildrenvc:(UIViewController *)vc image:(UIImage *)image selectedimage:(UIImage *)selectedimage title:(NSString *)title;
@end

@implementation ZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //子控制器
    //首页
    ZHFirstVc *first = [[ZHFirstVc alloc]init];
    [self getChildrenvc:first image:[UIImage imageNamed:@"first"] selectedimage:[UIImage imageNamed:@"first d"] title:@"首页"];
    
    //消息
    ZHcollectVc *collect = [[ZHcollectVc alloc]init];
    [self getChildrenvc:collect image:[UIImage imageNamed:@"收藏"] selectedimage:[UIImage imageNamed:@"收藏"] title:@"收藏"];
    
    //浏览历史
    ZHHisitoryVc *zhhistoryvc = [[ZHHisitoryVc alloc]init];
    [self getChildrenvc:zhhistoryvc image:[UIImage imageNamed:@"历史"] selectedimage:[UIImage imageNamed:@"历史"] title:@"浏览历史"];
    
    //个人主页
    ZHMeVc *me = [[ZHMeVc alloc]init];
    [self getChildrenvc:me image:[UIImage imageNamed:@"me"] selectedimage:[UIImage imageNamed:@"me d"] title:@"我"];

    
}
- (void)getChildrenvc:(UIViewController *)vc image:(UIImage *)image selectedimage:(UIImage *)selectedimage title:(NSString *)title{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedimage;
    [self addChildViewController:vc];
    
    //添加导航控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    nav.navigationItem.
    [self addChildViewController:nav];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
