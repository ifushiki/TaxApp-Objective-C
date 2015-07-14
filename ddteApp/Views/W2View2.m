//
//  W2View2.m
//  
//
//  Created by Fushiki, Ikko on 7/14/15.
//
//

#import "W2View2.h"

@implementation W2View2

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [[NSColor greenColor] set];
    NSRectFill([self bounds]);
}

@end
