//
//  DBManager.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/2/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iostream>
#import <vector>
#import <string>
#import "SqLite.h"
#import "SqLiteQuery.h"

@interface DBManager : NSObject

- (instancetype) initWithDatabaseFilename:(NSString *) dbFilename;
- (void) loadDataFromDB:(NSString *) query withList:(std::vector<std::string>&) rowList;
- (void) executeQuery:(NSString *) query;
//- (std::string&) getResultList;
- (SqLite::Query *) getSqLiteQuery;

@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

@end
