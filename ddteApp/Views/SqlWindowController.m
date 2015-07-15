//
//  SqlWindowController.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/15/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import "SqlWindowController.h"

@interface SqlWindowController ()

@end

@implementation SqlWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    [self.window.contentView setWantsLayer:YES];
    [self.responseView setWantsLayer:YES];
}

- (IBAction)onDoneButton:(id)sender {
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseOK];
}
@end
