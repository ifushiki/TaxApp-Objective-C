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

    NSImage *headerImage = [ResourceUtil getImage:@"TurboTax W-2 Header" withType:@"png"];
    NSImage *w2LogoImage = [ResourceUtil getImage:@"TurboTax W-2 Logo" withType:@"png"];
    NSImage *leftArrowImage = [ResourceUtil getImage:@"left-arrow" withType:@"png"];
    NSImage *rightArrowImage = [ResourceUtil getImage:@"right-arrow" withType:@"png"];
//    NSImageView* headerImageView = createImageView(viewRect, 0, 0, 1045, 48);
//    NSImageView* w2LogoImageView = createImageView(viewRect, 849, 0, 987, 138);
    NSImageView* leftArrowImageView = createImageView(viewRect, 600, 0, 680, 80);
    NSImageView* rightArrowImageView = createImageView(viewRect, 700, 0, 780, 80);
//    [headerImageView setImage:headerImage];
    [self.headerView setImage:headerImage];
    [self.w2LogoView setImage:w2LogoImage];
//    [w2LogoImageView setImage:w2LogoImage];
    [leftArrowImageView setImage:leftArrowImage];
    [rightArrowImageView setImage:rightArrowImage];
//    [self.imageView addSubview:headerImageView];
//    [self.imageView addSubview:w2LogoImageView];
    
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
    // Extra fields needed for Query (Boxes 0)
    //-----------------------------------------------------------------------------------------------------------

    // Box 0 - Age
    x1 = 481; y1 = 403;
    x2 = 590; y2 = 436;
    self.box0_Age = createTextField(viewRect, x1, y1, x2, y2);
    self.box0_Age.delegate = self;
    [self.imageView addSubview:self.box0_Age];
    

    // Box 0 - Occupation
    x1 = 611; y1 = 403;
    x2 = 844; y2 = 435;
    self.box0_Occupation = createPopupButton(viewRect, x1, y1, x2, y2);
    self.box0_Occupation.target = self;
    self.box0_Occupation.action = @selector(itemDidChange:);
    addOccupationsToPopUpMenu(self.box0_Occupation);
    [self.imageView addSubview:self.box0_Occupation];

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
    
    [self loadData];
}

- (void) setInitialData
{
    W2FormManager* w2Form = [W2FormManager sharedMgr];
    if (w2Form == nil) {
        NSLog(@"Failed in getting the shared W2 data");
        return;
    }

    [w2Form setDataString:@"12-3456789" withFormDataID:W2FormData_boxB];
    [w2Form setDataString:@"Intuit Corporation" withFormDataID:W2FormData_boxC];
    [w2Form setDataString:@"2700 Coast Ave" withFormDataID:W2FormData_address];
    [w2Form setDataString:@"Mountian View" withFormDataID:W2FormData_city];
    [w2Form setDataSelection:kState_California withFormDataID:W2FormData_state];
    [w2Form setDataString:@"94043" withFormDataID:W2FormData_zipCode];
}

- (void) reloadData
{
    W2FormManager* w2Form = [W2FormManager sharedMgr];
    if (w2Form == nil) {
        NSLog(@"Failed in getting the shared W2 data");
        return;
    }
    NSString *str;
    str = [w2Form getFormString:W2FormData_boxB];
    if (str)
        self.boxB.stringValue = str;

    str = [w2Form getFormString:W2FormData_boxC];
    if (str)
        self.boxC.stringValue = str;
    
    str = [w2Form getFormString:W2FormData_employerNameLine2];
    if (str)
        self.employerNameLine2.stringValue = str;

    [self.addressType selectItemAtIndex:[w2Form getFormSelection:W2FormData_addressType]]; // Start at US address.

    str = [w2Form getFormString:W2FormData_address];
    if (str)
        self.address.stringValue = str;
    
    str = [w2Form getFormString:W2FormData_city];
    if (str)
        self.city.stringValue = str;
    
    [self.state selectItemAtIndex:[w2Form getFormSelection:W2FormData_state]]; // Start at US address.

    str = [w2Form getFormString:W2FormData_zipCode];
    if (str)
        self.zipCode.stringValue = str;
    
    str = [w2Form getFormString:W2FormData_box0_Age];
    if (str)
        self.box0_Age.stringValue = str;
    
    str = [w2Form getFormString:W2FormData_box1];
    if (str)
        self.box1.stringValue = str;
    
    str = [w2Form getFormString:W2FormData_box2];
    if (str)
        self.box2.stringValue = str;
    
    str = [w2Form getFormString:W2FormData_box3];
    if (str)
        self.box3.stringValue = str;
    
    str = [w2Form getFormString:W2FormData_box4];
    if (str)
        self.box4.stringValue = str;
    
    str = [w2Form getFormString:W2FormData_box5];
    if (str)
        self.box5.stringValue = str;
    
    str = [w2Form getFormString:W2FormData_box6];
    if (str)
        self.box6.stringValue = str;
    
    [self.imageView setNeedsDisplay:YES];
 }

- (void) loadData
{
    [self setInitialData];
    [self reloadData];
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
    else if (sender== self.box0_Occupation) {
        dataID = W2FormData_box0_Occupation;
        NSString *title = self.box0_Occupation.titleOfSelectedItem;
        [w2Form setOccupationString:title];
        
        NSLog(@"box0_Occupation has changed.");
    }
    else {
        NSLog(@"An other popup button is selected.");
    }

    if (dataID != W2FormData_InvalidID) {
        selectedID = (int) [(NSPopUpButton *) sender indexOfSelectedItem];
        CGPoint pt = getOrigin((NSView *) sender);
        if ([w2Form setFormSelection:selectedID withFormDataID:dataID at:pt] == NO) {
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
    else if (textField == self.box0_Age) {
        dataID = W2FormData_box0_Age;
        str = [self.box0_Age stringValue];
        NSLog(@"box0_Age was edited");
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
        CGPoint pt = getOrigin(textField);
        W2Error w2Error = [w2Form setFormString:str withFormDataID:dataID at:pt];
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
