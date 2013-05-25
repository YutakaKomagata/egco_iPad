//
//  SeachCheckViewController.h
//  Egco_sample
//
//  Created by 駒形 穣 on 2013/04/20.
//  Copyright (c) 2013年 Yutaka Komagata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface SeachCheckViewController : UIViewController <UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField* _textField;
    //CALayer *_layer;
    UIView *_checkInView;
}

@property(nonatomic,strong)NSDictionary *userDict;

@end
