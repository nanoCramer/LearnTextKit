//
//  LTKExclusionView.m
//  LearnTextKit
//
//  Created by jshi.cramer on 15/3/13.
//  Copyright (c) 2015年 jshi.Cramer. All rights reserved.
//

#import "LTKExclusionView.h"

@implementation LTKExclusionView

- (void)drawRect:(CGRect)rect
{
    [self.tintColor setFill];
    [[UIBezierPath bezierPathWithRect: self.bounds] fill];
}

@end
