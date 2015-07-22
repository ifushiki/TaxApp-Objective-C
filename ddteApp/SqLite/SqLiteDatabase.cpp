//
//  SqLiteDatabase.cpp
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/8/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//


#include <assert.h>
#include "SqLiteException.h"
#include "SqLiteDatabase.h"
#include "SqLiteQuery.h"

namespace SqLite {

Database::Database(const std::string& apFilename) :
    fSQLite(NULL),
    fFilename(apFilename),
    fQuery(NULL)
{
    const int ret = sqlite3_open(apFilename.c_str(), &fSQLite);
    if (ret != SQLITE_OK)
    {
        std::string strerr = sqlite3_errmsg(fSQLite);
        sqlite3_close(fSQLite); // close is required even in case of error on opening
        throw Exception(strerr);
    }
    
}

// Close the SQLite database connection.
Database::~Database() noexcept // nothrow
{
    if (fQuery)
        delete fQuery;

    const int ret = sqlite3_close(fSQLite);
    assert(ret == SQLITE_OK);
    
    /*
    // Only case of error is SQLITE_BUSY: "database is locked" (some statements are not finalized)
    // Never throw an exception in a destructor :
    SQLITECPP_ASSERT(SQLITE_OK == ret, "database is locked");  // See SQLITECPP_ENABLE_ASSERT_HANDLER
     */
}

void Database::setQuery(const std::string& query)
{
    if (fQuery) {
        delete fQuery;
        fQuery = NULL;
    }
    fQuery = new Query(fSQLite, query);
}


#if 0
bool Database::tableExists(const std::string& aTableName)
{
    Query query(this->getDBHandle(), std::string("SELECT count(*) FROM sqlite_master WHERE type='table' AND name=?"));
    query.bindAtIndex(1, aTableName.c_str());
//    Query query(this->getDBHandle(), std::string("SELECT count(*) FROM sqlite_master WHERE type='table' AND name='zip_dma'"));
    (void)query.nextRow(); // Cannot return false, as the above query always return a result
    const int Nb = query.getColumnCount();
    return (1 == Nb);
}
    
    /*
    // Shortcut to execute one or multiple SQL statements without results (UPDATE, INSERT, ALTER, COMMIT, CREATE...).
int Database::exec(const char* apQueries)
{
    const int ret = sqlite3_exec(mpSQLite, apQueries, NULL, NULL, NULL);
    check(ret);
    
    // Return the number of rows modified by those SQL statements (INSERT, UPDATE or DELETE only)
    return sqlite3_changes(mpSQLite);
}
 */

// Shortcut to execute a one step query and fetch the first column of the result.
// WARNING: Be very careful with this dangerous method: you have to
// make a COPY OF THE result, else it will be destroy before the next line
// (when the underlying temporary Statement and Column objects are destroyed)
// this is an issue only for pointer type result (ie. char* and blob)
// (use the Column copy-constructor)
Column Database::execAndGet(const char* apQuery)
{
    Statement query(*this, apQuery);
    (void)query.executeStep(); // Can return false if no result, which will throw next line in getColumn()
    return query.getColumn(0);
}

// Shortcut to test if a table exists.
bool Database::tableExists(const char* apTableName)
{
    Statement query(*this, "SELECT count(*) FROM sqlite_master WHERE type='table' AND name=?");
    query.bind(1, apTableName);
    (void)query.executeStep(); // Cannot return false, as the above query always return a result
    const int Nb = query.getColumn(0);
    return (1 == Nb);
}
#endif

}
