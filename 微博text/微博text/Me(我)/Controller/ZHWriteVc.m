//
//  ZHWriteVc.m
//  微博text
//
//  Created by fu00 on 2020/5/7.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHWriteVc.h"
#import "ZHWriteTextView.h"
@interface ZHWriteVc ()<UITextViewDelegate>
@property(nonatomic,strong) ZHWriteTextView *textview;
@property(nonatomic,strong) UIBarButtonItem *rightItem;
-(void)HidenPlaceHolder;
@end

@implementation ZHWriteVc



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发微博";
    //导航条上左按钮
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn sizeToFit];
    [leftbtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    
    //导航条上右按钮
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [rightbtn sizeToFit];
    [rightbtn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    _rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    _rightItem.enabled = NO;//一开始是不能发送的
    self.navigationItem.rightBarButtonItem = _rightItem;
    
    [self setupTextView];
    
    
    
}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [_textview becomeFirstResponder];
//}




#pragma mask 导航条的按钮方法
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)compose{
    NSLog(@"%@",self.textview.text);
    NSNotification *note = [NSNotification notificationWithName:@"发送" object:self userInfo:@{@"text":[NSString stringWithFormat:@"%@",self.textview.text]}];
    [[NSNotificationCenter defaultCenter]postNotification:note]; 
    //返回个人主页
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mask textview的添加以及监听
- (void)setupTextView{
    _textview = [[ZHWriteTextView alloc]initWithFrame:self.view.bounds];
    _textview.placeHolder = @"请输入微博内容";
    [_textview setFont:[UIFont systemFontOfSize:18]];
    _textview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_textview];
    
    //默认允许垂直方向拖拽
    _textview.alwaysBounceVertical = YES;
    
    //代理
    _textview.delegate=  self;
    
    //通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];

    
}
//判断有无输入文字，有 隐藏占位字符，无 显示占位s字符
- (void)textChange{
    if (_textview.text.length) {
        [self HidenPlaceHolder];
        _rightItem.enabled =YES;
    }else{
        _textview.placeHolderLabel.hidden = NO;
        _rightItem.enabled =NO;
    }
    
}
//隐藏占位字符方法
- (void)HidenPlaceHolder{
    _textview.placeHolderLabel.hidden = YES;
}


#pragma mark 代理方法
//拖拽隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
