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
    
    // Add check boxes

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
