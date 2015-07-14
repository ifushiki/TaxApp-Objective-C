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
