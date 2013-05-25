//
//  SeachCheckViewController.h
//  Egco_sample
//
//  Created by 駒形 穣 on 2013/04/20.
//  Copyright (c) 2013年 Yutaka Komagata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeachCheckViewController : UIViewController <UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField* _textField;
    //CALayer *_layer;
    UIView *_checkInView;
    NSDictionary *_userDict;
}

@property(nonatomic,strong)NSDictionary *userDict;

@end
