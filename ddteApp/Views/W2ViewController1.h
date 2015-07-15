//
//  W2ViewController1.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/14/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface W2ViewController1 : NSViewController <NSTextFieldDelegate>

- (IBAction) itemDidChange: (id) sender;

@property (weak) IBOutlet NSImageView *imageView;

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

@end
