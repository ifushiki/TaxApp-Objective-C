//
//  W2FormData.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/16/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import "W2FormData.h"
#import "ResourceUtil.h"

@implementation W2FormData

// Initialization
- (instancetype) init {
    self = [super init];
    if (self) {
        
        //-----------------------------------------------------------------------------------------------------------
        // Employer's information
        //-----------------------------------------------------------------------------------------------------------
        self.boxB = nil;                                // Employer's identification number (EIN)
        self.boxC = nil;                                // Employer name
        self.employerNameLine2 = nil;                   // Employer name line 2 (optional)
        self.addressType = 0;                           // Address Type as a popup button.
        self.address = nil;                             // Address
        self.city = nil;                                // City
        self.state = kState_Unspecified;                // State
        self.zipCode = nil;                             // ZIP code
        
        //-----------------------------------------------------------------------------------------------------------
        // Incoem & taxes withheld (Boxes 1-6)
        //-----------------------------------------------------------------------------------------------------------
        self.box1 = nil;                                // Wages, tips, other
        self.box2 = nil;                                // Federal tax withheld
        self.box3 = nil;                                // Social Sec. wages
        self.box4 = nil;                                // Social Sec. tax withheld
        self.box5 = nil;                                // Medicare Wages
        self.box6 = nil;                                // Medicre tax withheld
        
        //-----------------------------------------------------------------------------------------------------------
        // Employer's information
        //-----------------------------------------------------------------------------------------------------------
        self.box7 = nil;                                // Social Sec. tips
        self.box8 = nil;                                // Allocated tips
        self.box10 = nil;                               // Dependent care benefits
        self.box11 = nil;                               // Nonqualfied plans
        self.box12LetterCode = kLetterCode_Unspecified; // Letter code
        self.box12Amount = nil;                         // Box 12 amount
        self.box13SatutoryEmployee = NO;                // Box 13 - Satutory employee is unchecked.
        self.box13RetirementPlan = NO;                  // Box 13 - Retirement plan is unchecked.
        self.box13ThirdPartySickPay = NO;               // Box 13 - Third-party sick pay
        self.box14 = nil;                               // Box 14
        self.box14Amount = nil;                         // Box 14 amount
        
        //-----------------------------------------------------------------------------------------------------------
        // State & local taxes (Boxes 15-20) - Leave blank if no value
        //-----------------------------------------------------------------------------------------------------------
        self.box15 = kState_Unspecified;                // Box 15 - State
        self.box15EmployerStateID = nil;                // Box 15 - Employer's state ID number
        self.box16 = nil;                               // Box 16 - State wages, tips, etc.
        self.box17 = nil;                               // Box 17 - State income tax
        self.box18 = nil;                               // Box 18 - Local wages, tips, etc.
        self.box19 = nil;                               // Box 19 - Local income tax
        self.box20 = nil;                               // Box 20 - Locality name
        self.box20AssociatedState = kState_Unspecified; // Box 20 - Associated State
        
    }
    return self;
}

+ (id)sharedData {
    static W2FormData *sharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[self alloc] init];
    });
    return sharedData;
}

- (BOOL) setFormString:(NSString *) str withFormDataID:(W2FormDataID) dataID
{
    // To be implemented.
    BOOL isValidID = NO;
    return isValidID;
}
- (NSString *) getFormString:(W2FormDataID) dataID
{
    // To be implemented.
    return nil;
}

@end
