//
//  SqLiteQuery.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/9/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#ifndef __ddteApp__SqLiteQuery__
#define __ddteApp__SqLiteQuery__

#include <iostream>
#include <map>
#include <sqlite3.h>
#include "SqLiteDatabase.h"

namespace SqLite {

class Query {

public:
    /**
     * @brief Compile and register the SQL query for the provided SQLite Database Connection
     *
     * @param[in] aDatabase the SQLite Database Connection
     * @param[in] aQuery    an UTF-8 encoded query string
     *
     * Exception is thrown in case of error, then the Statement object is NOT constructed.
     */
    Query(Database &database, const std::string& aQuery);
    
    /**
     * @brief Finalize and unregister the SQL query from the SQLite Database Connection.
     */
    virtual ~Query() noexcept; // nothrow

    /**
     * @brief Reset the statement to make it ready for a new execution.
     */
    void reset();
    
    /**
     * @brief Clears away all the bindings of a prepared statement.
     *
     *  Contrary to the intuition of many, reset() does not reset
     * the bindings on a prepared statement.
     *  Use this routine to reset all parameters to NULL.
     */
    void clearBindings(); // throw(SQLite::Exception)
    
    ////////////////////////////////////////////////////////////////////////////
    // Bind a value to a parameter of the SQL statement,
    // in the form "?" (unnamed), "?NNN", ":VVV", "@VVV" or "$VVV".
    //
    // Can use the parameter index, starting from "1", to the higher NNN value,
    // or the complete parameter name "?NNN", ":VVV", "@VVV" or "$VVV"
    // (prefixed with the corresponding sign "?", ":", "@" or "$")
    //
    // Note that for text and blob values, the SQLITE_TRANSIENT flag is used,
    // which tell the sqlite library to make its own copy of the data before the bind() call returns.
    // This choice is done to prevent any common misuses, like passing a pointer to a
    // dynamic allocated and temporary variable (a std::string for instance).
    // This is under-optimized for static data (a static text define in code)
    // as well as for dynamic allocated buffer which could be transfer to sqlite
    // instead of being copied.
    
    /**
     * @brief Bind an int value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     */
    void bindAtIndex(const int aIndex, const int& aValue);
    /**
     * @brief Bind a 64bits int value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     */
    void bindAtIndex(const int aIndex, const sqlite3_int64& aValue);
    /**
     
     * @brief Bind a double (64bits float) value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     */
    void bindAtIndex(const int aIndex, const double& aValue);
    /**
     * @brief Bind a string value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     *
     * @note This uses the SQLITE_TRANSIENT flag, making a copy of the data, for SQLite internal use
     */
    void bindAtIndex(const int aIndex, const std::string& aValue);
    /**
     * @brief Bind a binary blob value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     *
     * @note This uses the SQLITE_TRANSIENT flag, making a copy of the data, for SQLite internal use
     */
    void bindAtIndex(const int aIndex, const void* apValue, const int aSize);
    /**
     * @brief Bind a NULL value to a parameter "?", "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     */
    void unbindAtIndex(const int aIndex);
    
    /**
     * @brief Bind an int value to a named parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     */
    void bindAtKey(const std::string& aName, const int& aValue);
     /**
     * @brief Bind a 64bits int value to a named parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     */
    void bindAtKey(const std::string& aName, const sqlite3_int64& aValue);
    /**
     * @brief Bind a double (64bits float) value to a named parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     */
    void bindAtKey(const std::string& aName, const double& aValue);
    /**
     * @brief Bind a string value to a named parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     *
     * @note This uses the SQLITE_TRANSIENT flag, making a copy of the data, for SQLite internal use
     */
    void bindAtKey(const std::string& aName, const std::string& aValue);
    /**
     * @brief Bind a text value to a named parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     *
     * @note This uses the SQLITE_TRANSIENT flag, making a copy of the data, for SQLite internal use
     */
    void bindAtKey(const std::string& aName, const void* apValue, const int aSize);
    /**
     * @brief Bind a NULL value to a named parameter "?NNN", ":VVV", "@VVV" or "$VVV" in the SQL prepared statement (aIndex >= 1)
     */
    void unbindAtKey(const std::string& aName); // bind NULL value

    ////////////////////////////////////////////////////////////////////////////
    
    /**
     * @brief Execute a step of the prepared query to fetch one row of results.
     *
     *  While true is returned, a row of results is available, and can be accessed
     * thru the getColumn() method
     *
     * @see exec() execute a one-step prepared statement with no expected result
     * @see Database::exec() is a shortcut to execute one or multiple statements without results
     *
     * @return - true  (SQLITE_ROW)  if there is another row ready : you can call getColumn(N) to get it
     *                               then you have to call executeStep() again to fetch more rows until the query is finished
     *         - false (SQLITE_DONE) if the query has finished executing : there is no (more) row of result
     *                               (case of a query with no result, or after N rows fetched successfully)
     *
     * @throw SQLite::Exception in case of error
     */
    bool nextRow();


private:
    inline void check(const int result) const
    {
        if (result != SQLITE_OK)
        {
            //            throw Exception(sqlite3_errmsg(fStmt.get());
        }
    }

    typedef std::map<std::string, int> TColumnNames;
        
    private:
        std::string     fQueryStr;         //!< UTF-8 SQL Query
        sqlite3_stmt    *fStmt;       //!< Shared Pointer to the prepared SQLite Statement Object
        int             fColumnCount;   //!< Number of columns in the result of the prepared statement
        TColumnNames    fColumnNames;   //!< Map of columns index by name
        bool            fOk;           //!< true when a row has been fetched with executeStep()
        bool            fDone;         //!< true when the last executeStep() had no more row to fetch
};

}


#endif /* defined(__ddteApp__SqLiteQuery__) */
