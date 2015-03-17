//
//  LTKExclusionViewController.h
//  LearnTextKit
//
//  Created by jshi.cramer on 15/3/13.
//  Copyright (c) 2015年 jshi.Cramer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTKExclusionView;
@interface LTKExclusionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet LTKExclusionView *exclusionView;
@end
