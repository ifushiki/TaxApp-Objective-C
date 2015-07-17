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
#include "SqLiteException.h"

namespace SqLite {
    
    // Compile and register the SQL query for the provided SQLite Database Connection
    Query::Query(sqlite3* dbHandle, const std::string& aQuery) :
    fDBHandle(dbHandle),
    fQueryStr(aQuery),
    fColumnCount(0),
    fOk(false),
    fDone(false)
    {
        sqlite3_stmt *statement;
        int result = sqlite3_prepare_v2(dbHandle, aQuery.c_str(), -1, &statement, NULL);
        
        if (result == SQLITE_OK) {
            fStmt = statement;
            fColumnCount = sqlite3_column_count(fStmt);
        }
    }
    
    // Finalize and unregister the SQL query from the SQLite Database Connection.
    Query::~Query() noexcept // nothrow
    {
        // the finalization will be done by the destructor of the last shared pointer
        if (fStmt != NULL) {
            sqlite3_finalize(fStmt);
            fStmt = NULL;
        }
        
        // fDBHandle is a weak pointer.  Query object will not release it.
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
                throw Exception(sqlite3_errmsg(fDBHandle));
            }
        }
        else
        {
            throw SqLite::Exception("Statement needs to be reseted.");
        }
        
        return fOk; // true only if one row is accessible by getColumn(N)
    }

    // Return a copy of the column data specified by its index starting at 0
    // (use the Column copy-constructor)
    Value Query::getColumnAtInex(const int aIndex)
    {
        checkRow();
        checkIndex(aIndex);
        
        // Share the Statement Object handle with the new Column created
        return Value(fStmt, aIndex);
    }
    
    // Return a copy of the column data specified by its column name starting at 0
    // (use the Column copy-constructor)
    Value Query::getColumnAtKey(const char* apName)
    {
        checkRow();
        
        if (fColumnNames.empty())
        {
            for (int i = 0; i < fColumnCount; ++i)
            {
                const char* pName = sqlite3_column_name(fStmt, i);
                fColumnNames[pName] = i;
            }
        }
        
        const TColumnNames::const_iterator iIndex = fColumnNames.find(apName);
        if (iIndex == fColumnNames.end())
        {
            throw Exception("Unknown column name.");
        }
        
        // Share the Statement Object handle with the new Column created
        return Value(fStmt, (*iIndex).second);
    }
    
    // Test if the column is NULL
    bool Query::isColumnNull(const int aIndex) const
    {
        checkRow();
        checkIndex(aIndex);
        return (sqlite3_column_type(fStmt, aIndex) == SqType_NULL);
    }
    
    // Return the named assigned to the specified result column (potentially aliased)
    const char* Query::getColumnName(const int aIndex) const
    {
        checkIndex(aIndex);
        return sqlite3_column_name(fStmt, aIndex);
    }
    
    // Reset the statement to make it ready for a new execution
    void Query::reset()
    {
        fOk = false;
        fDone = false;
        int result = sqlite3_reset(fStmt);
        checkResult(result);
    }
    
    // Clears away all the bindings of a prepared statement.
    void Query::clearBindings()
    {
        fOk = false;
        fDone = false;
        const int result = sqlite3_clear_bindings(fStmt);
        checkResult(result);
    }

    // Bind an int value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtIndex(const int aIndex, const int& aValue)
    {
        const int result = sqlite3_bind_int(fStmt, aIndex, aValue);
        checkResult(result);
    }
    
    // Bind a 64bits int value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtIndex(const int aIndex, const sqlite3_int64& aValue)
    {
        const int result = sqlite3_bind_int64(fStmt, aIndex, aValue);
        checkResult(result);
    }
    
    // Bind a double (64bits float) value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtIndex(const int aIndex, const double& aValue)
    {
        const int result = sqlite3_bind_double(fStmt, aIndex, aValue);
        checkResult(result);
    }
    
    // Bind a string value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtIndex(const int aIndex, const std::string& aValue)
    {
        const int result = sqlite3_bind_text(fStmt, aIndex, aValue.c_str(),
                                          static_cast<int>(aValue.size()), SQLITE_TRANSIENT);
        checkResult(result);
    }
    
    // Bind a binary blob value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtIndex(const int aIndex, const void* apValue, const int aSize)
    {
        const int result = sqlite3_bind_blob(fStmt, aIndex, apValue, aSize, SQLITE_TRANSIENT);
        checkResult(result);
    }
    
    // Bind a NULL value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::unbindAtIndex(const int aIndex)
    {
        const int result = sqlite3_bind_null(fStmt, aIndex);
        checkResult(result);
    }
    
    
    // Bind an int value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtKey(const std::string& aName, const int& aValue)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_int(fStmt, index, aValue);
        checkResult(result);
    }
    
    // Bind a 64bits int value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtKey(const std::string& aName, const sqlite3_int64& aValue)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_int64(fStmt, index, aValue);
        checkResult(result);
    }
    
    // Bind a double (64bits float) value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtKey(const std::string& aName, const double& aValue)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_double(fStmt, index, aValue);
        checkResult(result);
    }
    
    // Bind a string value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtKey(const std::string& aName, const std::string& aValue)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_text(fStmt, index, aValue.c_str(),
                                          static_cast<int>(aValue.size()), SQLITE_TRANSIENT);
        checkResult(result);
    }
    
    // Bind a binary blob value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::bindAtKey(const std::string& aName, const void* apValue, const int aSize)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_blob(fStmt, index, apValue, aSize, SQLITE_TRANSIENT);
        checkResult(result);
    }
    
    // Bind a NULL value to a parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement
    void Query::unbindAtKey(const std::string& aName)
    {
        const int index = sqlite3_bind_parameter_index(fStmt, aName.c_str());
        const int result = sqlite3_bind_null(fStmt, index);
        checkResult(result);
    }
}