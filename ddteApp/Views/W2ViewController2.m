//
//  W2ViewController2.m
//  
//
//  Created by Fushiki, Ikko on 7/14/15.
//
//

#import "W2ViewController2.h"
#import "ResourceUtil.h"
#import "W2FormManager.h"
#import "AppDelegate.h"

@interface W2ViewController2 ()

@property (nonatomic, strong) NSImage* image;

@end

@implementation W2ViewController2

// Adds letter cocdes (Box 12) to the given popup menu.
void addLetterCode(NSPopUpButton *popupButton)
{
    [popupButton addItemWithTitle: @"Select a code"];
    [popupButton addItemWithTitle: @"A"];
    [popupButton addItemWithTitle: @"B"];
    [popupButton addItemWithTitle: @"C"];
    [popupButton addItemWithTitle: @"D"];
    [popupButton addItemWithTitle: @"E"];
    [popupButton addItemWithTitle: @"F"];
    [popupButton addItemWithTitle: @"G"];
    [popupButton addItemWithTitle: @"H"];
    [popupButton addItemWithTitle: @"J"];
    [popupButton addItemWithTitle: @"K"];
    [popupButton addItemWithTitle: @"L"];
    [popupButton addItemWithTitle: @"M"];
    [popupButton addItemWithTitle: @"N"];
    [popupButton addItemWithTitle: @"P"];
    [popupButton addItemWithTitle: @"Q"];
    [popupButton addItemWithTitle: @"R"];
    [popupButton addItemWithTitle: @"S"];
    [popupButton addItemWithTitle: @"T"];
    [popupButton addItemWithTitle: @"V"];
    [popupButton addItemWithTitle: @"W"];
    [popupButton addItemWithTitle: @"Y"];
    [popupButton addItemWithTitle: @"Z"];
    [popupButton addItemWithTitle: @"AA"];
    [popupButton addItemWithTitle: @"BB"];
    [popupButton addItemWithTitle: @"DD"];
    [popupButton addItemWithTitle: @"EE"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do view setup here.
    if (self.image == nil) {
        self.image = [ResourceUtil getImage:@"TurboTax W-2 Page-2" withType:@"png"];
    }
    
    [self.imageView setImage:self.image];
    [self.imageView setNeedsDisplay:YES];
    
    NSRect viewRect = self.imageView.bounds;
    
    //-----------------------------------------------------------------------------------------------------------
    // Less common items (Boxes 7 - 14) - Leave blank if no value
    //-----------------------------------------------------------------------------------------------------------
    
    // Box 7 - Social Sec. tips
    float x1, x2, y1, y2;
    x1 = 107.5; y1 = 125.0;
    x2 = 465.0; y2 = 156.0;
    self.box7 = createTextField(viewRect, x1, y1, x2, y2);
    self.box7.delegate = self;
    [self.imageView addSubview:self.box7];
    
    // Box 8 - Allocated tips
    x1 = 481.0; y1 = 123.0;
    x2 = 840.0; y2 = 156.0;
    self.box8 = createTextField(viewRect, x1, y1, x2, y2);
    self.box8.delegate = self;
    [self.imageView addSubview:self.box8];
    
    // Box 10 - Dependent care benefits
    x1 = 107.0; y1 = 200.0;
    x2 = 465.0; y2 = 231.0;
    self.box10 = createTextField(viewRect, x1, y1, x2, y2);
    self.box10.delegate = self;
    [self.imageView addSubview:self.box10];
    
    // Box 11 - Nonqualified plans
    x1 = 480.0; y1 = 200.0;
    x2 = 840.0; y2 = 231.0;
    self.box11 = createTextField(viewRect, x1, y1, x2, y2);
    self.box11.delegate = self;
    [self.imageView addSubview:self.box11];
    
    // Box 12a-12d Letter code
    x1 = 144.0; y1 = 338.0;
    x2 = 307.0; y2 = 368.0;
    self.box12LetterCode = createPopupButton(viewRect, x1, y1, x2, y2);
    self.box12LetterCode.target = self;
    self.box12LetterCode.action = @selector(itemDidChange:);
    addLetterCode(self.box12LetterCode);
    [self.imageView addSubview:self.box12LetterCode];
    
    // Box 12 Amount
    x1 = 324.0; y1 = 337.0;
    x2 = 456.0; y2 = 368.0;
    self.box12Amount = createTextField(viewRect, x1, y1, x2, y2);
    self.box12Amount.delegate = self;
    [self.imageView addSubview:self.box12Amount];
    
    // Box 13 (3 check buttons)
    x1 = 481.0; y1 = 343.0;
    x2 = 491.0; y2 = 353.0;
    self.box13SatutoryEmployee = createCheckBox(viewRect, x1, y1, x2, y2);
    self.box13SatutoryEmployee.target = self;
    self.box13SatutoryEmployee.action = @selector(checkBoxClicked:);
    [self.imageView addSubview:self.box13SatutoryEmployee];

    x1 = 481.0; y1 = 370.0;
    x2 = 491.0; y2 = 380.0;
    self.box13RetirementPlan = createCheckBox(viewRect, x1, y1, x2, y2);
    self.box13RetirementPlan.target = self;
    self.box13RetirementPlan.action = @selector(checkBoxClicked:);
    [self.imageView addSubview:self.box13RetirementPlan];

    x1 = 481.0; y1 = 397.0;
    x2 = 491.0; y2 = 407.0;
    self.box13ThirdPartySickPay = createCheckBox(viewRect, x1, y1, x2, y2);
    self.box13ThirdPartySickPay.target = self;
    self.box13ThirdPartySickPay.action = @selector(checkBoxClicked:);
    [self.imageView addSubview:self.box13ThirdPartySickPay];

    // Box 14
    x1 = 107.0; y1 = 526.0;
    x2 = 340.0; y2 = 558.0;
    self.box14 = createTextField(viewRect, x1, y1, x2, y2);
    self.box14.delegate = self;
    [self.imageView addSubview:self.box14];
    
    // Box 14 Amount
    x1 = 356.0; y1 = 525.0;
    x2 = 590.0; y2 = 558.0;
    self.box14Amount = createTextField(viewRect, x1, y1, x2, y2);
    self.box14Amount.delegate = self;
    [self.imageView addSubview:self.box14Amount];
}

- (IBAction) itemDidChange:(id) sender
{
    W2FormManager* w2Form = [W2FormManager sharedMgr];
    if (w2Form == nil) {
        NSLog(@"Failed in getting the shared W2 data");
    }
    W2FormDataID dataID = W2FormData_InvalidID;
    int selectedID = 0;
    
    if (sender == self.box12LetterCode) {
        dataID = W2FormData_box12LetterCode;
        // Need fine the selected ID.
        NSLog(@"box12LetterCode has changed.");
    }
    else {
        NSLog(@"An other popup button is selected.");
    }

    if (dataID != W2FormData_InvalidID) {
        CGPoint pt = getOrigin((NSView *) sender);
        if ([w2Form setFormSelection:selectedID withFormDataID:dataID at:pt] == NO) {
            NSLog(@"setFormSelection: Failed in setting status for check box ID = %d", dataID);
        }
    }
}

- (IBAction) checkBoxClicked:(id) sender
{
    W2FormManager* w2Form = [W2FormManager sharedMgr];
    if (w2Form == nil) {
        NSLog(@"Failed in getting the shared W2 data");
    }
    W2FormDataID dataID = W2FormData_InvalidID;
    
    if (sender == self.box13SatutoryEmployee) {
        dataID = W2FormData_box13SatutoryEmployee;
        NSLog(@"box13SatutoryEmployee is clicked.");
    }
    else if (sender == self.box13RetirementPlan) {
        dataID = W2FormData_box13RetirementPlan;
        NSLog(@"box13RetirementPlan is clicked.");
    }
    else if (sender == self.box13ThirdPartySickPay) {
        dataID = W2FormData_box13ThirdPartySickPay;
        NSLog(@"box13ThirdPartySickPay is clicked.");
    }
    else {
        NSLog(@"An other check box is clicked.");
    }
    
    CGPoint pt = getOrigin((NSView *) sender);

    // Test method to show warning.
    [AppDelegate showWarning:@"Please check your input." at:pt];

    if (dataID != W2FormData_InvalidID) {
        NSInteger checkBoxStatus = [sender state];
        if (checkBoxStatus == NSOnState) {
            NSLog(@"Check box is selected.");
        }
        if (checkBoxStatus == NSOffState) {
            NSLog(@"Check box is unselected.");
        }
        if (checkBoxStatus == NSMixedState) {
            NSLog(@"Check box: mixed state.");
        }
        else {
            NSLog(@"Check box: Unknown state.");
        }
        
        CGPoint pt = getOrigin((NSView *) sender);
        W2Error w2Error = [w2Form setFormCheckBoxStatus:checkBoxStatus withFormDataID:dataID at:pt];
        switch (w2Error) {
            case kW2Error_OK:
                // The result is OK.  Nothing more to do.
                break;
                
            case kW2Error_Warning:
                // Needs to show a warning.
                break;
                
            case kW2Error_Invalid:
                // Invalid data.
                NSLog(@"setFormCheckBosStatis: Failed in setting status for check box ID = %d", dataID);
                break;
                
            default:
                break;
        }
    }
}

// NSTextFieldDelegate methods

// controlTextDidEndEditing is called when the focus changes from the current field to othe field.
-(void)controlTextDidEndEditing:(NSNotification *)aNotification
{
    W2FormManager* w2Form = [W2FormManager sharedMgr];
    if (w2Form == nil) {
        NSLog(@"Failed in getting the shared W2 data");
    }
    
    W2FormDataID dataID = W2FormData_InvalidID;
    NSString *str = nil;

    NSTextField* textField = (NSTextField *)[aNotification object];
    if (textField == self.box7) {
        dataID = W2FormData_box7;
        str = [self.box7 stringValue];
        NSLog(@"box7 was edited");
    }
    else if (textField == self.box8) {
        dataID = W2FormData_box8;
        str = [self.box8 stringValue];
        NSLog(@"box8 was edited");
    }
    else if (textField == self.box10) {
        dataID = W2FormData_box10;
        str = [self.box10 stringValue];
        NSLog(@"box10 was edited");
    }
    else if (textField == self.box11) {
        dataID = W2FormData_box11;
        str = [self.box11 stringValue];
        NSLog(@"box11 was edited");
    }
    else if (textField == self.box12Amount) {
        dataID = W2FormData_box12Amount;
        str = [self.box12Amount stringValue];
        NSLog(@"box12Amount was edited");
    }
    else if (textField == self.box14) {
        dataID = W2FormData_box14;
        str = [self.box14 stringValue];
        NSLog(@"box14 was edited");
    }
    else if (textField == self.box14Amount) {
        dataID = W2FormData_box14Amount;
        str = [self.box14Amount stringValue];
        NSLog(@"box14Amount was edited");
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
