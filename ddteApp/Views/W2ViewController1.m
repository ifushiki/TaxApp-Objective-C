//
//  W2ViewController1.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/14/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import "W2ViewController1.h"
#import "ResourceUtil.h"
#import "W2FormManager.h"

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
    [self.addressType addItemWithTitle:@"Select address type"];
    [self.addressType addItemWithTitle: @"U.S. Address"];
    [self.addressType addItemWithTitle: @"Canadian Address"];
    [self.addressType selectItemAtIndex:1]; // Start at US address.
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
    addStatesToPopUpMenu(self.state);
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
    W2FormManager* w2Form = [W2FormManager sharedMgr];
    if (w2Form == nil) {
        NSLog(@"Failed in getting the shared W2 data");
    }
    W2FormDataID dataID = W2FormData_InvalidID;
    int selectedID = 0;
    
    if (sender == self.addressType) {
        dataID = W2FormData_addressType;
        // Need fine the selected ID.
        NSLog(@"addressType has changed.");
    }
    else if (sender== self.state) {
        dataID = W2FormData_state;
        // Need fine the selected ID.
        NSLog(@"state has changed.");
    }
    else {
        NSLog(@"An other popup button is selected.");
    }

    if (dataID != W2FormData_InvalidID) {
        selectedID = (int) [(NSPopUpButton *) sender indexOfSelectedItem];
        CGPoint topLeftPt = getTopLeft((NSView *) sender);
        if ([w2Form setFormSelection:selectedID withFormDataID:dataID at:topLeftPt] == NO) {
            NSLog(@"setFormSelection: Failed in setting status for check box ID = %d", dataID);
        }
    }
}

// controlTextDidEndEditing is called when the focus is changed from the current field to an other field or
// the user clicked outside of any controls.
-(void)controlTextDidEndEditing:(NSNotification *)aNotification
{
    W2FormManager* w2Form = [W2FormManager sharedMgr];
    if (w2Form == nil) {
        NSLog(@"Failed in getting the shared W2 data");
    }
    W2FormDataID dataID = W2FormData_InvalidID;

    NSString *str = nil;
    NSTextField* textField = (NSTextField *)[aNotification object];

    if (textField == self.boxB) {
        dataID = W2FormData_boxB;
        str = [self.boxB stringValue];
        NSLog(@"boxB was edited");
    }
    else if (textField == self.boxC) {
        dataID = W2FormData_boxC;
        str = [self.boxC stringValue];
        NSLog(@"boxC was edited");
    }
    else if (textField == self.employerNameLine2) {
        dataID = W2FormData_employerNameLine2;
        str = [self.employerNameLine2 stringValue];
        NSLog(@"employerNameLine2 was edited");
    }
    else if (textField == self.address) {
        dataID = W2FormData_address;
        str = [self.address stringValue];
        NSLog(@"address was edited");
    }
    else if (textField == self.city) {
        dataID = W2FormData_city;
        str = [self.city stringValue];
        NSLog(@"city was edited");
    }
    else if (textField == self.zipCode) {
        dataID = W2FormData_zipCode;
        str = [self.zipCode stringValue];
        NSLog(@"zipCode was edited");
    }
    else if (textField == self.box1) {
        dataID = W2FormData_box1;
        str = [self.box1 stringValue];
        NSLog(@"box1 was edited");
    }
    else if (textField == self.box2) {
        dataID = W2FormData_box2;
        str = [self.box2 stringValue];
        NSLog(@"box2 was edited");
    }
    else if (textField == self.box3) {
        dataID = W2FormData_box3;
        str = [self.box3 stringValue];
        NSLog(@"box3 was edited");
    }
    else if (textField == self.box4) {
        dataID = W2FormData_box4;
        str = [self.box4 stringValue];
        NSLog(@"box4 was edited");
    }
    else if (textField == self.box5) {
        dataID = W2FormData_box5;
        str = [self.box5 stringValue];
        NSLog(@"box5 was edited");
    }
    else if (textField == self.box6) {
        dataID = W2FormData_box6;
        str = [self.box6 stringValue];
        NSLog(@"box6 was edited");
    }
    else {
        NSLog(@"An other text field is selected.");
    }
    
    if (str) {
        CGPoint topLeftPt = getTopLeft(textField);
        W2Error w2Error = [w2Form setFormString:str withFormDataID:dataID at:topLeftPt];
        switch (w2Error) {
            case kW2Error_OK:
                // The result is OK.  Nothing more to do.
                break;
            
            case kW2Error_Warning:
                // Needs to show a warning.
                break;
                
            case kW2Error_Invalid:
                // Invalid data.
                NSLog(@"setFormString: Failed in setting text for text fiele ID = %d", dataID);
                break;
                
            default:
                break;
        }
    }
}

// controlTextDidChange message will be called when a string is changed even during typing.
-(void)controlTextDidChange:(NSNotification *)aNotification
{
    
}

-(void)controlTextDidBeginEditing:(NSNotification *)aNotification;{
    
}

@end
