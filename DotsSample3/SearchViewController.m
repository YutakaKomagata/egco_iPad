//
//  SearchViewController.m
//  Egco_sample
//
//  Created by 駒形 穣 on 2013/04/20.
//  Copyright (c) 2013年 Yutaka Komagata. All rights reserved.
//

#import "SearchViewController.h"
#import "SeachCheckViewController.h"
#import "AFNetworking.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize textField;

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
    _userArray = [[NSArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    
    //画面の色は灰色です
    self.view.backgroundColor = [UIColor grayColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(84, 112, 600, 800) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    
    //AFNetworking
    NSString *urlString = [NSString stringWithFormat:@"http://133.242.129.55/work/egco.php?id=%@", textField];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0f];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        _userArray = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingAllowFragments
                                                       error:&error];
    [tableView reloadData];
        
    NSLog(@"%@",_userArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    [operation start];

    
    
    //NSLog(@"%@",textField);
    
    //暫定的なボタンの設置
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeBtn.frame = CGRectMake(84, 500, 600, 44);
    //closeBtn.center = CGPointMake(self.view.frame.size.width / 3 , self.view.frame.size.height / 5);
    
    [closeBtn setTitle:@"暫定的に置いてるボタンです" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(searchCloseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) searchCloseBtnAction:(UIButton *)sender
{
    //モーダル非表示
    //ビューを閉じるために dismissViewControllerAnimated を呼んでいる
    [self dismissViewControllerAnimated:YES completion:nil];
}

//テーブルビューに必要な３つのメソッド：１つ目
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

//テーブルビューに必要な３つのメソッド：２つ目
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"hoge");
    
    return _userArray.count;
}

//テーブルビューに必要な３つのメソッド：３つ目
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary *dict = _userArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    // Configure the cell...
    NSLog(@"%@",dict);
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = self.navigationController.viewControllers;
    int arrayCount = [array count];
    SeachCheckViewController *parent = [array objectAtIndex:arrayCount - 2];
    _userDict = _userArray[indexPath.row];
    parent.userDict = _userDict;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
