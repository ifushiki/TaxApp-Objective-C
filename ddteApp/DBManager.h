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

std::string getDMACode(std::string& zipCode);
void getRangeFromGeo(std::vector<std::string>& rowList, std::string& dmaCode, std::string& w2Field);
void getRangeFromAge(std::vector<std::string>& rowList, std::string& ageBracket, std::string& w2Field);
void getRangeFromOccupation(std::vector<std::string>& rowList, std::string& occupation, std::string& w2Field);

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
