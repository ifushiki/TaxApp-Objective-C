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
NSPopUpButton * createPopupButton(NSRect parentsBounds, float x1, float y1, float x2, float y2);

@interface ResourceUtil : NSObject

+ (NSImage *) getImage:(NSString *) imageName withType:(NSString *) type;

@end
