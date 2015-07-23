//
//  W2FormHandler.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/17/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "W2FormTypes.h"

@interface W2FormManager : NSObject

+ (id) sharedMgr;

- (W2Error) setDataString:(NSString *) str withFormDataID:(W2FormDataID) dataID;
- (W2Error) setFormString:(NSString *) str withFormDataID:(W2FormDataID) dataID at:(CGPoint) topLeftPt;
- (NSString *) getFormString:(W2FormDataID) dataID;

- (W2Error) setDataSelection:(int) selectedID withFormDataID:(W2FormDataID) dataID;
- (W2Error) setFormSelection:(int) selectedID withFormDataID:(W2FormDataID) dataID at:(CGPoint) topLeftPt;
- (int) getFormSelection:(W2FormDataID) dataID;

- (W2Error) setDataCheckBoxStatus:(NSInteger) status withFormDataID:(W2FormDataID) dataID;
- (W2Error) setFormCheckBoxStatus:(NSInteger) status withFormDataID:(W2FormDataID) dataID at:(CGPoint) topLeftPt;
- (NSInteger) getFormCheckBoxStatus:(W2FormDataID) dataID;

- (NSString *) getErrorMessage;

- (void) setOccupationString:(NSString *) str;


@end
