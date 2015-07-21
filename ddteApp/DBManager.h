//
//  DBManager.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/2/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

- (instancetype) initWithDatabaseFilename:(NSString *) dbFilename;
- (NSArray *) loadDataFromDB:(NSString *) query;
- (void) executeQuery:(NSString *) query;

- (void) printTable:(int) maxRow;

@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

@end
