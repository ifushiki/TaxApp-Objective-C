//
//  W2FormManager.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/17/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#include <iostream>
#import "W2FormManager.h"
#import "W2FormData.h"
#import "AppDelegate.h"

@interface W2FormManager()
{
    W2FormData data;
}

@end

@implementation W2FormManager

+ (id) sharedMgr {
    static W2FormManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}


- (NSString *) getErrorMessage
{
    NSString *errorMessage = [NSString stringWithCString:data.getErrorMessage().c_str()
                                                encoding:[NSString defaultCStringEncoding]];
    
    return errorMessage;
}

- (W2Error) setFormString:(NSString *) str withFormDataID:(W2FormDataID) dataID
{
    std::string str1([str UTF8String]);
    W2Error success = data.setField(str1, dataID);
    
    if (success == kW2Error_Warning) {
        [AppDelegate showWarning:[self getErrorMessage]];
    }
    
    return success;
}

- (NSString *) getFormString:(W2FormDataID) dataID
{
    std::string str = data.getField(dataID);
    NSString *nsStr = [NSString stringWithUTF8String:str.c_str()];

    return nsStr;
}

- (W2Error) setFormSelection:(int) selectedID withFormDataID:(W2FormDataID) dataID
{
    W2Error success = data.setSelection(selectedID, dataID);
    
    if (success == kW2Error_Warning) {
        [AppDelegate showWarning:[self getErrorMessage]];
    }
    
    return success;
}

- (int) getFormSelection:(W2FormDataID) dataID
{
    return data.getSelection(dataID);
}

- (W2Error) setFormCheckBoxStatus:(NSInteger) status withFormDataID:(W2FormDataID) dataID
{
    W2Error success = data.setCheckBoxStatus((CheckBoxStatus) status, dataID);
    
    if (success == kW2Error_Warning) {
        [AppDelegate showWarning:[self getErrorMessage]];
    }
    
    return success;
}

- (NSInteger) getFormCheckBoxStatus:(W2FormDataID) dataID
{
    CheckBoxStatus status = data.getFormCheckBoxStatus(dataID);

    return (NSInteger) status;
}

@end
