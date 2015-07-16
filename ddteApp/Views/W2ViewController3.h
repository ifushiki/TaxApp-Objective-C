//
//  W2ViewController3.h
//  
//
//  Created by Fushiki, Ikko on 7/14/15.
//
//

#import <Cocoa/Cocoa.h>

@interface W2ViewController3 : NSViewController <NSTextFieldDelegate>

@property (weak) IBOutlet NSImageView *imageView;

//-----------------------------------------------------------------------------------------------------------
// State & local taxes (Boxes 15-20) - Leave blank if no value
//-----------------------------------------------------------------------------------------------------------
@property (nonatomic, strong) NSPopUpButton *box15;             // Box 15 - State
@property (nonatomic, strong) NSTextField *box15EmployerStateID;    // Box 15 - Employer's state ID number
@property (nonatomic, strong) NSTextField *box16;               // Box 16 - State wages, tips, etc.
@property (nonatomic, strong) NSTextField *box17;               // Box 17 - State income tax
@property (nonatomic, strong) NSTextField *box18;               // Box 18 - Local wages, tips, etc.
@property (nonatomic, strong) NSTextField *box19;               // Box 19 - Local income tax
@property (nonatomic, strong) NSTextField *box20;               // Box 20 - Locality name
@property (nonatomic, strong) NSPopUpButton *box20AssociatedState;   // Box 20 - Associated State

@end
