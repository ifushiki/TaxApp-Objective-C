//
//  W2ViewController1.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/14/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import "W2ViewController1.h"
#import "ResourceUtil.h"

@interface W2ViewController1 ()

@end

@implementation W2ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    NSImage *image = [ResourceUtil getImage:@"TurboTax W-2 Page-1" withType:@"png"];
    
    [self.imageView setImage:image];
    [self.imageView setNeedsDisplay:YES];
}

@end
