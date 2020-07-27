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
@property(nonatomic,strong) UIButton *imageButton;
@property(nonatomic,strong) UIImageView *imageView1;
@property(nonatomic,strong) UIImageView *imageView2;
@property(nonatomic,strong) UIImageView *imageView3;
@property(nonatomic,strong) NSMutableArray *imageArray;
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
    
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageButton addTarget:self action:@selector(jumpToImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.imageButton];
    self.imageButton.sd_layout.bottomSpaceToView(self.view, 50).leftSpaceToView(self.view, 40).heightIs(50).widthIs(50);
    [self.imageButton setImage:[UIImage imageNamed:@"照片"] forState:UIControlStateNormal];
    
//    self.imageView1 = [[UIImageView alloc]init];
//    [self.view addSubview:self.imageView1];
//    self.imageView1.sd_layout.topSpaceToView(self.textview, 0).leftSpaceToView(self.view, 50).widthIs(100).heightIs(100);
//    self.imageView2 = [[UIImageView alloc]init];
//    [self.view addSubview:self.imageView2];
//    self.imageView2.sd_layout.topSpaceToView(self.textview, 0).leftSpaceToView(self.imageView1, 10).widthIs(100).heightIs(100);
//    self.imageView3 = [[UIImageView alloc]init];
//    [self.view addSubview:self.imageView3];
//    self.imageView3.sd_layout.topSpaceToView(self.textview, 0).leftSpaceToView(self.imageView2, 10).widthIs(100).heightIs(100);
//
    if (self.imageArray ==nil) {
        self.imageArray = [NSMutableArray arrayWithCapacity:0];

    }
    
}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [_textview becomeFirstResponder];
//}
#pragma mark 点击照片按钮调用方法
- (void)jumpToImage{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate = self;
    
//    [self.navigationController pushViewController:imagePicker animated:YES];
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}



#pragma mask 导航条的按钮方法
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)compose{
    NSLog(@"%@",self.textview.text);
    NSNotification *note = [NSNotification notificationWithName:@"发送" object:self userInfo:@{
                                @"text":[NSString stringWithFormat:@"%@",self.textview.text],
                                @"image":self.imageArray
                                                                                             }];
    [[NSNotificationCenter defaultCenter]postNotification:note]; 
    //返回个人主页
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mask textview的添加以及监听
- (void)setupTextView{
    _textview = [[ZHWriteTextView alloc]init];
    
    _textview.placeHolder = @"分享新鲜事";
    [_textview setFont:[UIFont systemFontOfSize:18]];
    _textview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_textview];
    _textview.frame = CGRectMake(0, 100, 414, 50);
    _textview.scrollEnabled = NO;
    
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    //回到首页
    [self dismissViewControllerAnimated:YES completion:nil]; 
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.imageArray addObject:image];
    
    NSInteger imageCount = self.view.subviews.count-2;//已添加的图片数
    NSInteger j = 0;
    while (imageCount< self.imageArray.count) {
        NSInteger i = (imageCount+1)%3;
        if (i==0) {
            i = 3;
        }
        if (imageCount<3) {
            j=1;
        }else{
            if(imageCount<6){j=2;}else{j=3;}
        }
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = self.imageArray[imageCount];
        [self.view addSubview:imageView];
        imageView.sd_layout.leftSpaceToView(self.view, 45+(i-1)*110).topSpaceToView(self.textview, 110*(j-1)).heightIs(100).widthIs(100);
        imageCount+= 1;
        
    }
//    switch (self.imageArray.count) {
//        case 1:{self.imageView1.image = self.imageArray[0];
//            self.imageArray[0] = self.imageView1.image;
//            break;
//        }
//        case 2:{self.imageView2.image = self.imageArray[1];
//            self.imageArray[1] = self.imageView2.image;
//            break;
//        }
//        case 3:{self.imageView3.image = self.imageArray[2];
//            self.imageArray[2] = self.imageView3.image;
//            break;
//        }
//        default:
//            break;
//    }
    self.rightItem.enabled = YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    CGFloat width = CGRectGetWidth(textView.frame);
    CGFloat height = CGRectGetHeight(textView.frame);
    CGSize newsize = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    CGRect newframe = textView.frame;
    newframe.size = CGSizeMake(fmax(width, newsize.width), fmax(height, newsize.height));
    textView.frame =newframe;
    
//    [self.view updateLayout];
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
