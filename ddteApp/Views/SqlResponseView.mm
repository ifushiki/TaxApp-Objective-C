//
//  SqlResponseView.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/15/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import "SqlResponseView.h"
#import "DdteResponseView.h"
#import <iostream>
#import <vector>

@interface SqlResponseView()
{
    std::vector<float> gaussian;
    bool gaussianInitialized;
}

@end

@implementation SqlResponseView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void) initializeGaussian
{
    if (gaussianInitialized == true) {
        return;
    }
    
    int n = 100;
    float middle = 1.0*n/2;
    for (int i = 0; i < n; i++) {
        float x = (1.0*i - middle)*8/(n - 1);
        float value = exp2f(-x*x/2.0);    // sigma = 1.
        gaussian.push_back(value);
    }
    gaussianInitialized = true;
}

- (void) drawGaussian:(NSRect) frame inContext:(CGContextRef)theContext
{
    int n = (int) gaussian.size();
    float xFac = frame.size.width/(n - 1);
    float yFac = frame.size.height;
    float x0 = frame.origin.x;
    float y0 = frame.origin.y;
    
    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath, NULL, x0, yFac*gaussian[0] + y0);

    for (int i = 1; i < n; i++) {
        CGPathAddLineToPoint(thePath, NULL, xFac*i + x0, yFac*gaussian[i] + y0);
    }
    CGContextBeginPath(theContext);
    CGContextAddPath(theContext, thePath);
    CGContextStrokePath(theContext);
    // Release the path
    CFRelease(thePath);

}
- (void)drawLayer:(CALayer *)theLayer inContext:(CGContextRef)theContext {
    [theLayer setBackgroundColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)];

    CGContextSetRGBStrokeColor(theContext, 0.0,0.0,0.0,1.0);
    CGContextSetLineWidth(theContext, 4);
    NSRect rect = self.bounds;
    
    float yFac = rect.size.height*0.8;
    float yBottom = rect.size.height*0.1;
    NSRect frame;
    frame.origin.x = 0;
    frame.origin.y = yBottom;
    frame.size.width = rect.size.width/2;
    frame.size.height = yFac;
    
    CGContextSetRGBStrokeColor(theContext, 1.0,0.0,0.0,1.0);
    [self drawGaussian:frame inContext:theContext];
    
    CGContextSetRGBStrokeColor(theContext, 1.0,1.0,0.0,1.0);
    frame.origin.x = rect.size.width*0.1;
    frame.size.width = rect.size.width*0.6;
    [self drawGaussian:frame inContext:theContext];

    CGContextSetRGBStrokeColor(theContext, 0.5,0.9,0.0,1.0);
    frame.origin.x = rect.size.width*0.15;
    frame.size.width = rect.size.width*0.7;
    [self drawGaussian:frame inContext:theContext];
    
    CGContextSetRGBStrokeColor(theContext, 0.0,0.2,1.0,1.0);
   frame.origin.x = rect.size.width*0.15;
    frame.size.width = rect.size.width*0.8;
    [self drawGaussian:frame inContext:theContext];
}

@end
