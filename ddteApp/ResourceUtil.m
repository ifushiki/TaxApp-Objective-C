//
//  ResourceUtil.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/14/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import "ResourceUtil.h"
#import "W2FormTypes.h"

@implementation ResourceUtil

+ (NSImage *) getImage:(NSString *) imageName withType:(NSString *) type
{
    NSBundle* myBundle = [NSBundle mainBundle];
    NSString* imagePath = [myBundle pathForResource:imageName ofType:type];
    
    return [[NSImage alloc] initWithContentsOfFile:imagePath];
}

@end

NSTextField * createTextField(NSRect parentsBounds, float x1, float y1, float x2, float y2)
{
    NSRect rect;
    rect.size.width = x2 - x1;
    rect.size.height = y2 - y1;
    rect.origin.x = x1;
    rect.origin.y = parentsBounds.size.height - y2;
    NSTextField *textField = [[NSTextField alloc] initWithFrame:rect];
    
    return textField;
}

NSPopUpButton * createPopupButton(NSRect parentsBounds, float x1, float y1, float x2, float y2)
{
    NSRect rect;
    rect.size.width = x2 - x1;
    rect.size.height = y2 - y1;
    rect.origin.x = x1;
    rect.origin.y = parentsBounds.size.height - y2;
    NSPopUpButton *popupButton = [[NSPopUpButton alloc] initWithFrame:rect];
    
    return popupButton;
}

// Adds State Abbreviation codes to the given popup menu.
void addStatesToPopUpMenu(NSPopUpButton *popupButton)
{
    [popupButton addItemWithTitle: @"Select a state"];
    [popupButton addItemWithTitle: @"AL"];  // Alabama
    [popupButton addItemWithTitle: @"AK"];  // Alaska
    [popupButton addItemWithTitle: @"AZ"];  // Arizona
    [popupButton addItemWithTitle: @"AR"];  // Arkansas
    [popupButton addItemWithTitle: @"CA"];  // California
    [popupButton addItemWithTitle: @"CO"];  // Colorado
    [popupButton addItemWithTitle: @"CT"];  // Connecticut
    [popupButton addItemWithTitle: @"DE"];  // Delaware
    [popupButton addItemWithTitle: @"FL"];  // Florida
    [popupButton addItemWithTitle: @"GA"];  // Georgia

    [popupButton addItemWithTitle: @"HI"];  // Hawaii
    [popupButton addItemWithTitle: @"ID"];  // Idaho
    [popupButton addItemWithTitle: @"IL"];  // Illinois
    [popupButton addItemWithTitle: @"IN"];  // Indiana
    [popupButton addItemWithTitle: @"IA"];  // Iowa
    [popupButton addItemWithTitle: @"KS"];  // Kansas
    [popupButton addItemWithTitle: @"KY"];  // Kentucky
    [popupButton addItemWithTitle: @"LA"];  // Louisiana
    [popupButton addItemWithTitle: @"ME"];  // Maine
    [popupButton addItemWithTitle: @"MD"];  // Maryland
    
    [popupButton addItemWithTitle: @"MA"];  // Massachussetts
    [popupButton addItemWithTitle: @"MI"];  // Michigan
    [popupButton addItemWithTitle: @"MN"];  // Minnesota
    [popupButton addItemWithTitle: @"MS"];  // Mississippi
    [popupButton addItemWithTitle: @"MO"];  // Missouri
    [popupButton addItemWithTitle: @"MT"];  // Montana
    [popupButton addItemWithTitle: @"NE"];  // Nebraska
    [popupButton addItemWithTitle: @"NV"];  // Nevada
    [popupButton addItemWithTitle: @"NH"];  // New Hampshire
    [popupButton addItemWithTitle: @"NJ"];  // New Jersey
    
    [popupButton addItemWithTitle: @"NM"];  // New Mexico
    [popupButton addItemWithTitle: @"NY"];  // New York
    [popupButton addItemWithTitle: @"NC"];  // North Carolina
    [popupButton addItemWithTitle: @"ND"];  // North Dakoda
    [popupButton addItemWithTitle: @"OH"];  // Ohio
    [popupButton addItemWithTitle: @"OK"];  // Oklahoma
    [popupButton addItemWithTitle: @"OR"];  // Oregon
    [popupButton addItemWithTitle: @"PA"];  // Pennsylvania
    [popupButton addItemWithTitle: @"RI"];  // Rhodo Island
    [popupButton addItemWithTitle: @"SC"];  // South Carolina

    [popupButton addItemWithTitle: @"SD"];  // South Dakota
    [popupButton addItemWithTitle: @"TN"];  // Tennessee
    [popupButton addItemWithTitle: @"TX"];  // Texas
    [popupButton addItemWithTitle: @"UT"];  // Utah
    [popupButton addItemWithTitle: @"VT"];  // Vermont
    [popupButton addItemWithTitle: @"VA"];  // Virginia
    [popupButton addItemWithTitle: @"WA"];  // Washington
    [popupButton addItemWithTitle: @"WV"];  // West Verginia
    [popupButton addItemWithTitle: @"WI"];  // Wisconsin
    [popupButton addItemWithTitle: @"WY"];  // Wyoming
}
