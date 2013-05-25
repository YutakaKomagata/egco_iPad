//
//  SeachCheckViewController.m
//  Egco_sample
//
//  Created by 駒形 穣 on 2013/04/20.
//  Copyright (c) 2013年 Yutaka Komagata. All rights reserved.
//



#import <QuartzCore/QuartzCore.h>
#import "SeachCheckViewController.h"
#import "SearchViewController.h"


@interface SeachCheckViewController ()

@end

@implementation SeachCheckViewController

@synthesize userDict = _userDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//テキストフィールドの生成
- (UITextField *)makeTextField:(CGRect)rect text:(NSString*)text
{
    UITextField *textField=[[UITextField alloc] init];
    [textField setFrame:rect];
    [textField setText:text];
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setKeyboardAppearance:UIKeyboardAppearanceDefault];
    [textField setKeyboardType:UIKeyboardTypeDefault];
    [textField setReturnKeyType:UIReturnKeyDone];
    
    textField.placeholder = @"Facebookの名前を入力";
    //テキストフィールドの幅の中間に文字を設定する
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //文字を消せるようにする
    textField.clearButtonMode = UITextFieldViewModeAlways;
    
    return textField;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //最初のudを消しておく処理
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"checkInUser"];
    
    
    //テキストフィールドの生成
    _textField = [self makeTextField:CGRectMake(400, 350, 275,44)text:@""];
    [_textField setDelegate:self];
    [self.view addSubview:_textField];
    
    
    //checkInBtnの設置
    UIButton *checkInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkInBtn.frame = CGRectMake(400, 600, 275, 44);
    //checkInBtn.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    
    [checkInBtn setTitle:@"CheckIn!" forState:UIControlStateNormal];
    [checkInBtn setBackgroundColor:[UIColor grayColor]];
    checkInBtn.showsTouchWhenHighlighted = YES;
    [checkInBtn addTarget:self action:@selector(theirdBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkInBtn];
    
    //セグメントボタンの生成
    NSArray *arr = [NSArray arrayWithObjects:@"Short",@"Long",@"Other", nil];
    UISegmentedControl *selectHour = [[UISegmentedControl alloc] initWithItems:arr];
    selectHour.frame = CGRectMake(400, 475, 275, 44);
    [self.view addSubview:selectHour];
    
    
    //Searchボタンの設置
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake(400, 410, 275, 44);
    //secondBtn.center = CGPointMake(self.view.frame.size.width / 1.5, self.view.frame.size.height / 3.7);
    [secondBtn setTitle:[NSString stringWithFormat:@"Search!"] forState:UIControlStateNormal];
    [secondBtn setBackgroundColor:[UIColor grayColor]];
    secondBtn.showsTouchWhenHighlighted = YES;
    [secondBtn addTarget:self action:@selector(secondBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:secondBtn];
    
    //領収書発行ボタン
    UIButton *cashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cashButton.frame = CGRectMake(400, 535, 275, 44);
    [cashButton setTitle:[NSString stringWithFormat:@"領収書発行"] forState:UIControlStateNormal];
    [cashButton setBackgroundColor:[UIColor grayColor]];
    cashButton.showsTouchWhenHighlighted = YES;
    [cashButton addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cashButton];
    
    
    //checInViewの生成
    _checkInView = [[UIView alloc] initWithFrame:CGRectMake(0, 1024, 768, 1024)];
    //_checkInView.center = CGPointMake(1536, 2048);
    _checkInView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_checkInView];
    
    UIImage *thanksView = [UIImage imageNamed:@"thanks.png"];
    UIImageView *thanksImage = [[UIImageView alloc] initWithImage:thanksView];
    thanksImage.frame = CGRectMake(400, 435, 270, 135);
    [_checkInView addSubview:thanksImage];
    
    //egcoのロゴ
    UIImage *imageView = [UIImage imageNamed:@"egco_logo_2.png"];
    UIImageView *image = [[UIImageView alloc] initWithImage:imageView];
    image.frame = CGRectMake(10, 462, 200, 80);
    [self.view addSubview:image];
    
    //egcoのヘッダー
    UIImage *hedderView = [UIImage imageNamed:@"egco_hedder.png"];
    UIImageView *hedderimage = [[UIImageView alloc] initWithImage:hedderView];
    hedderimage.frame = CGRectMake(0, 0, 768, 44);
    [self.view addSubview:hedderimage];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if (_userDict == nil) {
        NSLog(@"名前はまだない");
    
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSDictionary *userName = [[NSDictionary alloc] init];
        
        userName = [ud objectForKey:@"checkInUser"];
        
        //テキストフィールドにチェックインするユーザー名を格納
        _textField.text = [userName objectForKey:@"name"];
        
        }
}

   ;
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [_textField resignFirstResponder];
    return YES;
}

    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) secondBtnAction:(UIButton *)sender
{
    SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    searchViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    //キーボードを隠す
    [_textField resignFirstResponder];
    
    
    //NSLog(@"%@",_textField.text);
    searchViewController.textField = _textField.text;

    //下からシュッと上がってくるモーダルビューの設定
    searchViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    searchViewController.view.superview.frame = CGRectMake(0, 0, 500, 700);
    [self presentViewController:searchViewController animated:YES completion:nil];
    
}

//CheckIn!ボタンが押された時にチェックイン画面が表示
- (void) theirdBtnAction:(UIButton *)sender;
{    
    
    [UIView beginAnimations:nil context:nil];  // 条件指定開始
    [UIView setAnimationDuration:0.3];  // 秒かけてアニメーションを終了させる
    [UIView setAnimationDelay:0.2];  // 秒後にアニメーションを開始する
    //[UIView setAnimationRepeatCount:5.0];  // アニメーションを5回繰り返す
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];  // アニメーションは一定速度
    _checkInView.center = CGPointMake(384, 512);  // 終了位置を200,400の位置に指定する
    [UIView commitAnimations];  // アニメーション開始！
    [_textField resignFirstResponder];
    
    
    //自動で_checkInViewを閉じる処理
    [NSTimer scheduledTimerWithTimeInterval:5.0f
                                     target:self
                                   selector:@selector(nsTimerAction:)
                                   userInfo:nil
                                    repeats:NO];
    
}

//アラートビューの表示
- (void)showAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"領収書"
                                                    message:@"あなたのアドレスにお送りしました"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}


//自動で_checkInViewが閉じる
- (void)nsTimerAction:(NSTimer*)timer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end