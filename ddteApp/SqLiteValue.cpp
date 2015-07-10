//
//  SqLiteValue.cpp
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/10/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#include "SqLiteValue.h"

namespace SqLite {

Value::Value(sqlite3_stmt *statement, int index) :
    fStmt(statement), fIndex(index), fType(SqType_NULL)
{
        
}
    
Value::~Value() noexcept // nothrow
{
     // All are weak pointers and they will be released from other classes.
}

const char* Value::getTitle() const noexcept // nothrow
{
    return sqlite3_column_name(fStmt, fIndex);
}
    
// Return the integer value of the column specified by its index starting at 0
int Value::getInt() const noexcept // nothrow
{
    return sqlite3_column_int(fStmt, fIndex);
}
    
// Return the 64bits integer value of the column specified by its index starting at 0
sqlite3_int64 Value::getInt64() const noexcept // nothrow
{
    return sqlite3_column_int64(fStmt, fIndex);
}
    
// Return the double value of the column specified by its index starting at 0
double Value::getDouble() const noexcept // nothrow
{
    return sqlite3_column_double(fStmt, fIndex);
}

// Return a pointer to the text value (NULL terminated string) of the column specified by its index starting at 0
const char* Value::getText(const char* apDefaultValue /* = "" */) const noexcept // nothrow
{
    const char* pText = reinterpret_cast<const char*>(sqlite3_column_text(fStmt, fIndex));
    return (pText?pText:apDefaultValue);
}
    
// Return a pointer to the blob of the column specified by its index starting at 0
const void* Value::getBlob() const noexcept // nothrow
{
        return sqlite3_column_blob(fStmt, fIndex);
}
    
// Return the type of the value of the column
SqType Value::getType() const noexcept // nothrow
{
    return (SqType) sqlite3_column_type(fStmt, fIndex);
}
    
// Return the number of bytes used by the text value of the column
int Value::getBytes() const noexcept // nothrow
{
        return sqlite3_column_bytes(fStmt, fIndex);
}
    
}