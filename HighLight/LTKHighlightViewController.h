//
//  LTKHighlightViewController.h
//  LearnTextKit
//
//  Created by jshi.cramer on 15/3/12.
//  Copyright (c) 2015年 jshi.Cramer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTKHighlightViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomInset;
@end
