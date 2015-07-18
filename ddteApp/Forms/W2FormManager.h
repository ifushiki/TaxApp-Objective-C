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

- (BOOL) setFormString:(NSString *) str withFormDataID:(W2FormDataID) dataID;
- (NSString *) getFormString:(W2FormDataID) dataID;

@end
