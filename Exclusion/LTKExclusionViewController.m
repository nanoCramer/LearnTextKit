//
//  LTKExclusionViewController.m
//  LearnTextKit
//
//  Created by jshi.cramer on 15/3/13.
//  Copyright (c) 2015年 jshi.Cramer. All rights reserved.
//

#import "LTKExclusionViewController.h"
#import "LTKExclusionView.h"

@interface LTKExclusionViewController () <UITextViewDelegate> {
    CGPoint _panOffset;
}

@end

@implementation LTKExclusionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.textView.textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"lorem" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
    
    self.textView.delegate = self;
    
    [self.exclusionView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(exclusionPan:)]];
    
    [self updateExclusionPaths];
    
    self.textView.layoutManager.hyphenationFactor = 1.0;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [self updateExclusionPaths]; 
//}

- (void)exclusionPan:(UIPanGestureRecognizer *)pan {
    // Capute offset in view on begin
    if (pan.state == UIGestureRecognizerStateBegan) {
        _panOffset = [pan locationInView: self.exclusionView];
    }
    
    // Update view location
    CGPoint location = [pan locationInView: self.view];
    CGPoint circleCenter = self.exclusionView.center;
    
    circleCenter.x = location.x - _panOffset.x + self.exclusionView.frame.size.width / 2;
    circleCenter.y = location.y - _panOffset.y + self.exclusionView.frame.size.width / 2;
    self.exclusionView.center = circleCenter;
    
    // Update exclusion path
    [self updateExclusionPaths];
}

- (void)updateExclusionPaths
{
    CGRect ovalFrame = [self.textView convertRect:self.exclusionView.bounds fromView:self.exclusionView];
    
    // Since text container does not know about the inset, we must shift the frame to container coordinates
    ovalFrame.origin.x -= self.textView.textContainerInset.left;
    ovalFrame.origin.y -= self.textView.textContainerInset.top;
    
    // Simply set the exclusion path
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithRect: ovalFrame];
    self.textView.textContainer.exclusionPaths = @[ovalPath];
}


@end














