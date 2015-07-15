//
//  ResourceUtil.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/14/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import "ResourceUtil.h"

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
