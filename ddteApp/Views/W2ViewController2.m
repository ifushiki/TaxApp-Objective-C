//
//  W2ViewController2.m
//  
//
//  Created by Fushiki, Ikko on 7/14/15.
//
//

#import "W2ViewController2.h"
#import "ResourceUtil.h"

@interface W2ViewController2 ()

@property (nonatomic, strong) NSImage* image;

@end

@implementation W2ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do view setup here.
    if (self.image == nil) {
        self.image = [ResourceUtil getImage:@"TurboTax W-2 Page-2" withType:@"png"];
    }
    
    [self.imageView setImage:self.image];
    [self.imageView setNeedsDisplay:YES];
}

@end
