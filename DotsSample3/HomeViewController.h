//
//  HomeViewController.h
//  DotsSample3
//
//  Created by yusuke_yasuo on 2012/11/20.
//  Copyright (c) 2012年 yusuke_yasuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController : UIViewController <UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIWebView *_webview;
    IBOutlet UIActivityIndicatorView *_indicator;
    IBOutlet UITableView *_tableview;
    IBOutlet UILabel *_label;
    UIRefreshControl *_refreshControl;
    NSURLConnection *_connection;
    NSMutableData *_data;
    AVAudioPlayer *sePlayerFlip;
    
    UIView *_secondView;
    int    *_animeIndex;
    
}

@end
