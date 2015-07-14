//
//  MyView1.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/13/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import "MyView1.h"

@implementation MyView1

// When drawLayer is implemented, drawRect is not called.
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [[NSColor yellowColor] set];
    NSRectFill([self bounds]);
}


- (void)drawLayer:(CALayer *)theLayer inContext:(CGContextRef)theContext {
    CGMutablePathRef thePath = CGPathCreateMutable();
    
    CGPathMoveToPoint(thePath,NULL,15.0f,15.f);
    CGPathAddCurveToPoint(thePath,
                          NULL,
                          15.f,250.0f,
                          295.0f,250.0f,
                          295.0f,15.0f);
    
    CGContextBeginPath(theContext);
    CGContextAddPath(theContext, thePath);
    
    CGContextSetLineWidth(theContext, 5);
    CGContextStrokePath(theContext);
    
    // Release the path
    CFRelease(thePath);
}

@end
