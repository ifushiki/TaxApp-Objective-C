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

// Adds State Abbreviation codes to the given popup menu.
void addStatesToPopUpMenu(NSPopUpButton *popupButton);

// This matches with the index ID of State popup menu.
enum {
    kState_Unspecified = 0,
    kState_Alabama,
    kState_Alaska,
    kState_Arizona,
    kState_Arkansas,
    kState_California,
    kState_Colorado,
    kState_Connecticut,
    kState_Delaware,
    kState_Florida,
    kState_Georgia,
    
    kState_Hawaii,
    kState_Idaho,
    kState_Illinois,
    kState_Indiana,
    kState_Iowa,
    kState_Kansas,
    kState_Kentucky,
    kState_Louisiana,
    kState_Maine,
    kState_Maryland,
    
    kState_Massachussetts,
    kState_Michigan,
    kState_Minnesota,
    kState_Mississippi,
    kState_Missouri,
    kState_Montana,
    kState_Nebraska,
    kState_Nevada,
    kState_NewHampshire,
    kState_NewJersey,
    
    kState_NewMexico,
    kState_NewYork,
    kState_NorthCarolina,
    kState_NorthDakoda,
    kState_Ohio,
    kState_Oklahoma,
    kState_Oregon,
    kState_Pennsylvania,
    kState_RhodoIsland,
    kState_SouthCarolina,
    
    kState_SouthDakota,
    kState_Tennessee,
    kState_Texas,
    kState_Utah,
    kState_Vermont,
    kState_Virginia,
    kState_Washington,
    kState_WestVerginia,
    kState_Wisconsin,
    kState_Wyoming,
};


@interface ResourceUtil : NSObject

+ (NSImage *) getImage:(NSString *) imageName withType:(NSString *) type;

@end
