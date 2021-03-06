//
//  DBManager.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/2/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import <iostream>
#import <vector>
#import <sqlite3.h>
#import "DBManager.h"
#import "SqLite.h"

// Obtain the dma code.
std::string getDMACode(std::string& zipCode)
{
    std::vector<std::string> rowList;
    std::string query = "select dma_id from zip_dma where zip = '" + zipCode + "'";
    
    try {
        DBManager *dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ddte-client.sqlite3"];
        NSString *nsQuery = [NSString stringWithUTF8String:query.c_str()];;
        [dbManager loadDataFromDB:nsQuery withList:rowList];
        std::cout << "column count = " << rowList.size() << std::endl;
        for(int i = 0; i < rowList.size(); i++)
        {
            std::cout << rowList[i] << ", ";
        }
        std::cout << std::endl;

    } catch (...) {
        // Notify the exception
        std::cout << "Exception in getDMACode()";
    }
    
    if (rowList.size() > 0) {
        return rowList[0];
    }
    else
        return "";
}

// Obtains the outlier range from geo table.
void getRangeFromGeo(std::vector<std::string>& rowList, const std::string& dmaCode, const std::string& w2Field)
{
    std::string query = "select pct2,pct98 from ddte_1d_geo where geo = " + dmaCode + " and w2_field = '" + w2Field + "'";
                         
    try {
        DBManager* dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ddte-client.sqlite3"];
        NSString *nsQuery = [NSString stringWithUTF8String:query.c_str()];;
        [dbManager loadDataFromDB:nsQuery withList:rowList];
        std::cout << "column count = " << rowList.size() << std::endl;
        for(int i = 0; i < rowList.size(); i++)
        {
            std::cout << rowList[i] << ", ";
        }
        std::cout << std::endl;

    } catch (...) {
        // Notify the exception
        std::cout << "Exception in getRangeFromGeo()";
    }
}

// Obtains the outlier range from age table.
void getRangeFromAge(std::vector<std::string>& rowList, const std::string& ageBracket, const std::string& w2Field)
{
    std::string query = "select pct2,pct98 from ddte_1d_age where age_bracket = '" + ageBracket + "' and w2_field = '" + w2Field + "'";
    
    try {
        DBManager* dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ddte-client.sqlite3"];
        NSString *nsQuery = [NSString stringWithUTF8String:query.c_str()];
        [dbManager loadDataFromDB:nsQuery withList:rowList];
        std::cout << "column count = " << rowList.size() << std::endl;
        for(int i = 0; i < rowList.size(); i++)
        {
            std::cout << rowList[i] << ", ";
        }
        std::cout << std::endl;

    } catch (...) {
        // Notify the exception
        std::cout << "Exception in getRangeFromAge()";
    }
}

// Obtains the outlier range from occupation table.
void getRangeFromOccupation(std::vector<std::string>& rowList, const std::string& occupation, const std::string& w2Field)
{
    std::string query = "select pct2,pct98 from ddte_1d_occ where occupation = '" + occupation + "' and w2_field = '" + w2Field + "'";
    
    try {
        DBManager* dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ddte-client.sqlite3"];
        NSString *nsQuery = [NSString stringWithUTF8String:query.c_str()];
        [dbManager loadDataFromDB:nsQuery withList:rowList];
        std::cout << "column count = " << rowList.size() << std::endl;
        for(int i = 0; i < rowList.size(); i++)
        {
            std::cout << rowList[i] << ", ";
        }
        std::cout << std::endl;

    } catch (...) {
        // Notify the exception
        std::cout << "Exception in getRangeFromOccupation()";

    }
}

@interface DBManager()
@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *arrResults;
@property (nonatomic) std::vector<std::string> resultList;
@property (nonatomic) SqLite::Query *fQuery;

- (void) copyDatabaseIntoDocumentsDirectory;
- (void) clearArrays;

// C version
- (void) runQuery:(const char *) query isQueryExecutale:(BOOL) queryExecutable;
- (void) retrieveData:(sqlite3_stmt *) compiledStatement;
- (void) updateData:(sqlite3_stmt *)compiledStatement inDatabase:(sqlite3 *) sqlite3Database;

// C++ version
- (void) runQueryCpp:(const std::string&) query withList:(std::vector<std::string>&) rowList isQueryExecutale:(BOOL)queryExecutable;
- (void) retrieveDataCpp:(SqLite::Query*) query withList:(std::vector<std::string>&) rowList;
- (void) updateDataCpp:(SqLite::Query *) query inDatabase:(SqLite::Database *) database;


@end

@implementation DBManager

- (instancetype) initWithDatabaseFilename:(NSString *)dbFilename {
    self = [super init];
    if (self) {
        try {
            self.fQuery = NULL;

            // Set the document directory path to the documentsDirectory property.
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            self.documentsDirectory = [paths objectAtIndex:0];
            
            // Keep the databease file name.
            self.databaseFilename = dbFilename;
            
            // Copy the database file into the documents dirtry if necessary.
            [self copyDatabaseIntoDocumentsDirectory];

        } catch (...) {
            // Notify the exception
            std::cout << "Exception in initWithDatabaseFilename()";

        }
    }
    return self;
}

- (void) copyDatabaseIntoDocumentsDirectory {
    // Check if the database file exists in the documents directory.
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        NSString *resourceDir = [[NSBundle mainBundle] resourcePath];
        //The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [resourceDir stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

// This load the data from database.
- (void) retrieveData:(sqlite3_stmt *)compiledStatement {
    // Declare an array to keep the data for each fetched row.
    NSMutableArray *arrDataRow;
    
    // Loop through the results and add them to the results array row by row.
    while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
        // Initialize the mutable array that will contain the data of a fetched row.
        arrDataRow = [NSMutableArray new];
        
        // Get the total number of columns.
        int totalColumns = sqlite3_column_count(compiledStatement);
        
        // Go through all columns and fetch each column data.
        for (int i=0; i<totalColumns; i++){
            // Convert the column data to text (characters).
            char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
            
            // If there are contents in the currenct column (field) then add them to the current row array.
            if (dbDataAsChars != NULL) {
                // Convert the characters to string.
                [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
            }
            
            // Keep the current column name.
            if (self.arrColumnNames.count != totalColumns) {
                dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
            }
        }
        
        // Store each fetched data row in the results array, but first check if there is actually data.
        if (arrDataRow.count > 0) {
            [self.arrResults addObject:arrDataRow];
        }
    }
}

// This load the data from database.
- (void) retrieveDataCpp0:(SqLite::Query*) query {
    // Declare an array to keep the data for each fetched row.
    if (query) {
        [self retrieveData:query->getStatment()];
    }
}

// This load the data from database.
- (void) retrieveDataCpp:(SqLite::Query*) query withList:(std::vector<std::string>&) rowList {

    try {
        self.fQuery = query;
        query->retrieveData();
        query->printTable(10, rowList);
        if (rowList.size() > 0)
            std::cout << "rowList = " << rowList[0] << std::endl;

    } catch (...) {
        // Notify the exception
        std::cout << "Exception in retrieveDataCpp()";
    }
    
}

- (SqLite::Query *) getSqLiteQuery
{
    return self.fQuery;
}

// This inserts or updates the database.
- (void) updateData:(sqlite3_stmt *)compiledStatement inDatabase:(sqlite3 *) sqlite3Database
{
    // Execute the query.
    BOOL executeQueryResults = sqlite3_step(compiledStatement);
    if (executeQueryResults == SQLITE_DONE) {
        // Keep the affected rows.
        self.affectedRows = sqlite3_changes(sqlite3Database);
        
        // Keep the last inserted row ID.
        self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
    }
    else {
        // If could not execute the query show the error message on the debugger.
        NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
    }
}

// This inserts or updates the database.
- (void) updateDataCpp:(SqLite::Query *) query inDatabase:(SqLite::Database *) database
{
    if (query && database) {
        [self updateData:query->getStatment() inDatabase:database->getDBHandle()];
    }
}

// Clear internal arrays
- (void) clearArrays {
    // Initialize the results array.
    if (self.arrResults != nil) {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
    }
    self.arrResults = [NSMutableArray new];
    
    // Initialize the column names array.
    if (self.arrColumnNames != nil) {
        [self.arrColumnNames removeAllObjects];
        self.arrColumnNames = nil;
    }
    self.arrColumnNames = [NSMutableArray new];
}

- (void) runQuery:(const char *)query isQueryExecutale:(BOOL)queryExecutable {
    // Set the database file path.
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    // Clear internal arrays
    [self clearArrays];
    
    // Create a sqlite object.
    // Open the database.
    sqlite3 *sqlite3Database;
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);

    if(openDatabaseResult == SQLITE_OK) {
        // Declare a sqlite3_stmt object in which will be stored the query after having been compiled into a SQLite statement.
        sqlite3_stmt *compiledStatement;
        
        // Load all data from database to memory.
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        if(prepareStatementResult == SQLITE_OK) {
            // Check if the query is non-executable.
            if (!queryExecutable){
                // In this case data must be loaded from the database.
                [self retrieveData:compiledStatement];

            }
            else {
                // This is the case of an executable query (insert, update, ...).
                [self updateData:compiledStatement inDatabase:sqlite3Database];
            }
        }
        else {
            // In the database cannot be opened then show the error message on the debugger.
            NSLog(@"%s", sqlite3_errmsg(sqlite3Database));
        }
        
        // Release the compiled statement from memory.
        sqlite3_finalize(compiledStatement);
        
    }
    
    // Close the database.
    sqlite3_close(sqlite3Database);
}

- (void) runQueryCpp:(const std::string&) query withList:(std::vector<std::string>&) rowList isQueryExecutale:(BOOL)queryExecutable {
    try {
        // Set the database file path.
        NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
        
        // Clear internal arrays
        [self clearArrays];
        
        // Create a sqlite object.
        // Open the database.
        std::string dbFilename = [databasePath UTF8String];
        SqLite::Database database(dbFilename);
        database.setQuery(query);
        
        if (!queryExecutable){
            // In this case data must be loaded from the database.
            [self retrieveDataCpp:database.getQuery() withList:rowList];
            
        }
        else {
            // This is the case of an executable query (insert, update, ...).
            [self updateDataCpp:database.getQuery() inDatabase:&database];
        }

    } catch (...) {
        // Notify the exception
        std::cout << "Exception in runQueryCpp()";
    }
    
}

- (void) loadDataFromDB:(NSString *)query withList:(std::vector<std::string>&) rowList
{
    // Run the query and indicate that it is not executable.
    // The query string is converted to a char* obect.
    [self runQueryCpp:[query UTF8String] withList:rowList isQueryExecutale:NO];
    
    // Return the loaded results.
//    return (NSArray *) self.arrResults;
}

- (void) executeQuery:(NSString *)query {
    // Run the query and indicate that it is executable.
    std::vector<std::string>  rowList;
    [self runQueryCpp:[query UTF8String] withList:rowList isQueryExecutale:YES];
}

@end
