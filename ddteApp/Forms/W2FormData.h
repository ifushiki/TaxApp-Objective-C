//
//  W2FormData.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/16/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import <Foundation/Foundation.h>

// Box 12 Letter Code
// This is the same as index id of the popup menu in Box 12.
enum {
    kLetterCode_Unspecified = 0,
    kLetterCode_A,
    kLetterCode_B,
    kLetterCode_C,
    kLetterCode_D,
    kLetterCode_E,
    kLetterCode_F,
    kLetterCode_G,
    kLetterCode_H,
    kLetterCode_J,
    kLetterCode_K,
    kLetterCode_L,
    kLetterCode_M,
    kLetterCode_N,
    kLetterCode_P,
    kLetterCode_Q,
    kLetterCode_R,
    kLetterCode_S,
    kLetterCode_T,
    kLetterCode_V,
    kLetterCode_W,
    kLetterCode_Y,
    kLetterCode_Z,
    kLetterCode_AA,
    kLetterCode_BB,
    kLetterCode_DD,
    kLetterCode_EE,
};

typedef enum {
    W2FormData_InvalidID = 0,
    W2FormData_boxB,                  // Employer's identification number (EIN)
    W2FormData_boxC,                  // Employer name
    W2FormData_employerNameLine2,     // Employer name line 2 (optional)
    W2FormData_addressType,            // Address Type as a popup button.
    W2FormData_address,               // Address
    W2FormData_city,                  // City
    W2FormData_state,                  // State
    W2FormData_zipCode,               // ZIP code
    
    //-----------------------------------------------------------------------------------------------------------
    // Incoem & taxes withheld (Boxes 1-6)
    //-----------------------------------------------------------------------------------------------------------
    W2FormData_box1,                  // Wages, tips, other
    W2FormData_box2,                  // Federal tax withheld
    W2FormData_box3,                  // Social Sec. wages
    W2FormData_box4,                  // Social Sec. tax withheld
    W2FormData_box5,                  // Medicare Wages
    W2FormData_box6,                  // Medicre tax withheld
    
    //-----------------------------------------------------------------------------------------------------------
    // Employer's information
    //-----------------------------------------------------------------------------------------------------------
    W2FormData_box7,                  // Social Sec. tips
    W2FormData_box8,                  // Allocated tips
    W2FormData_box10,                 // Dependent care benefits
    W2FormData_box11,                 // Nonqualfied plans
    W2FormData_box12LetterCode,        // Letter code
    W2FormData_box12Amount,           // Box 12 amount
    W2FormData_box13SatutoryEmployee,  // Box 13 - Satutory employee
    W2FormData_box13RetirementPlan,    // Box 13 - Retirement plan
    W2FormData_box13ThirdPartySickPay, // Box 13 - Third-party sick pay
    W2FormData_box14,                 // Box 14
    W2FormData_box14Amount,           // Box 14 amount
    
    //-----------------------------------------------------------------------------------------------------------
    // State & local taxes (Boxes 15-20) - Leave blank if no value
    //-----------------------------------------------------------------------------------------------------------
    W2FormData_box15,                  // Box 15 - State
    W2FormData_box15EmployerStateID,  // Box 15 - Employer's state ID number
    W2FormData_box16,                 // Box 16 - State wages, tips, etc.
    W2FormData_box17,                 // Box 17 - State income tax
    W2FormData_box18,                 // Box 18 - Local wages, tips, etc.
    W2FormData_box19,                 // Box 19 - Local income tax
    W2FormData_box20,                 // Box 20 - Locality name
    W2FormData_box20AssociatedState,  // Box 20 - Associated State
} W2FormDataID;

@interface W2FormData : NSObject

+ (id)sharedData;

- (BOOL) setFormString:(NSString *) str withFormDataID:(W2FormDataID) dataID;
- (NSString *) getFormString:(W2FormDataID) dataID;


//-----------------------------------------------------------------------------------------------------------
// Employer's information
//-----------------------------------------------------------------------------------------------------------
@property (nonatomic, strong) NSString  *boxB;                  // Employer's identification number (EIN)
@property (nonatomic, strong) NSString  *boxC;                  // Employer name
@property (nonatomic, strong) NSString  *employerNameLine2;     // Employer name line 2 (optional)
@property (nonatomic)         int       addressType;            // Address Type as a popup button.
@property (nonatomic, strong) NSString  *address;               // Address
@property (nonatomic, strong) NSString  *city;                  // City
@property (nonatomic)         int       state;                  // State
@property (nonatomic, strong) NSString  *zipCode;               // ZIP code

//-----------------------------------------------------------------------------------------------------------
// Incoem & taxes withheld (Boxes 1-6)
//-----------------------------------------------------------------------------------------------------------
@property (nonatomic, strong) NSString  *box1;                  // Wages, tips, other
@property (nonatomic, strong) NSString  *box2;                  // Federal tax withheld
@property (nonatomic, strong) NSString  *box3;                  // Social Sec. wages
@property (nonatomic, strong) NSString  *box4;                  // Social Sec. tax withheld
@property (nonatomic, strong) NSString  *box5;                  // Medicare Wages
@property (nonatomic, strong) NSString  *box6;                  // Medicre tax withheld

//-----------------------------------------------------------------------------------------------------------
// Employer's information
//-----------------------------------------------------------------------------------------------------------
@property (nonatomic, strong) NSString  *box7;                  // Social Sec. tips
@property (nonatomic, strong) NSString  *box8;                  // Allocated tips
@property (nonatomic, strong) NSString  *box10;                 // Dependent care benefits
@property (nonatomic, strong) NSString  *box11;                 // Nonqualfied plans
@property (nonatomic)         int       box12LetterCode;        // Letter code
@property (nonatomic, strong) NSString  *box12Amount;           // Box 12 amount
@property (nonatomic)         BOOL      box13SatutoryEmployee;  // Box 13 - Satutory employee
@property (nonatomic)         BOOL      box13RetirementPlan;    // Box 13 - Retirement plan
@property (nonatomic)         BOOL      box13ThirdPartySickPay; // Box 13 - Third-party sick pay
@property (nonatomic, strong) NSString  *box14;                 // Box 14
@property (nonatomic, strong) NSString  *box14Amount;           // Box 14 amount

//-----------------------------------------------------------------------------------------------------------
// State & local taxes (Boxes 15-20) - Leave blank if no value
//-----------------------------------------------------------------------------------------------------------
@property (nonatomic) int               box15;                  // Box 15 - State
@property (nonatomic, strong) NSString  *box15EmployerStateID;  // Box 15 - Employer's state ID number
@property (nonatomic, strong) NSString  *box16;                 // Box 16 - State wages, tips, etc.
@property (nonatomic, strong) NSString  *box17;                 // Box 17 - State income tax
@property (nonatomic, strong) NSString  *box18;                 // Box 18 - Local wages, tips, etc.
@property (nonatomic, strong) NSString  *box19;                 // Box 19 - Local income tax
@property (nonatomic, strong) NSString  *box20;                 // Box 20 - Locality name
@property (nonatomic)         int       box20AssociatedState;  // Box 20 - Associated State

@end
