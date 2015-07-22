//
//  ResourceUtil.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/14/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import <Foundation/Foundation.h>


// x1, y1,, x2, y2 are defined as top left as the zeros.
NSTextField * createTextField(NSRect parentsBounds, float x1, float y1, float x2, float y2);

// Create a popup button with the given boundary (in topLeft corner as zero).
NSPopUpButton * createPopupButton(NSRect parentsBounds, float x1, float y1, float x2, float y2);

// Create a checkbox with the given boundary (in topLeft corner as zero).
NSButton * createCheckBox(NSRect parentsBounds, float x1, float y1, float x2, float y2);

// Create an image view with the given boundary (in topLeft corner as zero).
NSImageView* createImageView(NSRect parentsBounds, float x1, float y1, float x2, float y2);

// Adds State Abbreviation codes to the given popup menu.
void addStatesToPopUpMenu(NSPopUpButton *popupButton);

// Adds Occupation names to the given popup menu.
void addOccupationsToPopUpMenu(NSPopUpButton *popupButton);

// This returns the origin of the view relative to the containing window.
CGPoint getOrigin(NSView *view);

@interface ResourceUtil : NSObject

+ (NSImage *) getImage:(NSString *) imageName withType:(NSString *) type;

@end
