//
//  LTKLayoutViewController.m
//  LearnTextKit
//
//  Created by jshi.cramer on 15/3/13.
//  Copyright (c) 2015年 jshi.Cramer. All rights reserved.
//

#import "LTKLayoutViewController.h"

#import "LTKURLLinkLayoutManager.h"
#import "LTKURLLinkTextStorage.h"

@interface LTKLayoutViewController () <NSLayoutManagerDelegate> {
    LTKURLLinkTextStorage *_textStorage;
}

@end

@implementation LTKLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textStorage = [[LTKURLLinkTextStorage alloc] init];
    
    NSLayoutManager *layoutManager = [[LTKURLLinkLayoutManager alloc] init];
    [_textStorage addLayoutManager:layoutManager];
    
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
    [layoutManager addTextContainer:textContainer];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectInset(self.view.bounds, 8, 20) textContainer:textContainer];
    textView.translatesAutoresizingMaskIntoConstraints = YES;
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    [self.view addSubview:textView];
    
    layoutManager.delegate = self;
    
    [_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"layout" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
}

- (BOOL)layoutManager:(NSLayoutManager *)layoutManager shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex
{
    NSRange range;
    NSURL *linkURL = [layoutManager.textStorage attribute:NSLinkAttributeName atIndex:charIndex effectiveRange:&range];
    
    // Do not break lines in links unless absolutely required
    if (linkURL && charIndex > range.location && charIndex <= NSMaxRange(range))
        return NO;
    else
        return YES;
}

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect
{
    return floorf(glyphIndex / 100);
}

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager paragraphSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect
{
    return 10;
}

@end
