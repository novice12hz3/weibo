//
//  ZHOAuthvc.m
//  微博text
//
//  Created by fu00 on 2020/5/8.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHOAuthvc.h"

@interface ZHOAuthvc ()<UIWebViewDelegate>

@end

@implementation ZHOAuthvc

- (void)viewDidLoad {
    [super viewDidLoad];
    //展示登陆的网页
    UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
//     WKWebView *webview = [[WKWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webview];
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"321005449";
    NSString *redirect_uri = @"https://www.baidu.com";

    // 拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];

    NSLog(@"%@",urlStr);
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlStr];

    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];


    // 加载请求
    [webview loadRequest:request];

    // 设置代理
    webview.delegate = self;


//
    
    
//    NSString *urlstr = [NSString stringWithFormat:@"http://api02.idataapi.cn:8000/post/weibo?apikey=fp40srNpCn5fvwAMQj0qsmLcDrhX6ypPySRBGjC8fRoPRCQexYc29kN0CegiKLMp&kw=%E5%8C%97%E4%BA%AC&uid=2803301701"];
//    NSURL *url = [NSURL URLWithString:urlstr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *firsttask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//        NSLog(@"111111%@",dict);
//
////    }];
//    [firsttask resume];
    [webview loadRequest:request];
    
    
    
}


//不明白
// 当Webview需要加载一个请求的时候，就会调用这个方法，询问下是否请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;//获取请求的url字符串
    // 获取code(RequestToken)
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) { // 有code=

        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        NSLog(@"this is code:%@",code);
        // 不会去加载回调界面
        //利用code换取access_token
        [self accessTokenWithCode:code];
        return NO;
    }

    return YES;
}





#pragma mask 利用code换取access_token的方法
- (void)accessTokenWithCode:(NSString *)code{

    NSMutableString *mustring = [[NSMutableString alloc]initWithString:@"https://api.weibo.com/oauth2/access_token?client_id=321005449&client_secret=6f0b208ebdb011c8908c05fd634d1c1e&grant_type=authorization_code&redirect_uri=https://www.baidu.com&code="];
    [mustring appendString:code];//拼接之前获得的code



    //1创建url
    NSURL *urlstring= [NSURL URLWithString:mustring];
    //2创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];/*这句代码不懂*/
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为get
    NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];

    //3连接服务器

    
    //新的方法，nsurlsession
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:nil];
//
//
//    NSData *received = [session dataTaskWithRequest:request completionHandler:nil ]/*返回的不是nsdata*/;

    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str1 = [[NSString alloc]initWithData:received encoding: NSUTF8StringEncoding];
    NSLog(@"Back String:%@",str1);

    NSError *error;
    //如何从str1中获取到access_token
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:&error];

    //将获取的access_oken和uid储存在模型中
    self.account = [ZHAccount AccountWithDict:dictionary];
//    NSString *AcountDictionary = NSHomeDirectory();
//    NSString *AcountfilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"];
//     [NSKeyedArchiver archiveRootObject:account toFile:AcountfilePath];

    //本地沙盒储存
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"accessdict.plist"];
    [dictionary writeToFile:filePath atomically:YES];
    
    NSString *access_token = [dictionary objectForKey:@"access_token"];
    NSLog(@"access token is :%@",access_token);

    NSString *uid = [dictionary objectForKey:@"uid"];
    NSLog(@"111111:%@",uid);

    
    //get请求
    //1设置请求路径
//    NSString *urlstr2 = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/user_timeline.json?access_token=%@",access_token];
//    NSURL *url2 = [NSURL URLWithString:urlstr2];
//    //2创建请求对象
//    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
//
//    //3发送请求
//    NSData *data1 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"%@",dict);

    
//    NSString *urlstr2 = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/user_timeline.json?access_token=%@&uid=%@",access_token,uid];
//    NSURL *url2 = [NSURL URLWithString:urlstr2];
//    //2创建请求对象
//    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
//
//    //3发送请求
//    NSData *data2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
//    NSDictionary *dictstatuses = dict[@"statuses"];

    

}




//- (void)webViewDidStartLoad:(UIWebView *)webView{
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
