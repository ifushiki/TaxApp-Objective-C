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
//    [[NSColor greenColor] set];
//    NSRectFill([self bounds]);
}

// The purpose of this call is unfocus text views when the mouse is clicked outside.
- (void) mouseDown:(NSEvent *) theEvent
{
    [self.window makeFirstResponder:self.window.contentView];
}

@end
