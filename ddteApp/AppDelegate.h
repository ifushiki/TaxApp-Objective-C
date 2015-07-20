//
//  AppDelegate.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/1/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSTextField *firstName;
@property (weak) IBOutlet NSTextField *lastName;
@property (weak) IBOutlet NSTextField *age;
@property (weak) IBOutlet NSButton *saveButton;
@property (weak) IBOutlet NSButton *deleteButton;
@property (weak) IBOutlet NSImageView *headerImageView;
@property (weak) IBOutlet NSImageView *w2LogoImageView;
@property (weak) IBOutlet NSButton *addNewButton;
@property (weak) IBOutlet NSPopUpButton *ddtePopup;
- (IBAction)ddtePopupPressed:(id)sender;

@property (assign) int recordIDToEdit;
@property (assign) int selectedIndex;

- (IBAction) saveRecord:(id)sender;
- (IBAction) deleteRecord:(id)sender;
- (IBAction) goToNextView:(id)sender;
- (IBAction) goToPreviousView:(id)sender;
- (IBAction) prepareNewRecord:(id)sender;

+ (void) showWarning:(NSString *) message;

@end
