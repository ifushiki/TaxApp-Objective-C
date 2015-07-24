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
#include <vector>
#include <map>
#include <sqlite3.h>
#include "SqLiteValue.h"
#include "SqLiteException.h"

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
    Query(sqlite3* dbHandle, const std::string& aQuery);
    
    /**
     * @brief Finalize and unregister the SQL query from the SQLite Database Connection.
     */
    virtual ~Query() noexcept; // nothrow
    
    sqlite3_stmt* getStatment() const {
        return fStmt;
    }
    
    int getColumnCount() const {
        return fColumnCount;
    }

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

    const char* getValueStringForIndex(const int index);
    const char* getValueStringForKey(const std::string& key);
    
    bool retrieveData();
    void printTable(int maxRow, std::vector<std::string> &rowList);
    std::string getTableValue(int i, int j);
    void getFirstRow(std::vector<std::string>& list);
    
    /**
     * @brief Return a copy of the column data specified by its index
     *
     *  Can be used to access the data of the current row of result when applicable,
     * while the executeStep() method returns true.
     *
     *  Throw an exception if there is no row to return a Column from:
     * - if provided index is out of bound
     * - before any executeStep() call
     * - after the last executeStep() returned false
     * - after a reset() call
     *
     *  Throw an exception if the specified index is out of the [0, getColumnCount()) range.
     *
     * @param[in] aIndex    Index of the column, starting at 0
     *
     * @note    This method is not const, reflecting the fact that the returned Column object will
     *          share the ownership of the underlying sqlite3_stmt.
     *
     * @warning The resulting Column object must not be memorized "as-is".
     *          Is is only a wrapper around the current result row, so it is only valid
     *          while the row from the Statement remains valid, that is only until next executeStep() call.
     *          Thus, you should instead extract immediately its data (getInt(), getText()...)
     *          and use or copy this data for any later usage.
     */
    Value  getColumnAtInex(const int aIndex);
    
    /**
     * @brief Return a copy of the column data specified by its column name (less efficient than using an index)
     *
     *  Can be used to access the data of the current row of result when applicable,
     * while the executeStep() method returns true.
     *
     *  Throw an exception if there is no row to return a Column from :
     * - if provided name is not one of the aliased column names
     * - before any executeStep() call
     * - after the last executeStep() returned false
     * - after a reset() call
     *
     *  Throw an exception if the specified name is not an on of the aliased name of the columns in the result.
     *
     * @param[in] apName   Aliased name of the column, that is, the named specified in the query (not the original name)
     *
     * @note    Uses a map of column names to indexes, build on first call.
     *
     * @note    This method is not const, reflecting the fact that the returned Column object will
     *          share the ownership of the underlying sqlite3_stmt.
     *
     * @warning The resulting Column object must not be memorized "as-is".
     *          Is is only a wrapper around the current result row, so it is only valid
     *          while the row from the Statement remains valid, that is only until next executeStep() call.
     *          Thus, you should instead extract immediately its data (getInt(), getText()...)
     *          and use or copy this data for any later usage.
     */
    Value  getColumnAtKey(const char* apName);
    
    /**
     * @brief Test if the column value is NULL
     *
     * @param[in] aIndex    Index of the column, starting at 0
     *
     * @return true if the column value is NULL
     *
     *  Throw an exception if the specified index is out of the [0, getColumnCount()) range.
     */
    bool isColumnNull(const int aIndex) const;
    
    /**
     * @brief Return a pointer to the named assigned to the specified result column (potentially aliased)
     *
     * @see getColumnOriginName() to get original column name (not aliased)
     *
     *  Throw an exception if the specified index is out of the [0, getColumnCount()) range.
     */
    const char* getColumnName(const int aIndex) const;


private:
    /**
     * @brief Check if a return code equals SQLITE_OK, else throw a SQLite::Exception with the SQLite error message
     *
     * @param[in] SQLite return code to test against the SQLITE_OK expected value
     */
    inline void checkResult(const int result) const
    {
        if (result != SQLITE_OK)
        {
            throw SqLite::Exception(sqlite3_errmsg(fDBHandle));
        }
    }
    
    /**
     * @brief Check if there is a row of result returnes by executeStep(), else throw a SQLite::Exception.
     */
    inline void checkRow() const
    {
        if (!fOk)
        {
            throw Exception("No row to get a column from. executeStep() was not called, or returned false.");
        }
    }
    
    /**
     * @brief Check if there is a Column index is in the range of columns in the result.
     */
    inline void checkIndex(const int aIndex) const
    {
        if ((aIndex < 0) || (aIndex >= fColumnCount))
        {
            throw Exception("Column index out of range.");
        }
    }

    typedef std::map<std::string, int> TColumnNames;
        
    private:
        sqlite3         *fDBHandle;     //! Database object.  This is a weak pointer and Query will not delete it.
        std::string     fQueryStr;      //!< UTF-8 SQL Query
        sqlite3_stmt    *fStmt;         //! the prepared SQLite Statement Object
        int             fColumnCount;   //!< Number of columns in the result of the prepared statement
        std::map<std::string, int>   fColumnNames;   //!< Map of columns index by name
        bool            fOk;           //!< true when a row has been fetched with executeStep()
        bool            fDone;         //!< true when the last executeStep() had no more row to fetch

        std::vector<std::vector<std::string> *> dataTable;
        std::vector<std::string> columnTitles;
};

}


#endif /* defined(__ddteApp__SqLiteQuery__) */
