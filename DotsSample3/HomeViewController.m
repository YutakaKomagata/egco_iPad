//
//  HomeViewController.m
//  DotsSample3
//
//  Created by yusuke_yasuo on 2012/11/20.
//  Copyright (c) 2012年 yusuke_yasuo. All rights reserved.
//

#import "HomeViewController.h"
#import "SeachCheckViewController.h"

#define BTN_MOVE 0

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    // _webviewの表示
    NSURL * url = [[NSURL alloc] initWithString:@"http://chatoramini:dotsthedots@49.212.177.151/"];
    //NSURL * url = [[NSURL alloc] initWithString:@"http://133.242.129.55/test/"];
    NSURLRequest * req = [[NSURLRequest alloc] initWithURL:url];
    [_webview loadRequest:req];
    
    // _webviewをバウンスさせない
    
    for (id subview in _webview.subviews) {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
            ((UIScrollView *)subview).bounces = NO;
    }
    //*/
    
    // _refreshControlの設定
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.tintColor = [UIColor clearColor];
    [_refreshControl addTarget:self action:@selector(call_staff) forControlEvents:UIControlEventValueChanged];
    [_tableview addSubview:_refreshControl];
    
    //DotsSoundを設定
    NSURL *seURLFlip = [[NSBundle mainBundle] URLForResource:@"DotsSound" withExtension:@"mp3"];
    sePlayerFlip = [[AVAudioPlayer alloc] initWithContentsOfURL:seURLFlip error:NULL];
    [sePlayerFlip prepareToPlay];
    
    //マゼンタ色のラインを設置
    UIView *commonView = [[UIView alloc] initWithFrame:CGRectMake(0, 706, 768, 44)];
    commonView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:commonView];

    //Touch!ボタンの設置
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 750, 768, 44);
    [btn setTitle:[NSString stringWithFormat:@"ご利用の方は、Touch!　して下さい"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    btn.showsTouchWhenHighlighted = YES;
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (UIView *)makeView:(CGRect)rect
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    [view setFrame:rect];
    return view;
}

- (IBAction)clickButton:(UIButton *)sender
{
    SeachCheckViewController *seachCheckViewctl = [[SeachCheckViewController alloc] initWithNibName:@"SeachCheckViewController"bundle:nil];
    seachCheckViewctl.modalPresentationStyle = UIModalPresentationFullScreen;
    seachCheckViewctl.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    seachCheckViewctl.view.superview.frame = CGRectMake(0, 0, 500, 00);
    
    [self presentViewController:seachCheckViewctl animated:YES completion:nil];
}

//アニメーション開始時に呼ばれる
- (void) someAnimationWillStart:(id)sender
{
    NSLog(@"アニメーション開始");
}

//アニメーション停止時に呼ばれる
- (void) someAnimationDidStop:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
    NSLog(@"アニメーション停止");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)call_staff
{
    //DotsSoundを再生
    [sePlayerFlip play];
    
    // メール送信
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://133.242.129.55/connecting_the_dots/staffs/callstaff/"]];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}
/*
// UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    _indicator.hidden = NO;
    [_indicator startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_indicator stopAnimating];
    _indicator.hidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}
*/
// UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 1)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"longhimo.png"]];
        cell.backgroundView = imageView;
        cell.backgroundColor = [UIColor clearColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (indexPath.row == 1 || indexPath.row == 2) {
    if (indexPath.row == 1) {
        return 1000.0f;
    } else {
        return 5.0f;
    }
}



// 非同期通信
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _data = [[NSMutableData alloc] initWithData:0];     // データの初期化
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];    // データの追加
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSError *error=nil;
    NSString *mes = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:&error];
    _label.text = [NSString stringWithString:mes];
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(labelRefresh) userInfo:nil repeats:NO];
    [_refreshControl endRefreshing];
}

- (void)labelRefresh
{
    _label.text = @"";
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.scheme isEqualToString:@"native"]) {
        // フック処理
        [self invokeNativeMethod: request];
        
        // WebViewの読み込みは中断する。
        return NO;
    }
    // 通常のschemeの場合は、フックせずそのまま処理を続ける
    else {
        return YES;
    }
}

-(void)invokeNativeMethod: (NSURLRequest *)request
{
    if ([request.URL.host isEqualToString:@"focusForm"]) {
        [self forcusForm];
    } else if ([request.URL.host isEqualToString:@"blurForm"]) {
        [self blurForm];
    }
}

- (void)forcusForm
{
    NSLog(@"Forcus!");
    _webview.frame = CGRectMake(0, 350, 768, 1004);
}

- (void)blurForm
{
    NSLog(@"Blur!");
    _webview.frame = CGRectMake(0, 554, 768, 406);
}


@end
