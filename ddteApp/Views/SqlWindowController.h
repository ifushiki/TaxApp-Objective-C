//
//  SqlWindowController.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/15/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SqlResponseView.h"

@interface SqlWindowController : NSWindowController

@property (weak) IBOutlet SqlResponseView *responseView;

- (IBAction)onDoneButton:(id)sender;

@end
