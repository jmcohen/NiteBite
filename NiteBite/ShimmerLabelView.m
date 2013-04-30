//
//  ShimmerLabelView.m
//  NiteBite
//
//  Created by Jeremy Cohen on 11/16/12.
//  Copyright (c) 2012 Jeremy Cohen. All rights reserved.
//

#import "ShimmerLabelView.h"

@implementation ShimmerLabelView

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    const char *text = "swipe to begin";
    CGContextSelectFont(ctx, "Arial", 24, kCGEncodingMacRoman);
    CGContextSetTextMatrix(ctx, CGAffineTransformMake(1.0,0.0, 0.0, -1.0, 0.0, 0.0));
    
    CGRect background = CGRectMake(0, 0, 100, 30);
    CGColorRef blackColor = [UIColor blackColor].CGColor;
    CGContextSetFillColorWithColor(ctx, blackColor);
    CGColorRelease(blackColor);
    CGContextFillRect(ctx, background);
    
    CGContextSetFontSize(ctx, 20);
    CGColorRef whiteColor = [UIColor clearColor].CGColor;
    CGContextSetFillColorWithColor(ctx, whiteColor);
    CGContextShowTextAtPoint(ctx, 0, 20, text, sizeof(text));
}


@end
