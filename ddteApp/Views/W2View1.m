//
//  W2View1.m
//  
//
//  Created by Fushiki, Ikko on 7/14/15.
//
//

#import "W2View1.h"

@implementation W2View1

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [[NSColor yellowColor] set];
    NSRectFill([self bounds]);
}

@end
