//
//  SearchViewController.h
//  Egco_sample
//
//  Created by 駒形 穣 on 2013/04/20.
//  Copyright (c) 2013年 Yutaka Komagata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
{
    NSString *_searchId;
    NSArray *_userArray;
    NSDictionary *_userDict;
}

@property(nonatomic, strong) NSString *textField;

@end
