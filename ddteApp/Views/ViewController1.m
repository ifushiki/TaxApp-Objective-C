//
//  ViewController1.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/13/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import "ViewController1.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self.view setWantsLayer:YES];


    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue = [NSNumber numberWithFloat:1.0];
    fadeAnim.toValue = [NSNumber numberWithFloat:0.0];
    fadeAnim.duration = 5.0;
    CALayer *theLayer = [self.view layer];
    [theLayer addAnimation:fadeAnim forKey:@"opacity"];
    
    // Change the actual data value in the layer to the final value.
    theLayer.opacity = 0.0;
}

@end
