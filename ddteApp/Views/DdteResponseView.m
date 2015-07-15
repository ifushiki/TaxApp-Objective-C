//
//  DdteResponseView.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/15/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import "DdteResponseView.h"

#define kMaximumSigma   8

@implementation DdteResponseView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (float) getXCoordinateFromSigma:(float) sigma
{
    NSRect rect = self.bounds;
    float xRange = 2.0*kMaximumSigma;
    float dTick = rect.size.width/xRange;
    
    float arrowPosition = dTick*(sigma + kMaximumSigma);  // 4.0 is a mid range.
    
    return arrowPosition;
}

void setArraw(float w, float h, CGPoint* arrow)
{
    arrow[0].x = 0.0;
    arrow[0].y = 0.0;
    arrow[1].x = w;
    arrow[1].y = h;
    arrow[2].x = w/2;
    arrow[2].y = h;
    arrow[3].x = arrow[2].x;
    arrow[3].y = 3*h;
    arrow[4].x = - arrow[3].x;
    arrow[4].y = arrow[3].y;
    arrow[5].x = arrow[4].x;
    arrow[5].y = arrow[1].y;
    arrow[6].x = - arrow[1].x;
    arrow[6].y = arrow[1].y;
    arrow[7].x = arrow[0].x;
    arrow[7].y = arrow[0].y;
}

// This calculate the bounding border from sigma1 to sigma2.
- (void) getBorderRect:(NSRect *) border from:(float) sigma1 to:(float) sigma2
{
    float x1 = [self getXCoordinateFromSigma:sigma1];
    float x2 = [self getXCoordinateFromSigma:sigma2];
    NSRect rect = self.bounds;
    
    border->origin.x = x1;
    border->origin.y = 0;
    border->size.width = x2 - x1;
    border->size.height = rect.size.height;
}

- (void) fillDangerZones:(CGContextRef)theContext
{
    NSRect border;
    float sigma1, sigma2;

    // Red Zones
    CGContextSetRGBFillColor(theContext, 1.0,0.0,0.0,0.2);
    sigma1 = - 1.0*kMaximumSigma;
    sigma2 = - 5.0;
    [self getBorderRect:&border from:sigma1 to:sigma2];
    
    CGContextFillRect(theContext, border);
    sigma1 = 5.0;
    sigma2 = 1.0*kMaximumSigma;
    [self getBorderRect:&border from:sigma1 to:sigma2];
    CGContextFillRect(theContext, border);
    
    // Red Zones
    CGContextSetRGBFillColor(theContext, 1.0,1.0,0.0,0.2);
    sigma1 = - 5.0;
    sigma2 = - 3.0;
    [self getBorderRect:&border from:sigma1 to:sigma2];
    CGContextFillRect(theContext, border);
    
    sigma1 = 3.0;
    sigma2 = 5.0;
    [self getBorderRect:&border from:sigma1 to:sigma2];
    CGContextFillRect(theContext, border);
}

- (void)drawLayer:(CALayer *)theLayer inContext:(CGContextRef)theContext {
    [theLayer setBackgroundColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)];
    
    [self fillDangerZones:theContext];
    
    NSRect rect = self.bounds;
    CGMutablePathRef borderPath = CGPathCreateMutable();
    
    CGContextSetRGBStrokeColor(theContext, 0.0,0.0,0.0,1.0);
    CGContextSetLineWidth(theContext, 4);
    CGContextStrokeRect(theContext, rect);
    
    // Release the path
    CFRelease(borderPath);

    int n = 100;
    float yFac = rect.size.height*0.8;
    float yBottom = rect.size.height*0.1;
    float xRange = 2.0*kMaximumSigma;
    float dx = rect.size.width/(n - 1);
    float middle = 0.5*n;
    
    CGContextSetRGBStrokeColor(theContext, 0.2,0.2,0.2,1.0);
    CGContextSetLineWidth(theContext, 2);
    CGPoint line[2];
    float thickLength = rect.size.height*0.05;

    line[0].x = 0;
    line[0].y = yBottom;
    line[1].x = rect.size.width;
    line[1].y = yBottom;
    CGContextStrokeLineSegments(theContext, line, 2);
    
    line[1].y = yBottom + thickLength;
    float dTick = rect.size.width/xRange;
    float x = 0;
    
    for (int i = 0; i <= 2*kMaximumSigma; i++) {
        line[0].x = i*dTick;
        line[1].x = i*dTick;
        CGContextStrokeLineSegments(theContext, line, 2);
    }
    
    float f[n];
    
    for (int i = 0; i < n; i++) {
        x = xRange*(1.0*i - middle)/n;
        f[i] = yFac*exp2f(-x*x/2.0);    // sigma = 1.
    }
    
    CGContextSetRGBStrokeColor(theContext, 0.0,0.0,0.0,1.0);
    CGContextSetLineWidth(theContext, 4);

    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath, NULL, 0.0f, f[0] + yBottom);

    for (int i = 1; i < n; i++) {
        CGPathAddLineToPoint(thePath, NULL, dx*i, f[i] + yBottom);
    }
    
    CGContextBeginPath(theContext);
    CGContextAddPath(theContext, thePath);
    CGContextStrokePath(theContext);
    // Release the path
    CFRelease(thePath);
    
    float arrowPosition = [self getXCoordinateFromSigma:self.sigma];

    CGMutablePathRef arrowPath = CGPathCreateMutable();
    CGContextBeginPath(theContext);
    
    CGPoint arrow[8];
    float w = rect.size.width*0.02;
    float h = rect.size.height*0.05;
    setArraw(w, h, arrow);
    CGPathMoveToPoint(arrowPath,NULL, arrow[0].x + arrowPosition, arrow[0].y + yBottom);

    for (int i = 1; i < 8; i++) {
        CGPathAddLineToPoint(thePath,NULL, arrow[i].x + arrowPosition, arrow[i].y + yBottom);
    }

    CGContextBeginPath(theContext);
    CGContextAddPath(theContext, arrowPath);
    CGContextSetRGBStrokeColor(theContext, 1.0,0.0,0.0,1.0);
    CGContextSetRGBFillColor(theContext, 1.0,0.0,0.0,1.0);
    CGContextSetLineWidth(theContext, 4);

    CGContextFillPath(theContext);
    CGContextStrokePath(theContext);
    CFRelease(arrowPath);
}

@end
