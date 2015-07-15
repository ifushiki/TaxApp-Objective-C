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

#if 0
//-----------------------------------------------------------------------------------------------------------
// Employer's information
//-----------------------------------------------------------------------------------------------------------
@property (nonatomic, strong) NSTextField *boxB;                // Employer's identification number (EIN)
@property (nonatomic, strong) NSTextField *boxC;                // Employer name
@property (nonatomic, strong) NSTextField *employerNameLine2;   // Employer name line 2 (optional)
@property (nonatomic, strong) NSPopUpButton *addressType;       // Address Type as a popup button.
@property (nonatomic, strong) NSTextField *address;             // Address
@property (nonatomic, strong) NSTextField *city;                // City
@property (nonatomic, strong) NSPopUpButton *state;             // State
@property (nonatomic, strong) NSTextField *zipCode;             // ZIP code

//-----------------------------------------------------------------------------------------------------------
// Incoem & taxes withheld (Boxes 1-6)
//-----------------------------------------------------------------------------------------------------------
@property (nonatomic, strong) NSTextField *box1;                // Wages, tips, other
@property (nonatomic, strong) NSTextField *box2;                // Federal tax withheld
@property (nonatomic, strong) NSTextField *box3;                // Social Sec. wages
@property (nonatomic, strong) NSTextField *box4;                // Social Sec. tax withheld
@property (nonatomic, strong) NSTextField *box5;                // Medicare Wages
@property (nonatomic, strong) NSTextField *box6;                // Medicre tax withheld
#endif

@implementation W2ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    NSImage *image = [ResourceUtil getImage:@"TurboTax W-2 Page-1" withType:@"png"];
    
    [self.imageView setImage:image];
    [self.imageView setNeedsDisplay:YES];
    
    NSRect viewRect = self.imageView.bounds;
    
    //-----------------------------------------------------------------------------------------------------------
    // Employer's information
    //-----------------------------------------------------------------------------------------------------------

    // Box B
    float x1, x2, y1, y2;
    x1 = 107.5; y1 = 80.0;
    x2 = 521.0; y2 = 113.0;
    self.boxB = createTextField(viewRect, x1, y1, x2, y2);
    self.boxB.delegate = self;
    [self.imageView addSubview:self.boxB];
    
    // Box C
    x1 = 107.5; y1 = 217.0;
    x2 = 340.0; y2 = 249.0;
    self.boxC = createTextField(viewRect, x1, y1, x2, y2);
    self.boxC.delegate = self;
    [self.imageView addSubview:self.boxC];

    // Employer name line 2 (optional)
    x1 = 356.0; y1 = 217.0;
    x2 = 590.0; y2 = 249.0;
    self.employerNameLine2 = createTextField(viewRect, x1, y1, x2, y2);
    self.employerNameLine2.delegate = self;
    [self.imageView addSubview:self.employerNameLine2];
    
    // Address Type
    x1 = 606.0; y1 = 217.0;
    x2 = 839.9; y2 = 249.0;
    self.addressType = createPopupButton(viewRect, x1, y1, x2, y2);
    self.addressType.target = self;
    self.addressType.action = @selector(itemDidChange:);
    [self.addressType addItemWithTitle: @"U.S. Address"];
    [self.addressType addItemWithTitle: @"Canadian Address"];
    [self.imageView addSubview:self.addressType];


    // Address
    x1 = 107.5; y1 = 293.0;
    x2 = 403.5; y2 = 325.0;
    self.address = createTextField(viewRect, x1, y1, x2, y2);
    self.address.delegate = self;
    [self.imageView addSubview:self.address];
    
    // City
    x1 = 419.0; y1 = 293.0;
    x2 = 590.0; y2 = 325.0;
    self.city = createTextField(viewRect, x1, y1, x2, y2);
    self.city.delegate = self;
    [self.imageView addSubview:self.city];
    
    // State
    x1 = 606.0; y1 = 293.0;
    x2 = 715.0; y2 = 325.0;
    self.state = createPopupButton(viewRect, x1, y1, x2, y2);
    self.state.target = self;
    self.state.action = @selector(itemDidChange:);
    [self.state addItemWithTitle: @"CA"];
    [self.state addItemWithTitle: @"MA"];
    [self.imageView addSubview:self.state];

    // ZIP code
    x1 = 731.0; y1 = 293.0;
    x2 = 839.0; y2 = 325.0;
    self.zipCode = createTextField(viewRect, x1, y1, x2, y2);
    self.zipCode.delegate = self;
    [self.imageView addSubview:self.zipCode];

    //-----------------------------------------------------------------------------------------------------------
    // Incoem & taxes withheld (Boxes 1-6)
    //-----------------------------------------------------------------------------------------------------------

    // Box 1 - Wages, tips, other
    x1 = 107.5; y1 = 484.5;
    x2 = 465.5; y2 = 516.0;
    self.box1 = createTextField(viewRect, x1, y1, x2, y2);
    self.box1.delegate = self;
    [self.imageView addSubview:self.box1];
    
    // Box 2 - Federal tax withheld
    x1 = 480.5; y1 = 484.5;
    x2 = 840.0; y2 = 516.0;
    self.box2 = createTextField(viewRect, x1, y1, x2, y2);
    self.box2.delegate = self;
    [self.imageView addSubview:self.box2];

    // Box 3 - Sociel Sec. wages
    x1 = 107.5; y1 = 560.0;
    x2 = 465.5; y2 = 591.5;
    self.box3 = createTextField(viewRect, x1, y1, x2, y2);
    self.box3.delegate = self;
    [self.imageView addSubview:self.box3];
    
    // Box 4 - Social Sec. tax withheld
    x1 = 480.5; y1 = 560.0;
    x2 = 840.5; y2 = 591.5;
    self.box4 = createTextField(viewRect, x1, y1, x2, y2);
    self.box4.delegate = self;
    [self.imageView addSubview:self.box4];

    // Box 5 - Medicare Wages
    x1 = 107.5; y1 = 636.0;
    x2 = 465.5; y2 = 667.5;
    self.box5 = createTextField(viewRect, x1, y1, x2, y2);
    self.box5.delegate = self;
    [self.imageView addSubview:self.box5];
    
    // Box 6 - Mdicae tax withheld
    x1 = 480.5; y1 = 636;
    x2 = 840; y2 = 667.5;
    self.box6 = createTextField(viewRect, x1, y1, x2, y2);
    self.box6.delegate = self;
    [self.imageView addSubview:self.box6];

}


- (IBAction) itemDidChange:(id) sender
{
    NSLog(@"Calling -buttonClicked: with sender: %@", sender);
}

// NSTextFieldDelegate methods

-(void)controlTextDidEndEditing:(NSNotification *)aNotification
{
    
}

-(void)controlTextDidChange:(NSNotification *)aNotification
{
    
}

-(void)controlTextDidBeginEditing:(NSNotification *)aNotification;{
    
}

@end
