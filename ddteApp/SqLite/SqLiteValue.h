//
//  SqLiteValue.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/10/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#ifndef __ddteApp__SqLiteValue__
#define __ddteApp__SqLiteValue__

#include <iostream>
#include <sqlite3.h>

/*
 ** CAPI3REF: Fundamental Datatypes
 ** KEYWORDS: SQLITE_TEXT
 **
 ** ^(Every value in SQLite has one of five fundamental datatypes:
 **
 ** <ul>
 ** <li> 64-bit signed integer
 ** <li> 64-bit IEEE floating point number
 ** <li> string
 ** <li> BLOB
 ** <li> NULL
 ** </ul>)^
 **
 ** These constants are codes for each of those types.
 **
 ** Note that the SQLITE_TEXT constant was also used in SQLite version 2
 ** for a completely different meaning.  Software that links against both
 ** SQLite version 2 and SQLite version 3 should use SQLITE3_TEXT, not
 ** SQLITE_TEXT.
 */
// The following types are defined in sqlite3.h
/*
#define SQLITE_INTEGER  1
#define SQLITE_FLOAT    2
#define SQLITE_BLOB     4
#define SQLITE_NULL     5
#ifdef SQLITE_TEXT
# undef SQLITE_TEXT
#else
# define SQLITE_TEXT     3
#endif
#define SQLITE3_TEXT     3
*/

namespace SqLite {

typedef enum {
    SqType_INTEGER  = SQLITE_INTEGER,
    SqType_FLOAT    = SQLITE_FLOAT,
    SqType_BLOB     = SQLITE_BLOB,
    SqType_NULL     = SQLITE_NULL,
    SqType_TEXT     = SQLITE_TEXT,
} SqType;

class Value
{
public:
    Value(sqlite3_stmt *statement, int index);
    virtual ~Value() noexcept; // nothrow

    /**
     * @brief Return a pointer to the table column name
     *
     * @see getOriginName() to get original column name (not aliased)
     */
    const char* getTitle() const noexcept; // nothrow
    
    /// @brief Return the integer value of the column.
    int             getInt() const noexcept; // nothrow
    /// @brief Return the 64bits integer value of the column.
    sqlite3_int64   getInt64() const noexcept; // nothrow
    /// @brief Return the double (64bits float) value of the column.
    double getDouble() const noexcept; // nothrow
    /**
     * @brief Return a pointer to the text value (NULL terminated string) of the column.
     *
     * @warning The value pointed at is only valid while the statement is valid (ie. not finalized),
     *          thus you must copy it before using it beyond its scope (to a std::string for instance).
     */
    const char* getText(const char* apDefaultValue = "") const noexcept; // nothrow
    /**
     * @brief Return a pointer to the binary blob value of the column.
     *
     * @warning The value pointed at is only valid while the statement is valid (ie. not finalized),
     *          thus you must copy it before using it beyond its scope (to a std::string for instance).
     */
    const void* getBlob() const noexcept; // nothrow
    
    /**
     * @brief Return the type of the value of the column
     *
     * Return either SQLITE_INTEGER, SQLITE_FLOAT, SQLITE_TEXT, SQLITE_BLOB, or SQLITE_NULL.
     *
     * @warning After a type conversion (by a call to a getXxx on a Column of a Yyy type),
     *          the value returned by sqlite3_column_type() is undefined.
     */
    SqType getType() const noexcept; // nothrow
    
    int getBytes() const noexcept; // nothrow
    
    /// @brief Test if the column is an integer type value (meaningful only before any conversion)
    inline bool isInteger() const noexcept // nothrow
    {
        return (getType() == SqType_INTEGER);
    }
    /// @brief Test if the column is a floating point type value (meaningful only before any conversion)
    inline bool isFloat() const noexcept // nothrow
    {
        return (getType() == SqType_FLOAT);
    }
    /// @brief Test if the column is a text type value (meaningful only before any conversion)
    inline bool isText() const noexcept // nothrow
    {
        return (getType() == SqType_TEXT);
    }
    /// @brief Test if the column is a binary blob type value (meaningful only before any conversion)
    inline bool isBlob() const noexcept // nothrow
    {
        return (getType() == SqType_BLOB);
    }
    /// @brief Test if the column is NULL (meaningful only before any conversion)
    inline bool isNull() const noexcept // nothrow
    {
        return (getType() == SqType_NULL);
    }

private:
    sqlite3_stmt    *fStmt;
    int             fIndex;
    SqType          fType;
};

}
#endif /* defined(__ddteApp__SqLiteValue__) */
