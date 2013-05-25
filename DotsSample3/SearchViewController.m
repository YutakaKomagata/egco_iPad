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

@synthesize textField = _searchId;

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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(84, 112, 600, 790) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    
    //AFNetworking
    NSString *urlString = [NSString stringWithFormat:@"http://133.242.129.55/work/egco.php?id=%@", _searchId];
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
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//テーブルビューに必要な３つのメソッド：テーブルに表示するsectionの数を決定する処理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//テーブルビューに必要な３つのメソッド：Sectionに表示するRowの数を決定する処理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _userArray.count;
}

//テーブルビューに必要な３つのメソッド：セルに表示するデータをセットする処理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    
    }
    
    NSDictionary *dict = _userArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];

    NSLog(@"%@",dict);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = self.navigationController.viewControllers;
    int arrayCount = [array count];
    SeachCheckViewController *scv = [array objectAtIndex:arrayCount - 2];
    
    _userDict = _userArray[indexPath.row];
    scv.userDict = _userDict;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:_userDict forKey:@"checkInUser"];
    
    NSLog(@"%@", _userDict);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
