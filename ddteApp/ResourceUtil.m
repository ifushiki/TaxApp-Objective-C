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

// This returns the origin relative to the containing window.
CGPoint getOrigin(NSView *view)
{
    CGPoint pt;
    NSRect frameRelativeToWindow = [view convertRect:view.bounds toView:nil];
    pt = frameRelativeToWindow.origin;
    
    return pt;
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

// Create a checkbox with the given boundary (in topLeft corner as zero).
NSButton * createCheckBox(NSRect parentsBounds, float x1, float y1, float x2, float y2)
{
    NSRect rect;
    rect.size.width = x2 - x1;
    rect.size.height = y2 - y1;
    rect.origin.x = x1;
    rect.origin.y = parentsBounds.size.height - y2;
    NSButton *checkBox = [[NSButton alloc] initWithFrame:rect];
    [checkBox setButtonType:NSSwitchButton];    // Set to the check box type.
    [checkBox setBezelStyle:0];
    [checkBox setTitle:@""];
    [checkBox setState:NSOffState];
    
    return checkBox;
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

// Adds State Abbreviation codes to the given popup menu.
void addOccupationsToPopUpMenu(NSPopUpButton *popupButton)
{
    [popupButton addItemWithTitle: @"Select an occupation"];
    [popupButton addItemWithTitle: @"accounting supervisor"];
    [popupButton addItemWithTitle: @"art conservator"];
    [popupButton addItemWithTitle: @"art teacher"];
    [popupButton addItemWithTitle: @"auto body technician"];
    [popupButton addItemWithTitle: @"banquet chef"];
    [popupButton addItemWithTitle: @"billing representative"];
    [popupButton addItemWithTitle: @"bryologist"];
    [popupButton addItemWithTitle: @"budget analyst"];
    [popupButton addItemWithTitle: @"bus driver"];
    [popupButton addItemWithTitle: @"car washer"];
    [popupButton addItemWithTitle: @"chief executive officer"];
    [popupButton addItemWithTitle: @"child care worker"];
    [popupButton addItemWithTitle: @"claims processor"];
    [popupButton addItemWithTitle: @"cleaning service"];
    [popupButton addItemWithTitle: @"clinic director"];
    [popupButton addItemWithTitle: @"courtroom clerk"];
    [popupButton addItemWithTitle: @"debt collector"];
    [popupButton addItemWithTitle: @"defense contractor"];
    [popupButton addItemWithTitle: @"deli"];
    [popupButton addItemWithTitle: @"dental office manager"];
    [popupButton addItemWithTitle: @"detention deputy"];
    [popupButton addItemWithTitle: @"diabetes educator"];
    [popupButton addItemWithTitle: @"diesel technician"];
    [popupButton addItemWithTitle: @"dog bather"];
    [popupButton addItemWithTitle: @"drywall hanger"];
    [popupButton addItemWithTitle: @"dsp"];
    [popupButton addItemWithTitle: @"electrical drafter"];
    [popupButton addItemWithTitle: @"elevator constructor"];
    [popupButton addItemWithTitle: @"facility manager"];
    [popupButton addItemWithTitle: @"financial"];
    [popupButton addItemWithTitle: @"food scientist"];
    [popupButton addItemWithTitle: @"funeral arranger"];
    [popupButton addItemWithTitle: @"gis specialist"];
    [popupButton addItemWithTitle: @"hospice social worker"];
    [popupButton addItemWithTitle: @"hostess"];
    [popupButton addItemWithTitle: @"hr assistant"];
    [popupButton addItemWithTitle: @"independent consultant"];
    [popupButton addItemWithTitle: @"inside sales rep"];
    [popupButton addItemWithTitle: @"law enforcement"];
    [popupButton addItemWithTitle: @"limousine driver"];
    [popupButton addItemWithTitle: @"logistics planner"];
    [popupButton addItemWithTitle: @"lpta"];
    [popupButton addItemWithTitle: @"maintenance manager"];
    [popupButton addItemWithTitle: @"maintenance supervisor"];
    [popupButton addItemWithTitle: @"maintenance technician"];
    [popupButton addItemWithTitle: @"mason"];
    [popupButton addItemWithTitle: @"material expediter"];
    [popupButton addItemWithTitle: @"medical scientist"];
    [popupButton addItemWithTitle: @"meteorologist"];
    [popupButton addItemWithTitle: @"municipal clerk"];
    [popupButton addItemWithTitle: @"neurologist"];
    [popupButton addItemWithTitle: @"occ"];
    [popupButton addItemWithTitle: @"parking attendant"];
    [popupButton addItemWithTitle: @"payroll clerk"];
    [popupButton addItemWithTitle: @"pharmacist technician"];
    [popupButton addItemWithTitle: @"pharmacy assistant"];
    [popupButton addItemWithTitle: @"phlebotomist"];
    [popupButton addItemWithTitle: @"port captain"];
    [popupButton addItemWithTitle: @"prison guard"];
    [popupButton addItemWithTitle: @"production"];
    [popupButton addItemWithTitle: @"production engineer"];
    [popupButton addItemWithTitle: @"professor"];
    [popupButton addItemWithTitle: @"radiologist"];
    [popupButton addItemWithTitle: @"radiology technologist"];
    [popupButton addItemWithTitle: @"risk management"];
    [popupButton addItemWithTitle: @"rn"];
    [popupButton addItemWithTitle: @"sahm"];
    [popupButton addItemWithTitle: @"sales person"];
    [popupButton addItemWithTitle: @"school bus mechanic"];
    [popupButton addItemWithTitle: @"security manager"];
    [popupButton addItemWithTitle: @"service"];
    [popupButton addItemWithTitle: @"sheet metal worker"];
    [popupButton addItemWithTitle: @"shipper"];
    [popupButton addItemWithTitle: @"software architect"];
    [popupButton addItemWithTitle: @"software programmer"];
    [popupButton addItemWithTitle: @"software tester"];
    [popupButton addItemWithTitle: @"songwriter"];
    [popupButton addItemWithTitle: @"sous chef"];
    [popupButton addItemWithTitle: @"specialist"];
    [popupButton addItemWithTitle: @"state employee"];
    [popupButton addItemWithTitle: @"teacher aide"];
    [popupButton addItemWithTitle: @"team leader"];
    [popupButton addItemWithTitle: @"tool maker"];
    [popupButton addItemWithTitle: @"township clerk"];
    [popupButton addItemWithTitle: @"truckdriver"];
    [popupButton addItemWithTitle: @"veterinary assistant"];
    [popupButton addItemWithTitle: @"volunteer coordinator"];
    [popupButton addItemWithTitle: @"xray tech"];
}
