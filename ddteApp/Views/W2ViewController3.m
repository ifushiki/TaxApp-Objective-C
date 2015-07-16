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

    float x1, x2, y1, y2;
    NSRect viewRect = self.imageView.bounds;
    
    //-----------------------------------------------------------------------------------------------------------
    // State & local taxes (Boxes 15-20) - Leave blank if no value
    //-----------------------------------------------------------------------------------------------------------

    // Box 15 - State
    x1 = 107.0; y1 = 132.0;
    x2 = 215.0; y2 = 164.0;
    self.box15 = createPopupButton(viewRect, x1, y1, x2, y2);
    self.box15.target = self;
    self.box15.action = @selector(itemDidChange:);
    addStatesToPopUpMenu(self.box15);
    [self.imageView addSubview:self.box15];

    // Box 15 - Employer's state ID number
    x1 = 231.0; y1 = 132.0;
    x2 = 465.0; y2 = 164.0;
    self.box15EmployerStateID = createTextField(viewRect, x1, y1, x2, y2);
    self.box15EmployerStateID.delegate = self;
    [self.imageView addSubview:self.box15EmployerStateID];
    
    // Box 16 - State wages, tips, etc.
    x1 = 481.0; y1 = 132.0;
    x2 = 652.0; y2 = 164.0;
    self.box16 = createTextField(viewRect, x1, y1, x2, y2);
    self.box16.delegate = self;
    [self.imageView addSubview:self.box16];
    
    // Box 17 - State income tax
    x1 = 667.0; y1 = 132.0;
    x2 = 839.0; y2 = 164.0;
    self.box17 = createTextField(viewRect, x1, y1, x2, y2);
    self.box17.delegate = self;
    [self.imageView addSubview:self.box17];
    
    // Box 18 - Local wages, tips, etc.
    x1 = 107.0; y1 = 245.0;
    x2 = 278.0; y2 = 278.0;
    self.box18 = createTextField(viewRect, x1, y1, x2, y2);
    self.box18.delegate = self;
    [self.imageView addSubview:self.box18];
    
    // Box 19 - Local income tax
    x1 = 293.0; y1 = 244.0;
    x2 = 456.0; y2 = 277.0;
    self.box19 = createTextField(viewRect, x1, y1, x2, y2);
    self.box19.delegate = self;
    [self.imageView addSubview:self.box19];
    
    // Box 20 - Locality name
    x1 = 481.0; y1 = 245.0;
    x2 = 653.0; y2 = 277.0;
    self.box20 = createTextField(viewRect, x1, y1, x2, y2);
    self.box20.delegate = self;
    [self.imageView addSubview:self.box20];

    // Box 20 - Associated State
    x1 = 668.0; y1 = 245.0;
    x2 = 841.0; y2 = 277.0;
    self.box20AssociatedState = createPopupButton(viewRect, x1, y1, x2, y2);
    self.box20AssociatedState.target = self;
    self.box20AssociatedState.action = @selector(itemDidChange:);
    addStatesToPopUpMenu(self.box20AssociatedState);
    [self.imageView addSubview:self.box20AssociatedState];
}

- (IBAction) itemDidChange:(id) sender
{
    NSLog(@"Calling -buttonClicked: with sender: %@", sender);
}

@end
