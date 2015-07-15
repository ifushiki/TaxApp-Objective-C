//
//  DdteWindowController.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/15/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DdteResponseView.h"

@interface DdteWindowController : NSWindowController

@property (weak) IBOutlet DdteResponseView *responseView;

- (IBAction)onDoneButton:(id)sender;

@end
