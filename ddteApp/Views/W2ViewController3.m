//
//  W2ViewController3.m
//  
//
//  Created by Fushiki, Ikko on 7/14/15.
//
//

#import "W2ViewController3.h"
#import "ResourceUtil.h"

@interface W2ViewController3 ()

@property (nonatomic, strong) NSImage* image;

@end

@implementation W2ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do view setup here.
    // Do view setup here.
    if (self.image == nil) {
        self.image = [ResourceUtil getImage:@"TurboTax W-2 Page-3" withType:@"png"];
    }
    
    [self.imageView setImage:self.image];
    [self.imageView setNeedsDisplay:YES];
}

@end
