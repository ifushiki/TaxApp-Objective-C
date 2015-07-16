//
//  W2ViewController2.h
//  
//
//  Created by Fushiki, Ikko on 7/14/15.
//
//

#import <Cocoa/Cocoa.h>

@interface W2ViewController2 : NSViewController <NSTextFieldDelegate>

@property (weak) IBOutlet NSImageView *imageView;

//-----------------------------------------------------------------------------------------------------------
// Employer's information
//-----------------------------------------------------------------------------------------------------------
@property (nonatomic, strong) NSTextField *box7;                // Social Sec. tips
@property (nonatomic, strong) NSTextField *box8;                // Allocated tips
@property (nonatomic, strong) NSTextField *box10;               // Dependent care benefits
@property (nonatomic, strong) NSTextField *box11;               // Nonqualfied plans
@property (nonatomic, strong) NSPopUpButton *box12LetterCode;   // Letter code
@property (nonatomic, strong) NSTextField *box12Amount;         // Box 12 amount
@property (nonatomic, strong) NSButton *box13SatutoryEmployee;  // Box 13 - Satutory employee
@property (nonatomic, strong) NSButton *box13RetirementPlan;    // Box 13 - Retirement plan
@property (nonatomic, strong) NSButton *box13ThirdPartySickPay; // Box 13 - Third-party sick pay
@property (nonatomic, strong) NSTextField *box14;               // Box 14
@property (nonatomic, strong) NSTextField *box14Amount;         // Box 14 amount

@end
