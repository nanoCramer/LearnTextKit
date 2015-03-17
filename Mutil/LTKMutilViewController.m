//
//  LTKMutilViewController.m
//  LearnTextKit
//
//  Created by jshi.cramer on 15/3/12.
//  Copyright (c) 2015年 jshi.Cramer. All rights reserved.
//

#import "LTKMutilViewController.h"

@interface LTKMutilViewController ()

@end

@implementation LTKMutilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load Text
    NSTextStorage *sharedTextStorage = self.firstTextView.textStorage;
    [sharedTextStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"lorem" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
     
     NSLayoutManager *secondLayoutManager = [[NSLayoutManager alloc] init];
    [sharedTextStorage addLayoutManager:secondLayoutManager];
    
    NSTextContainer *secondTextContainer = [[NSTextContainer alloc] init];
    [secondLayoutManager addTextContainer:secondTextContainer];
    
    NSLog(@"%f", _secondTextView.bounds.size.width);
    UITextView *otherSecondTextView = [[UITextView alloc] initWithFrame:self.secondTextView.bounds textContainer:secondTextContainer];
    otherSecondTextView.backgroundColor = self.secondTextView.backgroundColor;
    otherSecondTextView.scrollEnabled = NO;
    otherSecondTextView.translatesAutoresizingMaskIntoConstraints = YES;
    otherSecondTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.secondTextView addSubview:otherSecondTextView];
    
    NSTextContainer *thirdTextContainer = [[NSTextContainer alloc] init];
    [secondLayoutManager addTextContainer:thirdTextContainer];
    
    UITextView *otherThirdTextView = [[UITextView alloc] initWithFrame:self.thirdTextView.bounds textContainer:thirdTextContainer];
    otherThirdTextView.backgroundColor = self.thirdTextView.backgroundColor;
    otherThirdTextView.translatesAutoresizingMaskIntoConstraints = YES;
    otherThirdTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.thirdTextView addSubview:otherThirdTextView];
}



@end
