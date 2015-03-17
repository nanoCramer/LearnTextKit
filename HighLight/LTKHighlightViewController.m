//
//  LTKHighlightViewController.m
//  LearnTextKit
//
//  Created by jshi.cramer on 15/3/12.
//  Copyright (c) 2015年 jshi.Cramer. All rights reserved.
//
#import "LTKHighlightTextStorage.h"
#import "LTKHighlightViewController.h"

@interface LTKHighlightViewController ()

@end

@implementation LTKHighlightViewController {
    LTKHighlightTextStorage *_textStorage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textStorage = [[LTKHighlightTextStorage alloc] init];
    [_textStorage addLayoutManager:self.textView.layoutManager];
    
    [_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"iText" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - Keyboard status

- (void)keyboardWillShowOrHide:(NSNotification *)notification
{
    CGFloat newInset;
    if ([notification.name isEqualToString: UIKeyboardWillShowNotification])
        newInset = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    else
        newInset = 20;
    
    [self.bottomInset setConstant: newInset];
}

@end
