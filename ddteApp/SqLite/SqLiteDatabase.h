//
//  SqLiteDatabase.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/8/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#ifndef __ddteApp__SqLiteDatabase__
#define __ddteApp__SqLiteDatabase__

#include <iostream>
#include <sqlite3.h>
#include "SqLiteQuery.h"

namespace SqLite {
    class Database {
    public:

        /**
         * @brief Open the provided database UTF-8 filename.
         *
         * Uses sqlite3_open_v2() with readonly default flag, which is the opposite behavior
         * of the old sqlite3_open() function (READWRITE+CREATE).
         * This makes sense if you want to use it on a readonly filesystem
         * or to prevent creation of a void file when a required file is missing.
         *
         * Exception is thrown in case of error, then the Database object is NOT constructed.
         *
         * @param[in] aFilename         UTF-8 path/uri to the database file ("filename" sqlite3 parameter)
         * @param[in] aFlags            SQLITE_OPEN_READONLY/SQLITE_OPEN_READWRITE/SQLITE_OPEN_CREATE...
         *
         * @throw SQLite::Exception in case of error
         */
        Database(const std::string& apFilename);
        
        sqlite3* getDBHandle() {
            return fSQLite;
        }

         /**
         * @brief Close the SQLite database connection.
         *
         * All SQLite statements must have been finalized before,
         * so all Statement objects must have been unregistered.
         *
         * @warning assert in case of error
         */
        virtual ~Database() noexcept; // nothrow
        
        void setQuery(const std::string& query);
        Query* getQuery() const
        {
            return fQuery;
        }

        /**
         * @brief Shortcut to test if a table exists.
         *
         *  Table names are case sensitive.
         *
         * @param[in] aTableName an UTF-8 encoded case sensitive Table name
         *
         * @return true if the table exists.
         *
         * @throw SQLite::Exception in case of error
         */
//        bool tableExists(const std::string& aTableName);
        
        friend class Query;
    
private:
        sqlite3*    fSQLite;   //!< Pointer to SQLite Database Connection Handle
        std::string fFilename;  //!< UTF-8 filename used to open the database
        Query*      fQuery;     //! The current query.
    };
}

#endif /* defined(__ddteApp__SqLiteDatabase__) */
