//
//  W2View3.m
//  
//
//  Created by Fushiki, Ikko on 7/14/15.
//
//

#import "W2View3.h"

@implementation W2View3

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [[NSColor orangeColor] set];
    NSRectFill([self bounds]);
}

@end
