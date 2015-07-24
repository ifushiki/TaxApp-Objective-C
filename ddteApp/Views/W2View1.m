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
//    [[NSColor yellowColor] set];
//    NSRectFill([self bounds]);
}

// The purpose of this call is unfocus text views when the mouse is clicked outside.
- (void) mouseDown:(NSEvent *) theEvent
{
    [self.window makeFirstResponder:self.window.contentView];
}

@end
