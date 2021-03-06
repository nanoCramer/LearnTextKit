//
//  LTKHighlightTextStorage.m
//  LearnTextKit
//
//  Created by jshi.cramer on 15/3/12.
//  Copyright (c) 2015年 jshi.Cramer. All rights reserved.
//

#import "LTKHighlightTextStorage.h"

@implementation LTKHighlightTextStorage {
    NSMutableAttributedString *_imp;
}

-(instancetype)init {
    self = [super init];
    
    if (self) {
        _imp = [[NSMutableAttributedString alloc] init];
    }
    return self;
}

- (NSString *)string {
    return _imp.string;
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    return [_imp attributesAtIndex:location effectiveRange:range];
}

-(void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [_imp replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:(NSInteger)str.length - (NSInteger)range.length];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range {
    [_imp setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}

#pragma mark - Syntax highlighting
- (void)processEditing {
    // Regular expression matching all iWords -- first character i, followed by an uppercase alphabetic character, followed by at least one other character. Matches words like iPod, iPhone, etc.
    static NSRegularExpression *iExpression;
    iExpression = iExpression ?: [NSRegularExpression regularExpressionWithPattern:@"i[\\p{Alphabetic}&&\\p{Uppercase}][\\p{Alphabetic}]+" options:0 error:NULL];
    
    
    // Clear text color of edited range
    NSRange paragaphRange = [self.string paragraphRangeForRange: self.editedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:paragaphRange];
    
    // Find all iWords in range
    [iExpression enumerateMatchesInString:self.string options:0 range:paragaphRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        // Add red highlight color
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:result.range];
    }];
    
    // Call super *after* changing the attrbutes, as it finalizes the attributes and calls the delegate methods.
    [super processEditing];
}
@end
