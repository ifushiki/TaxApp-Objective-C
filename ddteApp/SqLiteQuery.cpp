//
//  SqLiteQuery.cpp
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/9/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#include <iostream>
#include <assert.h>
#include <sqlite3.h>
#include "SqLiteQuery.h"

namespace SqLite {
    
    // Compile and register the SQL query for the provided SQLite Database Connection
    Query::Query(Database &database, const std::string& aQuery) :
    fQueryStr(aQuery),
    fColumnCount(0),
    fOk(false),
    fDone(false)
    {
        sqlite3_stmt *statement;
        int result = sqlite3_prepare_v2(database.fSQLite, aQuery.c_str(), -1, &statement, NULL);
        
        if (result == SQLITE_OK) {
            fStmt = statement;
            fColumnCount = sqlite3_column_count(fStmt);
        }
    }
    
    // Finalize and unregister the SQL query from the SQLite Database Connection.
    Query::~Query() noexcept // nothrow
    {
        // the finalization will be done by the destructor of the last shared pointer
    }

    // Execute a step of the query to fetch one row of results
    bool Query::nextRow()
    {
        if (fDone == false)
        {
            const int result = sqlite3_step(fStmt);
            if (result == SQLITE_ROW) // one row is ready : call getColumn(N) to access it
            {
                fOk = true;
            }
            else if (result == SQLITE_DONE) // no (more) row ready : the query has finished executing
            {
                fOk = false;
                fDone = true;
            }
            else
            {
                fOk = false;
                fDone = false;
//                throw SqLite::Exception(sqlite3_errmsg(fStmt.get()));
            }
        }
        else
        {
//            throw SqLite::Exception("Statement needs to be reseted.");
        }
        
        return fOk; // true only if one row is accessible by getColumn(N)
    }

    
    // Reset the statement to make it ready for a new execution
    void Query::reset()
    {
        fOk = false;
        fDone = false;
        int result = sqlite3_reset(fStmt);
        assert( result == SQLITE_OK);
    }
    
    // Clears away all the bindings of a prepared statement.
    void Query::clearBindings()
    {
        fOk = false;
        fDone = false;
        const int result = sqlite3_clear_bindings(fStmt);
        assert( result == SQLITE_OK);
    }

    // Bind an int value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtIndex(const int aIndex, const int& aValue)
    {
        const int result = sqlite3_bind_int(fStmt, aIndex, aValue);
        assert(result == SQLITE_OK);
    }
    
    // Bind a 64bits int value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtIndex(const int aIndex, const sqlite3_int64& aValue)
    {
        const int result = sqlite3_bind_int64(fStmt, aIndex, aValue);
        assert(result == SQLITE_OK);
    }
    
    // Bind a double (64bits float) value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtIndex(const int aIndex, const double& aValue)
    {
        const int result = sqlite3_bind_double(fStmt, aIndex, aValue);
        assert(result == SQLITE_OK);
    }
    
    // Bind a string value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtIndex(const int aIndex, const std::string& aValue)
    {
        const int result = sqlite3_bind_text(fStmt, aIndex, aValue.c_str(),
                                          static_cast<int>(aValue.size()), SQLITE_TRANSIENT);
        assert(result == SQLITE_OK);
    }
    
    // Bind a binary blob value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtIndex(const int aIndex, const void* apValue, const int aSize)
    {
        const int result = sqlite3_bind_blob(fStmt, aIndex, apValue, aSize, SQLITE_TRANSIENT);
        assert(result == SQLITE_OK);
    }
    
    // Bind a NULL value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::unbindAtIndex(const int aIndex)
    {
        const int result = sqlite3_bind_null(fStmt, aIndex);
        assert(result == SQLITE_OK);
    }
    
    
    // Bind an int value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtKey(const std::string& aName, const int& aValue)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_int(fStmt, index, aValue);
        assert(result == SQLITE_OK);
    }
    
    // Bind a 64bits int value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtKey(const std::string& aName, const sqlite3_int64& aValue)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_int64(fStmt, index, aValue);
        assert(result == SQLITE_OK);
    }
    
    // Bind a double (64bits float) value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtKey(const std::string& aName, const double& aValue)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_double(fStmt, index, aValue);
        assert(result == SQLITE_OK);
    }
    
    // Bind a string value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtKey(const std::string& aName, const std::string& aValue)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_text(fStmt, index, aValue.c_str(),
                                          static_cast<int>(aValue.size()), SQLITE_TRANSIENT);
        assert(result == SQLITE_OK);
    }
    
    // Bind a binary blob value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtKey(const std::string& aName, const void* apValue, const int aSize)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_blob(fStmt, index, apValue, aSize, SQLITE_TRANSIENT);
        assert(result == SQLITE_OK);
    }
    
    // Bind a NULL value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::unbindAtKey(const std::string& aName)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_null(fStmt, index);
        assert(result == SQLITE_OK);
    }
}